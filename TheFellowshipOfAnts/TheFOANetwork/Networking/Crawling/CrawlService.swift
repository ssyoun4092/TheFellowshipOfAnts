//
//  CrawlService.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/29.
//

import Foundation

import SwiftSoup
import RxCocoa
import RxSwift

protocol CrawlServable {
    func request<API>(_ api: API) -> Single<[Elements]> where API: CrawlServiceAPI
}

class CrawlService: CrawlServable {
    func request<API>(_ api: API) -> Single<[Elements]> where API : CrawlServiceAPI {
        let elementsSubject = PublishSubject<[Elements]>()

        DispatchQueue.global().async {
            let elements = api.elementLinks.map { link in
                try! api.doc.select(link)
            }
            elementsSubject.onNext(elements)
            elementsSubject.onCompleted()
        }

        return elementsSubject.asSingle()
    }
}
