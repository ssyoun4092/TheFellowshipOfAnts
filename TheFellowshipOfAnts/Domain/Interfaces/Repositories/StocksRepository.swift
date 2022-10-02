//
//  Repository.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import RxSwift

protocol StocksRepository {
    func fetchStockOverview(symbol: String) -> Observable<Entity.StockOverview>
    func searchStockList(text: String) -> Observable<[Entity.SearchStock]>
    func fetchTop20Stocks() -> Observable<[Entity.RankStock]>
    func fetchMajorStockIndices() -> Observable<[Entity.StockIndice]>
    func fetchMajorCommodities() -> Observable<[Entity.Commodity]>
}
