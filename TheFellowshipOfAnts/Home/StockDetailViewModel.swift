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

    let stockPrices: Driver<[Entity.StockPrice]>
    let stockOverview: Driver<Entity.StockOverview>

    let symbol: String?
    let companyName: String?
    private let useCase: StocksUseCase

    init(useCase: StocksUseCase, symbol: String, companyName: String) {
        self.useCase = useCase
        self.symbol = symbol
        self.companyName = companyName

        stockPrices = viewWillAppear
            .flatMap { _ in useCase.fetchStockPrices(for: symbol) }
            .asDriver(onErrorJustReturn: [])

        stockOverview = viewWillAppear
            .flatMap { _ in useCase.fetchStockOverview(symbol: symbol)}
            .asDriver(onErrorJustReturn: .init(marketCap: "", PER: "", PBR: "", EPS: "", the52WeekHigh: "", the52WeekLow: ""))
    }
}
