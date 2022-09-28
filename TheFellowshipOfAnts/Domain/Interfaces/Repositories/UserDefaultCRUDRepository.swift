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
}
