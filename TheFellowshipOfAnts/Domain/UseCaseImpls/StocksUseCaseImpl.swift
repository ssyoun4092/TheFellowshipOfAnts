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

    func fetchTop20Stocks() -> Observable<[Entity.RankStock]> {

        return repository.fetchTop20Stocks()
    }

    func fetchMajorStockIndices() -> Observable<[Entity.StockIndice]> {

        return repository.fetchMajorStockIndices()
    }

    func fetchMajorCommodities() -> Observable<[Entity.Commodity]> {

        return repository.fetchMajorCommodities()
            .map { entities in
                entities.map { entity in
                    Entity.Commodity(
                        name: entity.name,
                        price: "$" + entity.price,
                        fluctuationRate: entity.fluctuationRate
                    )
                }
            }
    }

    func fetchMajorETFs() -> Observable<[Entity.ETF]> {

        return repository.fetchMajorETFs()
            .map { entities in
                entities.map { entity in
                    Entity.ETF(
                        name: entity.name,
                        price: "$" + entity.price,
                        fluctuationRate: entity.fluctuationRate + "%"
                    )
                }
            }
    }
}