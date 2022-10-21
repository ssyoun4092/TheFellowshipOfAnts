//
//  SearchStockLIstDTO.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/26.
//

import Foundation

extension DTO {
    struct SearchStocks: Decodable {
        let SearchStockInfos: [SearchStockInfo]

        enum CodingKeys: String, CodingKey {
            case SearchStockInfos = "data"
        }

        struct SearchStockInfo: Decodable {
            let symbol: String
            let companyName: String
            let country: String

            enum CodingKeys: String, CodingKey {
                case symbol
                case companyName = "instrument_name"
                case country
            }
        }
    }
}
