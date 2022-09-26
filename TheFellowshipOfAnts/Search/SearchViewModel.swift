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

    // view -> viewModel
    let searchBarText =  PublishRelay<String>()
    let searchBarDidBeginEditing = PublishRelay<Void>()
    let searchButtonClicked = PublishRelay<Void>()
    let didTapCancelButton = PublishRelay<Void>()
    let didSelectSearchedStocksItem = PublishRelay<Int>()
    let didTapMoyaButton = PublishRelay<Void>()

    // viewModel -> view
    let hideRecentSearchView: Driver<Bool>
    let hideSearchedStocksView: Driver<Bool>
    let hideCancelButton: Driver<Bool>
    let hideKeyboard: Driver<Void>
    let searchedStocks: Driver<[SearchStock]>
    let activated: Driver<Bool>
    let overviews: Driver<[Entity.SearchStock]>
    //    let searchItems =  BehaviorSubject<[SymbolSearchInfo]>(value: [])

    private let useCase: UseCase

    init(model: SearchModel = SearchModel(), useCase: UseCase = UseCaseImpl()) {
        self.useCase = useCase

        overviews = didTapMoyaButton
            .flatMap { _ in useCase.searchStockList(text: "aa") }
            .asDriver(onErrorJustReturn: [])

        let activating = BehaviorSubject<Bool>(value: false)

        let isTextEmpty = searchBarText
            .do(onNext: { _ in print("왜 안돼") })
            .map { $0.isEmpty ? true : false }

        let inputText = searchBarText
            .distinctUntilChanged()
            .filter { !$0.isEmpty }

        let translatedText = Observable
            .combineLatest(searchButtonClicked, inputText) { $1 }
            .filter { model.containKorean($0) }
            .flatMap { text in
                model.translateKoreanToEnglish(text: text)
            }
            .map { result -> String in
                guard case let .success(translatedText) = result else { return "" }
                return translatedText
            }

        let searchedStocksResult = Observable.merge([
            searchBarText.asObservable(),
            translatedText
        ])
            .do(onNext: { _ in activating.onNext(true)})
                .flatMap { model.fetchSearchingStockList(symbol: $0) }
                .do(onNext: { _ in activating.onNext(false)})

                    let searchedStocksError = searchedStocksResult
                    .compactMap { result -> Error? in
                        guard case .failure(let error) = result else { return nil }
                        return error
                    }

        searchedStocks = searchedStocksResult
            .compactMap { result -> [SearchStock] in
                guard case let Result.success(searchedStocks) = result else { return [] }
                return searchedStocks
            }
            .asDriver(onErrorJustReturn: [])

        hideRecentSearchView = isTextEmpty
            .map { !$0 }
            .asDriver(onErrorJustReturn: false)

        hideSearchedStocksView = isTextEmpty
            .map { $0 }
            .asDriver(onErrorJustReturn: false)

        hideCancelButton = Observable
            .merge([
                searchBarDidBeginEditing.map { _ in false },
                didTapCancelButton.map { _ in true },
                searchButtonClicked.map { _ in true }
            ])
            .asDriver(onErrorJustReturn: false)

        hideKeyboard = Observable
            .merge([
                didTapCancelButton.asObservable(),
                searchButtonClicked.asObservable()
            ])
            .asDriver(onErrorJustReturn: ())

        activated = Observable
            .combineLatest(activating, isTextEmpty) { $1 ? false : $0 }
            .asDriver(onErrorJustReturn: false)
    }
}
