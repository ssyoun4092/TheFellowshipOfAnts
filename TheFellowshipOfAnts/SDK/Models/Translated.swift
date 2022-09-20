//
//  Translated.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/20.
//

import Foundation

struct Translated: Decodable {
    let message: TranslatedMessage
}

struct TranslatedMessage: Decodable {
    let result: ResultTranslatedMessage
}

struct ResultTranslatedMessage: Decodable {
    let translatedText: String
}
