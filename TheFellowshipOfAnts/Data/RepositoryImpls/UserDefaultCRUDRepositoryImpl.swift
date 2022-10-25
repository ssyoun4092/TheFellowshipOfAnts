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

    func likedItems() -> [Entity.Liked] {
        return UserDefaultManager.liked.map { model in
                .init(companyName: model.companyName,
                      symbol: model.symbol,
                      logoImageURL: URL(string: "https://logo.clearbit.com/\(model.companyName).com"))
        }
    }

    func toggleLikedItem(companyName: String, symbol: String) {
        if UserDefaultManager.liked.contains(where: { $0.symbol == symbol }) {
            let index = UserDefaultManager.liked.firstIndex { $0.symbol == symbol }!
            UserDefaultManager.liked.remove(at: index)
        } else {
            UserDefaultManager.liked.append(.init(companyName: companyName, symbol: symbol))
            print(UserDefaultManager.liked)
        }
    }
}
