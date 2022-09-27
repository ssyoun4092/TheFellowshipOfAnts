//
//  UserDefaultUseCaseImpl.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

class UserDefaultUseCaseImpl: UserDefaultUseCase {
    let repository: UserDefaultCRUDRepository
    init(repository: UserDefaultCRUDRepository = UserDefaultCRUDRepositoryImpl()) {
        self.repository = repository
    }

    func updateRecentSearchStockList(_ entity: Entity.RecentSearchedStock) {
        repository.updateRecentSearchStockList(entity)
    }
}
