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
    let stockIndices: Driver<[Entity.StockIndice]>
    let top20Stocks: Driver<[Entity.RankStock]>
    let carouselCellViewModels: Driver<[MajorCarouselCellViewModel]>

    private let useCase: StocksUseCase

    init(useCase: StocksUseCase = StocksUseCaseImpl()) {
        self.useCase = useCase

        self.stockIndices = firstLoad.asObservable()
            .flatMap { _ in useCase.fetchMajorStockIndices() }
            .asDriver(onErrorJustReturn: [])

        self.top20Stocks = firstLoad.asObservable()
            .do(onNext: { print("First Load") } )
            .flatMap { _ in useCase.fetchTop20Stocks() }
            .asDriver(onErrorJustReturn: [])

        self.carouselCellViewModels = firstLoad.asObservable()
            .flatMap { _ in useCase.fetchMajorCommodities() }
            .map { entities -> [MajorCarouselCellViewModel] in
                entities.map { MajorCarouselCellViewModel(with: $0) }
            }
            .asDriver(onErrorJustReturn: [])
    }
}
