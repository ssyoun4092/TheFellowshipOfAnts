//
//  NetworkServiceRx.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/19.
//

import Foundation

import TheFellowshipOfAntsKey
import RxSwift

class NetworkServiceRx {
    static func fetchSearchingStocksWithLogoRx(symbol: String) -> Observable<[SearchedStock]> {
        return Observable.create { observer -> Disposable in
            NetworkService.fetchSearchingStocksInfo(text: symbol) { result in
                switch result {
                case .success(let searchedStockInfos):
                    observer.onNext(searchedStockInfos)

                case .failure(let error):
                    observer.onError(error)
                }
            }

            return Disposables.create()
        }
    }
}
