//
//  MajorStockIndiceDTO.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/29.
//

import Foundation

extension DTO {
    struct StockIndice {
        let meta: Meta
        let values: [Value]
        let status: String

        struct Meta {
            let symbol, interval, currency, exchangeTimezone: String
            let exchange, micCode, type: String

            enum CodingKeys: String, CodingKey {
                case symbol, interval, currency, exchange, type
                case exchangeTimezone = "exchange_timezone"
                case micCode = "mic_code"
            }
        }

        struct Value {
            let datetime, open, high, low: String
            let close, volume: String
        }
    }
}
