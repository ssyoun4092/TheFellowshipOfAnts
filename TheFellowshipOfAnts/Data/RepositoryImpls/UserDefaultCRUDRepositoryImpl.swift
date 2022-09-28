//
//  UserDefaultCRUDRepositoryImpl.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import RxSwift

class UserDefaultCRUDRepositoryImpl: UserDefaultCRUDRepository {
    func readRecentSearchStockList() -> [Entity.RecentSearchedStock] {
        return UserDefaultManager.recentSearchStocks.map{ UDSModel in
                    .init(
                        symbol: UDSModel.symbol,
                        companyName: UDSModel.companyName
                    )
        }
    }

    func updateRecentSearchStockList(_ entity: Entity.RecentSearchedStock) {
        if UserDefaultManager.recentSearchStocks.contains(where: { $0.companyName == entity.companyName }) {
            let index = UserDefaultManager.recentSearchStocks.firstIndex { $0.companyName == entity.companyName }!
            UserDefaultManager.recentSearchStocks.remove(at: index)
        }
        UserDefaultManager.recentSearchStocks.insert(.init(symbol: entity.symbol, companyName: entity.companyName), at: 0)
//        UserDefaultManager.recentSearchStocks.append(.init(symbol: entity.symbol, companyName: entity.companyName))
    }

    func removeAllRecentSearchedStocks() {
        UserDefaultManager.recentSearchStocks.removeAll()
    }

    func removeRecentSearchStock(at row: Int) {
        UserDefaultManager.recentSearchStocks.remove(at: row)
    }
}
