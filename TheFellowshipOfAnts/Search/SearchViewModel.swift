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
}
