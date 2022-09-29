//
//  TranslateRepositoryImpl.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import RxSwift

class TranslateRepositoryImpl: TranslateRepository {
    let network: NetworkServable
    init(network: NetworkServable = NetworkServiceMoya()) {
        self.network = network
    }

    func translateKoreanToEnglish(text: String) -> Observable<Entity.TranslatedMessage> {

        return network.request(TranslateAPI(text: text))
            .compactMap { DTO in .init(text: DTO.message.result.translatedText) }
            .asObservable()
    }
}
