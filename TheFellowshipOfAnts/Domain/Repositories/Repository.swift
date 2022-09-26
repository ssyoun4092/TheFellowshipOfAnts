//
//  Repository.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import RxCocoa
import RxSwift

protocol Repository {
    func fetchStockOverview(symbol: String) -> Observable<Entity.StockOverview>
    func searchStockList(text: String) -> Observable<[Entity.SearchStock]>
}
