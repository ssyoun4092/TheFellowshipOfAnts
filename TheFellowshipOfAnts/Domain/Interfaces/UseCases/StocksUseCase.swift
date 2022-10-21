//
//  StocksUseCase.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import RxSwift

protocol StocksUseCase {
    func fetchStockOverview(symbol: String) -> Observable<[String]>
    func searchStockList(text: String) -> Observable<[Entity.SearchStock]>
    func fetchStockPrices(for symbol: String) -> Observable<[Double]>
    func fetchStockIncomeStatements(for symbol: String) -> Observable<[Entity.StockIncomeStatement]>
    func fetchTop20Stocks() -> Observable<[Entity.RankStock]>
    func fetchMajorStockIndices() -> Observable<[Entity.StockIndice]>
    func fetchMajorCommodities() -> Observable<[Entity.Commodity]>
    func fetchMajorETFs() -> Observable<[Entity.ETF]>
}
