//
//  UserDefaultCRUDRepository.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import RxSwift

protocol UserDefaultCRUDRepository {
    func readRecentSearchStockList() -> [Entity.RecentSearchedStock]
    func updateRecentSearchStockList(_ entity: Entity.RecentSearchedStock)
    func removeAllRecentSearchedStocks()
    func removeRecentSearchStock(at row: Int)
    func likedItems() -> [Entity.Liked]
    func toggleLikedItem(companyName: String, symbol: String) -> Bool
}
