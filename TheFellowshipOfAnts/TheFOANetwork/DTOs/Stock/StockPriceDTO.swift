//
//  StockPrice.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/20.
//

import Foundation

extension DTO {
    struct StockPrice: Decodable {
        let basic: StockPriceBasic
        let details: [StockPriceDetail]
        let status: String

        enum CodingKeys: String, CodingKey {
            case basic = "meta"
            case details = "values"
            case status
        }

        struct StockPriceBasic: Decodable {
            let symbol: String
            let interval: String
            let currency: String
            let exchangeTimezone: String
            let exchange: String
            let micCode: String
            let type: String

            enum CodingKeys: String, CodingKey {
                case symbol, interval, currency, exchange, type
                case exchangeTimezone = "exchange_timezone"
                case micCode = "mic_code"
            }
        }

        struct StockPriceDetail: Decodable {
            let dateTime, open, high, low: String
            let close, volume: String

            enum CodingKeys: String, CodingKey {
                case dateTime = "datetime"
                case open, high, low, close, volume
            }
        }
    }
}
