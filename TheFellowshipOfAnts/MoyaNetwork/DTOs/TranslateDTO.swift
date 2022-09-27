//
//  TranslateDTO.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

extension DTO {
    struct Translate: Decodable {
        let message: Message

        struct Message: Decodable {
            let type, service, version: String
            let result: Result

            enum CodingKeys: String, CodingKey {
                case type = "@type"
                case service = "@service"
                case version = "@version"
                case result
            }

            struct Result: Decodable {
                let translatedText: String
            }
        }
    }
}
