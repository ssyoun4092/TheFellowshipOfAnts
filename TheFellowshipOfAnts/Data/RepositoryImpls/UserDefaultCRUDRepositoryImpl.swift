//
//  UserDefaultCRUDRepositoryImpl.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import RxSwift

class UserDefaultCRUDRepositoryImpl: UserDefaultCRUDRepository {
    func readRecentSearchStocks() -> Observable<[Entity.RecentSearchedStock]> {
        let userDefault = UserDefaultManager.recentSearchStocks

        return Observable.create { observer in
            observer.onNext(userDefault.map{ UDSModel in
                    .init(
                        symbol: UDSModel.symbol,
                        companyName: UDSModel.companyName
                    ) })

            return Disposables.create()
        }
    }

    func updateRecentSearchStockList(_ entity: Entity.RecentSearchedStock) {
        var userDefault = UserDefaultManager.recentSearchStocks
        if userDefault.contains(where: { $0.companyName == entity.companyName }) {
            let index = userDefault.firstIndex { $0.companyName == entity.companyName }!
            userDefault.remove(at: index)
        }

        userDefault.append(.init(symbol: entity.symbol, companyName: entity.companyName))
    }
}
