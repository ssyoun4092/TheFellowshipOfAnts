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

    let viewDidLoad = PublishRelay<Void>()
    let viewWillAppear = PublishRelay<Void>()
    let likedItemSelected = PublishRelay<Int>()

    let likedCellItems: Driver<[LikedCellViewModel]>
    let pushToStockDetailVC: Driver<StockBaseInfo>

    private let userDefaultUseCase: UserDefaultUseCase
    private let stockUseCase: StocksUseCase

    init(userDefaultUseCase: UserDefaultUseCase, stockUseCase: StocksUseCase) {
        self.userDefaultUseCase = userDefaultUseCase
        self.stockUseCase = stockUseCase

        let likedItems = viewDidLoad
            .flatMap { _ in userDefaultUseCase.likedItems() }

        let stockPrices = likedItems
            .flatMap { entities in
                let symbols = entities.map { $0.symbol }
                return stockUseCase.fetchMultiStocksPrices(for: symbols)
            }


        likedCellItems = Observable.combineLatest(likedItems, stockPrices) { likedItems, stockPrices in
            zip(likedItems, stockPrices).map {
                .init(likedEntity: $0,
                      prices: $1.close.reversed())

            }
        }
        .asDriver(onErrorJustReturn: [])

        pushToStockDetailVC  = likedItemSelected
            .withLatestFrom(likedItems) { row, items in
                (items[row].companyName, items[row].symbol)
            }
            .asDriver(onErrorJustReturn: ("", ""))
    }
}
