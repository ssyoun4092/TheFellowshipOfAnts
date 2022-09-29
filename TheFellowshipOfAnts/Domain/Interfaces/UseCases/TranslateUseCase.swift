//
//  TranslateUsecase.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import RxSwift

protocol TranslateUseCase {
    func containKorean(_ text: String) -> Bool
    func translateKoreanToEnglish(text: String) -> Observable<Entity.TranslatedMessage>
}
