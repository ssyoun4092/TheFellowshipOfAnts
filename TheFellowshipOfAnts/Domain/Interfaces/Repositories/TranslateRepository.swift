//
//  TranslateRepository.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import RxSwift

protocol TranslateRepository {
    func translateKoreanToEnglish(text: String) -> Observable<Entity.TranslatedMessage>
}
