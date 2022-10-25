//
//  UserDefaultUseCase.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import RxSwift

protocol UserDefaultUseCase {
    func readRecentSearchStocks() -> Observable<[Entity.RecentSearchedStock]>
    func updateRecentSearchStockList(_ entity: Entity.RecentSearchedStock)
    func removeAllRecentSearchedStocks()
    func removeRecentSearchStock(at row: Int)
    func getRecentSearchedStocksCellWidths() -> [CGFloat]
    func likedItems() -> Observable<[Entity.Liked]>
}
