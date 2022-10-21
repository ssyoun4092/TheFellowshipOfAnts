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

    // MARK: - ViewModel -> View

    let stockPrices: Driver<[Double]>
    let stockOverview: Driver<[StockOverviewCellViewModel]>
    let stockIncomeStatements: Driver<StockDetailChartViewModel>

    // MARK: - Properties

    let symbol: String?
    let companyName: String?
    private let useCase: StocksUseCase
    private let stockOverviewTitles = Observable<[String]>
        .just(["시가총액", "52주 최고가", "52주 최저가", "PER", "PBR", "EPS"])

    init(useCase: StocksUseCase, symbol: String, companyName: String) {
        self.useCase = useCase
        self.symbol = symbol
        self.companyName = companyName

        let sharedViewWillAppear = viewWillAppear.share()

        stockPrices = sharedViewWillAppear
            .flatMap { _ in useCase.fetchStockPrices(for: symbol) }
            .asDriver(onErrorJustReturn: [])

        stockOverview = sharedViewWillAppear
            .flatMap { _ in useCase.fetchStockOverview(symbol: symbol)}
            .withLatestFrom(stockOverviewTitles) { overview, titles in
                zip(overview, titles).map {
                        .init(title: $1, content: $0)
                }
            }
            .asDriver(onErrorJustReturn: [])

        stockIncomeStatements = sharedViewWillAppear
            .flatMap { _ in useCase.fetchStockIncomeStatements(for: symbol) }
            .map { .init(companyName: companyName, incomeStatements: $0.reversed()) }
            .asDriver(onErrorJustReturn: .init(companyName: "", incomeStatements: []))
    }
}
