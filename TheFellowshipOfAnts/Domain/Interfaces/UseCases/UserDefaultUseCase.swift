//
//  UserDefaultUseCase.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

protocol UserDefaultUseCase {
    func updateRecentSearchStockList(_ entity: Entity.RecentSearchedStock)
}
