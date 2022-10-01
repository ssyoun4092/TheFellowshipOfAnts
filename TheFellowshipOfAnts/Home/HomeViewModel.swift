//
//  HomeViewModel.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/29.
//

import Foundation

import RxCocoa
import RxSwift

class HomeViewModel {

    // View -> ViewModel
    let firstLoad = PublishRelay<Void>()

    // ViewModel -> View
    let top20Stocks: Driver<[Entity.RankStock]>
//    let fetchedMajorIndices = Driver<[Entity.RecentSearchedStock]>

    private let useCase: StocksUseCase

    init(useCase: StocksUseCase = StocksUseCaseImpl()) {
        self.useCase = useCase

        self.top20Stocks = firstLoad.asObservable()
            .do(onNext: { print("First Load") } )
            .flatMap { _ in
                return useCase.fetchTop20Stocks()
            }
            .asDriver(onErrorJustReturn: [])
    }
}
