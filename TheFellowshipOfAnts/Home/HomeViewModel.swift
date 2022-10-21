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
    typealias StockBaseInfo = (String, String)

    // View -> ViewModel
    let firstLoad = PublishRelay<Void>()
    let didTapStockRankItem = PublishRelay<Int>()

    // ViewModel -> View
    let stockIndices: Driver<[Entity.StockIndice]>
    let top20Stocks: Driver<[Entity.RankStock]>
    let commodityCellViewModels: Driver<[MajorCarouselCellViewModel]>
    let etfCellViewModels: Driver<[MajorCarouselCellViewModel]>
    let pushToStockDetailVC: Driver<StockBaseInfo>

    private let useCase: StocksUseCase

    init(useCase: StocksUseCase) {
        self.useCase = useCase

        stockIndices = firstLoad.asObservable()
            .flatMap { _ in useCase.fetchMajorStockIndices() }
            .asDriver(onErrorJustReturn: [])

        top20Stocks = firstLoad.asObservable()
            .do(onNext: { print("First Load") } )
            .flatMap { _ in useCase.fetchTop20Stocks() }
            .asDriver(onErrorJustReturn: [])

        commodityCellViewModels = firstLoad.asObservable()
            .flatMap { _ in useCase.fetchMajorCommodities() }
            .map { entities -> [MajorCarouselCellViewModel] in
                entities.map { MajorCarouselCellViewModel(with: $0) }
            }
            .asDriver(onErrorJustReturn: [])

        etfCellViewModels = firstLoad.asObservable()
            .flatMap { _ in useCase.fetchMajorETFs() }
            .map { entities -> [MajorCarouselCellViewModel] in
                entities.map { MajorCarouselCellViewModel(with: $0) }
            }
            .asDriver(onErrorJustReturn: [])

        pushToStockDetailVC = didTapStockRankItem
            .withLatestFrom(top20Stocks) { index, top20Stocks in
                (top20Stocks[index].companyName, top20Stocks[index].symbol)
            }
            .asDriver(onErrorJustReturn: ("", ""))
    }
}
