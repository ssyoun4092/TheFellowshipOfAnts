//
//  SearchViewModel.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/16.
//

import Foundation

import TheFellowshipOfAntsKey
import RxCocoa
import RxSwift

final class SearchViewModel {
    let disposeBag = DisposeBag()

    let searchBarText =  PublishSubject<String>()
    let searchBarDidBeginEditing = PublishSubject<Void>()
    let searchBarDidEndEditing = PublishSubject<Void>()
    let searchItems =  BehaviorSubject<[SymbolSearchInfo]>(value: [])
    let shouldHideRecentSearchItems = PublishSubject<Bool>()

    init() {
        searchBarText
            .skip(1)
            .subscribe(onNext: { text in
                print(text)
            })
            .disposed(by: disposeBag)

        searchBarDidBeginEditing
            .subscribe(onNext: {
                print("didBeginEditing")
                self.shouldHideRecentSearchItems.onNext(true)
            })
            .disposed(by: disposeBag)

        searchBarDidEndEditing
            .subscribe(onNext: {
                print("didEndEditing")
                self.shouldHideRecentSearchItems.onNext(true)
            })
            .disposed(by: disposeBag)
    }
}

extension SearchViewModel {
    private func fetchSymbols(text: String, completion: @escaping ([SymbolSearchInfo]) -> Void) {
        API<SymbolSearch>(
            baseURL: TheFellowshipOfAntsRequest.SymbolSearch.baseURL,
            params: [
                TheFellowshipOfAntsRequest.SymbolSearch.ParamsKey.symbol: text
            ],
            apiKey: TheFellowshipOfAntsRequest.SymbolSearch.apikey
        ).fetch { result in
            switch result {
            case .success(let searchedSymbols):
                let filteredSymbols = searchedSymbols.symbolSearchInfos
                    .filter { $0.country == "United States" }
                completion(filteredSymbols)

            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchSearchingStocks(text: String, completion: @escaping ([SymbolSearchInfo]) -> Void) {
        let dispatchGroup = DispatchGroup()
        var tempSearchInfos: [SymbolSearchInfo] = []
        fetchSymbols(text: text) { searchInfos in
            tempSearchInfos = searchInfos
            for (index, searchInfo) in searchInfos.enumerated() {
                dispatchGroup.enter()
                API<Logo>(
                    baseURL: TheFellowshipOfAntsRequest.Logo.baseURL,
                    params: [
                        TheFellowshipOfAntsRequest.Logo.ParamsKey.symbol: searchInfo.symbol
                    ],
                    apiKey: TheFellowshipOfAntsRequest.Logo.apiKey
                ).fetch { result in
                    switch result {
                    case .success(let logo):
                        print(logo.url)
                        tempSearchInfos[index].urlString = logo.url
                        dispatchGroup.leave()
                    case .failure(let error):
                        print(error)
                        dispatchGroup.leave()
                    }
                }
            }

            dispatchGroup.notify(queue: .main) {
                completion(tempSearchInfos)
            }
        }
    }
}
