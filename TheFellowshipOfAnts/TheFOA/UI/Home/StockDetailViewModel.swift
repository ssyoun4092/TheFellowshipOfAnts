//
//  StockDetailViewModel.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/20.
//

import Foundation

import RxCocoa
import RxSwift

class StockDetailViewModel {

    // MARK: - View -> ViewModel

    let viewWillAppear = PublishRelay<Void>()
    let didTapHeartButton = PublishRelay<Void>()

    // MARK: - ViewModel -> View

    let stockOverview: Driver<[StockOverviewCellViewModel]>
    let stockDetailChartViewModel: Driver<StockDetailChartViewModel>
    let animateHeartLottie: Driver<Void>
    let isLiked: Driver<Bool>

    // MARK: - Properties

    let symbol: String?
    let companyName: String?
    private let stockUseCase: StocksUseCase
    private let userDefaultUseCase: UserDefaultUseCase
    private let stockOverviewTitles = Observable<[String]>
        .just(["시가총액", "52주 최고가", "52주 최저가", "PER", "PBR", "EPS"])

    init(stockUseCase: StocksUseCase, userDefaultUseCase: UserDefaultUseCase, symbol: String, companyName: String) {
        self.stockUseCase = stockUseCase
        self.userDefaultUseCase = userDefaultUseCase
        self.symbol = symbol
        self.companyName = companyName

        let shouldAnimateHeartLottie = BehaviorSubject<Bool>(value: false)

        let sharedViewWillAppear = viewWillAppear.share()

        let didToggleHeartButton = didTapHeartButton
            .flatMap { _ in userDefaultUseCase.toggleLikedItem(companyName: companyName, symbol: symbol) }
            .do { shouldAnimateHeartLottie.onNext($0) }
            .map { _ in () }
            .share()

        let stockPrices = sharedViewWillAppear
            .flatMap { _ in stockUseCase.fetchStockPrices(for: symbol) }

        let stockIncomeStatements = sharedViewWillAppear
            .flatMap { _ in stockUseCase.fetchStockIncomeStatements(for: symbol) }

        animateHeartLottie = shouldAnimateHeartLottie
            .filter { $0 == true }
            .map { _ in () }
            .asDriver(onErrorJustReturn: ())

        isLiked = Observable.merge([sharedViewWillAppear,
                                    didToggleHeartButton])
            .flatMap { _ in userDefaultUseCase.likedItems() }
            .map { $0.contains { $0.symbol == symbol } }
            .asDriver(onErrorJustReturn: false)

        stockOverview = sharedViewWillAppear
            .flatMap { _ in stockUseCase.fetchStockOverview(symbol: symbol)}
            .withLatestFrom(stockOverviewTitles) { overview, titles in
                zip(overview, titles).map {
                        .init(title: $1, content: $0)
                }
            }
            .asDriver(onErrorJustReturn: [])

        stockDetailChartViewModel = Observable.combineLatest(stockPrices, stockIncomeStatements) { prices, incomes in
                .init(companyName: companyName,
                      prices: prices.reversed(),
                      incomeStatements: incomes.reversed(),
                      upDown: .calculate(prev: prices.last ?? 0, current: prices.first ?? 0))
        }
        .asDriver(onErrorJustReturn: .init(companyName: "",
                                           prices: [],
                                           incomeStatements: [],
                                           upDown: .up))
    }
}
