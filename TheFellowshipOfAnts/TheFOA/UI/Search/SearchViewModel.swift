//
//  SearchViewModel.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/16.
//

import Foundation

import RxCocoa
import RxSwift

final class SearchViewModel {
    let disposeBag = DisposeBag()

    // View -> ViewModel
    let firstLoad = PublishRelay<Void>()
    let searchBarText =  PublishRelay<String>()
    let searchBarDidBeginEditing = PublishRelay<Void>()
    let searchButtonClicked = PublishRelay<Void>()
    let didTapCancelButton = PublishRelay<Void>()
    let didSelectSearchedStocksItem = PublishRelay<Int>()
    let didTapDeleteAllButton = PublishRelay<Void>()
    let pushToStockDetailViewController = PublishRelay<[String]>()
    let pushToStockDetailViewController2 = PublishRelay<Int>()
    let deleteRecentSearchedCellRow = PublishRelay<Int>()

    // ViewModel -> View
    let hideRecentSearchView: Driver<Bool>
    let hideSearchedStocksView: Driver<Bool>
    let hideCancelButton: Driver<Bool>
    let hideKeyboard: Driver<Void>
    let searchedStocks: Driver<[Entity.SearchStock]>
    var reloadRecentSearchedStocks: Driver<[Entity.RecentSearchedStock]>
    let activated: Driver<Bool>
    let push: Driver<Entity.RecentSearchedStock>

    private let stockUseCase: StocksUseCase
    private let translateUseCase: TranslateUseCase
    private let userDefaultUseCase: UserDefaultUseCase

    init(
        stockUseCase: StocksUseCase,
        translateUseCase: TranslateUseCase,
        userDefaultUseCase: UserDefaultUseCase
    ) {
        self.stockUseCase = stockUseCase
        self.translateUseCase = translateUseCase
        self.userDefaultUseCase = userDefaultUseCase

        let activating = BehaviorSubject<Bool>(value: false)

        let inputText = searchBarText
            .share()

        let translatedText = searchButtonClicked
            .withLatestFrom(inputText)
            .do(onNext: { print("translatedText: \($0)") })
            .filter { translateUseCase.containKorean($0) }
            .flatMap { text in translateUseCase.translateKoreanToEnglish(text: text) }
            .map { entity in entity.text}

        let searchedStocksResult = Observable.merge([
            inputText.asObservable(),
            translatedText
        ])
            .do(onNext: { _ in activating.onNext(true)})
            .flatMap { stockUseCase.searchStockList(text: $0) }
            .do(onNext: { _ in activating.onNext(false)})

        let deletedRecentSearchedStocks = didTapDeleteAllButton
            .do(onNext: { _ in userDefaultUseCase.removeAllRecentSearchedStocks() })

        let removedRecentSearchStock = deleteRecentSearchedCellRow
            .do(onNext: { print("row: ", $0) })
            .do(onNext: { row in userDefaultUseCase.removeRecentSearchStock(at: row) })
            .map { _ in () }

        let readedRecentSearchedStocks = Observable.merge([
            firstLoad.asObservable(),
            deletedRecentSearchedStocks,
            removedRecentSearchStock.asObservable()
        ])
            .flatMap { _ in userDefaultUseCase.readRecentSearchStocks() }
            .share()

        self.push = Observable.merge([
            didSelectSearchedStocksItem
                .withLatestFrom(searchedStocksResult) { row, searchedStocks -> Entity.RecentSearchedStock in
                    let symbol = searchedStocks[row].symbol
                    let companyName = searchedStocks[row].companyName
                    let entity = Entity.RecentSearchedStock(symbol: symbol, companyName: companyName)
                    userDefaultUseCase.updateRecentSearchStockList(entity)

                    return entity
                },
            pushToStockDetailViewController2
                .withLatestFrom(readedRecentSearchedStocks) { row, searchedStocks in
                    print(searchedStocks)
                    return searchedStocks[row]
            }
        ])
        .asDriver(onErrorJustReturn: .init(symbol: "", companyName: ""))


        // TODO: - Fetch Error Handling

        self.searchedStocks = searchedStocksResult
                .asDriver(onErrorJustReturn: [])

        self.reloadRecentSearchedStocks = readedRecentSearchedStocks
            .do(onNext: { print("RecentSearchStockList: \($0)") })
            .asDriver(onErrorJustReturn: [])

        self.hideRecentSearchView = searchBarText
            .map { $0.isEmpty ? false : true }
            .asDriver(onErrorJustReturn: false)

        self.hideSearchedStocksView = Observable.combineLatest(searchBarText, activating) { searchBarText, activating in
            if searchBarText.isEmpty {
                return true
            } else {
                return activating ? true : false
            }
        }
        .asDriver(onErrorJustReturn: false)

        self.hideCancelButton = Observable
            .merge([
                searchBarDidBeginEditing.map { _ in false },
                didTapCancelButton.map { _ in true },
                searchButtonClicked.map { _ in true }
            ])
            .asDriver(onErrorJustReturn: false)

        self.hideKeyboard = Observable
            .merge([
                didTapCancelButton.asObservable(),
                searchButtonClicked.asObservable()
            ])
            .asDriver(onErrorJustReturn: ())

        self.activated = Observable
            .combineLatest(activating, searchBarText) { $1.isEmpty ? false : $0 }
            .asDriver(onErrorJustReturn: false)
    }

    func getRecentSearchedStocksCellWidths() -> [CGFloat] {

        return userDefaultUseCase.getRecentSearchedStocksCellWidths()
    }
}

