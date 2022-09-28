//
//  UserDefaultUseCase.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import RxSwift

protocol UserDefaultUseCase {
    func readRecentSearchStockList() -> Observable<[Entity.RecentSearchedStock]>
    func updateRecentSearchStockList(_ entity: Entity.RecentSearchedStock)
    func getRecentSearchedStocksCellWidths() -> [CGFloat]
}
