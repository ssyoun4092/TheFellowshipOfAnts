//
//  MajorStockIndiceDTO.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/29.
//

import Foundation

extension DTO {
    /// 주가지수 DTO
    struct MajorStockIndices: Decodable {
        let IXIC, SPX, DJI: StockIndice

        struct StockIndice: Decodable {
            let basic: StockIndiceBasic
            let details: [StockIndiceDetail]
            let status: String

            enum CodingKeys: String, CodingKey {
                case basic = "meta"
                case details = "values"
                case status
            }

            struct StockIndiceBasic: Decodable {
                let symbol: String
                let interval: String
                let currency: String
                let exchageTimezone: String
                let exchange: String
                let micCode: String
                let type: String

                enum CodingKeys: String, CodingKey {
                    case symbol, interval, currency, exchange, type
                    case exchageTimezone = "exchange_timezone"
                    case micCode = "mic_code"
                }
            }

            struct StockIndiceDetail: Decodable {
                let dateTime, open, high, low: String
                let close, volume: String

                enum CodingKeys: String, CodingKey {
                    case dateTime = "datetime"
                    case open, high, low, close, volume
                }
            }
        }
    }
}
