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
    let viewWillAppear = PublishRelay<Void>()

    let stockPrices: Driver<[Double]>
    let stockOverview: Driver<[StockOverviewCellViewModel]>
    let stockIncomeStatements: Driver<StockDetailChartViewModel>

    let symbol: String?
    let companyName: String?
    private let useCase: StocksUseCase

    init(useCase: StocksUseCase, symbol: String, companyName: String) {
        let stockOverviewTitles = ["시가총액", "52주 최고가", "52주 최저가", "PER", "PBR", "EPS"]
        self.useCase = useCase
        self.symbol = symbol
        self.companyName = companyName

        stockPrices = viewWillAppear
            .flatMap { _ in useCase.fetchStockPrices(for: symbol) }
            .asDriver(onErrorJustReturn: [])

        stockOverview = viewWillAppear
            .flatMap { _ in useCase.fetchStockOverview(symbol: symbol)}
            .enumerated()
            .map { index, overview in
                overview.map { .init(title: stockOverviewTitles[index], value: $0) }
            }
            .asDriver(onErrorJustReturn: [])

        stockIncomeStatements = viewWillAppear
            .flatMap { _ in useCase.fetchStockIncomeStatements(for: symbol) }
            .map { .init(companyName: companyName, incomeStatements: $0) }
            .asDriver(onErrorJustReturn: .init(companyName: "", incomeStatements: []))
    }
}
