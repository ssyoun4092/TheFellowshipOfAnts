//
//  UseCaseImpl.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import RxCocoa
import RxSwift

class StocksUseCaseImpl: StocksUseCase {
    let repository: StocksRepository

    init(repository: StocksRepository = StocksRepositoryImpl()) {
        self.repository = repository
    }

    func searchStockList(text: String) -> Observable<[Entity.SearchStock]> {

        return repository.searchStockList(text: text)
    }

    func fetchStockOverview(symbol: String) -> Observable<Entity.StockOverview> {

        return repository.fetchStockOverview(symbol: symbol)
    }
}
