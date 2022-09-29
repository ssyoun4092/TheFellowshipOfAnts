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
}
