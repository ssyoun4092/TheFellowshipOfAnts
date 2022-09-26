//
//  UseCaseImpl.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import RxCocoa
import RxSwift

protocol UseCase {
    func searchStockList(text: String) -> Observable<[Entity.SearchStock]>
    func fetchStockOverview(symbol: String) -> Observable<Entity.StockOverview>
}

class UseCaseImpl: UseCase {
    let repository: Repository

    init(repository: Repository = RepositoryImpl()) {
        self.repository = repository
    }

    func searchStockList(text: String) -> Observable<[Entity.SearchStock]> {

        return repository.searchStockList(text: "aa")
    }

    func fetchStockOverview(symbol: String) -> Observable<Entity.StockOverview> {

        return repository.fetchStockOverview(symbol: symbol)
    }
}
