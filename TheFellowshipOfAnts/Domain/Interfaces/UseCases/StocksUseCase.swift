//
//  StocksUseCase.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import RxSwift

protocol StocksUseCase {
    func searchStockList(text: String) -> Observable<[Entity.SearchStock]>
    func fetchStockOverview(symbol: String) -> Observable<Entity.StockOverview>
    func fetchMajorStockIndices() -> Observable<[Entity.StockIndice]>
    func fetchTop20Stocks() -> Observable<[Entity.RankStock]>
}
