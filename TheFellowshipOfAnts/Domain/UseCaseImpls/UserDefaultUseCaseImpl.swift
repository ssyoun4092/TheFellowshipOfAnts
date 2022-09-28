//
//  UserDefaultUseCaseImpl.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import UIKit

import RxSwift

class UserDefaultUseCaseImpl: UserDefaultUseCase {
    let repository: UserDefaultCRUDRepository

    init(repository: UserDefaultCRUDRepository = UserDefaultCRUDRepositoryImpl()) {
        self.repository = repository
    }

    func readRecentSearchStocks() -> Observable<[Entity.RecentSearchedStock]> {

        return Observable.create { [unowned self] observer in
//            guard let self else { return }

            // TODO: - reversed 성능 이슈 고려
            observer.onNext(self.repository.readRecentSearchStockList()) // 최신 순으로 정렬하기 위해 append 역순으로 정렬

            return Disposables.create()
        }
    }

    func updateRecentSearchStockList(_ entity: Entity.RecentSearchedStock) {

        return repository.updateRecentSearchStockList(entity)
    }

    func removeAllRecentSearchedStocks() {
        repository.removeAllRecentSearchedStocks()
    }

    func removeRecentSearchStock(at row: Int) {
        repository.removeRecentSearchStock(at: row)
    }

    func getRecentSearchedStocksCellWidths() -> [CGFloat] {
        // 최근 검색한 회사 이름 길이만큼의 CGFloat 반환
        let sizes = repository.readRecentSearchStockList()
            .map { recentSearchedStock in
                let size = recentSearchedStock.companyName.size(
                    withAttributes: [
                        NSAttributedString.Key.font: UIFont.systemFont(
                            ofSize: 16,
                            weight: .medium)
                    ]
                ).width
                return size
            }
        print("sizes: \(sizes)")

        return sizes
    }
}
