//
//  LikedViewModel.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/21.
//

import Foundation

import RxCocoa
import RxSwift

class LikedViewModel {
    typealias StockBaseInfo = (String, String)

    let viewWillAppear = PublishRelay<Void>()
    let likedItemSelected = PublishRelay<Int>()

    let likedItems: Driver<[Entity.Liked]>
    let pushToStockDetailVC: Driver<StockBaseInfo>

    private let useCase: UserDefaultUseCase

    init(useCase: UserDefaultUseCase) {
        self.useCase = useCase

        likedItems = viewWillAppear
            .flatMap { _ in useCase.likedItems() }
            .asDriver(onErrorJustReturn: [])

        pushToStockDetailVC  = likedItemSelected
            .withLatestFrom(likedItems) { row, items in
                (items[row].companyName, items[row].symbol)
            }
            .asDriver(onErrorJustReturn: ("", ""))
    }
}
