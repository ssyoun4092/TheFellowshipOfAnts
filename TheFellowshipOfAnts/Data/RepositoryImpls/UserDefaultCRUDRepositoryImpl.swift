//
//  UserDefaultCRUDRepositoryImpl.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import RxSwift

class UserDefaultCRUDRepositoryImpl: UserDefaultCRUDRepository {

    // MARK: - SearchStockList

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

    // MARK: - RecentSearchedStocks

    func removeAllRecentSearchedStocks() {
        UserDefaultManager.recentSearchStocks.removeAll()
    }

    func removeRecentSearchStock(at row: Int) {
        UserDefaultManager.recentSearchStocks.remove(at: row)
    }

    // MARK: - Liked

    func likedItems() -> [Entity.Liked] {
        return UserDefaultManager.liked.map { model in
                .init(companyName: model.companyName,
                      symbol: model.symbol,
                      logoImageURL: URL(string: "https://logo.clearbit.com/\(model.companyName).com"))
        }
    }

    func toggleLikedItem(companyName: String, symbol: String) -> Bool {
        let indexShouldRemoved = UserDefaultManager.liked.firstIndex { $0.symbol == symbol }
        let containItem = indexShouldRemoved != nil

        containItem
        ? removeLikedItem(at: indexShouldRemoved!)
        : appendLikedItem(companyName: companyName, symbol: symbol)

        return !containItem
    }

    private func removeLikedItem(at index: Int) {
        UserDefaultManager.liked.remove(at: index)
    }

    private func appendLikedItem(companyName: String, symbol: String) {
        UserDefaultManager.liked.append(.init(companyName: companyName, symbol: symbol))
    }
}
