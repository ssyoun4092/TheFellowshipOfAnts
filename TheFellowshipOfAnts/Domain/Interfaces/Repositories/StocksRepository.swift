//
//  Repository.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import RxSwift

protocol StocksRepository {
    func fetchStockOverview(for symbol: String) -> Observable<Entity.StockOverview>
    func searchStockList(text: String) -> Observable<[Entity.SearchStock]>
    func fetchStockPrices(for symbol: String) -> Observable<[Entity.StockPrice]>
    func fetchStockIncomeStatements(for symbol: String) -> Observable<[Entity.StockIncomeStatement]>
    func fetchTop20Stocks() -> Observable<[Entity.RankStock]>
    func fetchMajorStockIndices() -> Observable<[Entity.StockIndice]>
    func fetchMajorCommodities() -> Observable<[Entity.Commodity]>
    func fetchMajorETFs() -> Observable<[Entity.ETF]>
}
