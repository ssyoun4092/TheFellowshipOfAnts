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
    let viewWillAppear = PublishRelay<Void>()
    let likedItemSelected = PublishRelay<Int>()

    let likedItems: Driver<[Entity.Liked]>

    private let useCase: UserDefaultUseCase

    init(useCase: UserDefaultUseCase) {
        self.useCase = useCase

        likedItems = viewWillAppear
            .flatMap { _ in useCase.likedItems() }
            .asDriver(onErrorJustReturn: [])
    }
}
