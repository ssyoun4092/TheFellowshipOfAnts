//
//  StocksUseCase.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import RxSwift

protocol StocksUseCase {
    func fetchStockOverview(symbol: String) -> Observable<Entity.StockOverview>
    func searchStockList(text: String) -> Observable<[Entity.SearchStock]>
    func fetchStockPrices(for symbol: String) -> Observable<[Entity.StockPrice]>
    func fetchTop20Stocks() -> Observable<[Entity.RankStock]>
    func fetchMajorStockIndices() -> Observable<[Entity.StockIndice]>
    func fetchMajorCommodities() -> Observable<[Entity.Commodity]>
    func fetchMajorETFs() -> Observable<[Entity.ETF]>
}
