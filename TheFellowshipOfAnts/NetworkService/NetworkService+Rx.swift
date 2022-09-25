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
    func fetchSearchingStocksWithLogoRx(symbol: String) -> Observable<Result<[SearchStock], Error>> {
        return Observable.create { observer in
            NetworkService.fetchSearchingStocksInfo(text: symbol) { result in
                observer.onNext(result)
            }

            return Disposables.create()
        }
    }

    func translateKoreanToEnglishRx(text: String) -> Observable<Result<String, Error>> {
        return Observable.create { observer in
            NetworkService.translateKoreanToEnglish(text: text) { result in
                observer.onNext(result)
            }

            return Disposables.create()
        }
    }
}
