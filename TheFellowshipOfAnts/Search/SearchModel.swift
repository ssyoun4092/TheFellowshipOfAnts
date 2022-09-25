//
//  SearchModel.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/21.
//

import Foundation

import RxSwift

class SearchModel {
    private let networkService: NetworkServiceRx

    init(networkService: NetworkServiceRx = NetworkServiceRx()) {
        self.networkService = networkService
    }

    func fetchSearchingStockList(symbol: String) -> Observable<Result<[SearchStock], Error>> {

        return networkService.fetchSearchingStocksWithLogoRx(symbol: symbol)
    }

    func translateKoreanToEnglish(text: String) -> Observable<Result<String, Error>> {

        return networkService.translateKoreanToEnglishRx(text: text)
    }

    func containKorean(_ item: String) -> Bool {
        let koreanRegister = "^[ㄱ-ㅎㅏ-ㅣ가-힣]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", koreanRegister)

        return predicate.evaluate(with: item)
    }
}
