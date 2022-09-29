//
//  TranslateUseCaseImpl.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import RxSwift

class TranslateUseCaseImpl: TranslateUseCase {
    let repository: TranslateRepository
    init(repository: TranslateRepository = TranslateRepositoryImpl()) {
        self.repository = repository
    }

    func containKorean(_ text: String) -> Bool {
        let koreanRegister = "^[ㄱ-ㅎㅏ-ㅣ가-힣]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", koreanRegister)

        return predicate.evaluate(with: text)

    }

    func translateKoreanToEnglish(text: String) -> Observable<Entity.TranslatedMessage> {

        return repository.translateKoreanToEnglish(text: text)
    }
}
