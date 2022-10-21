//
//  MajorETFsDTO.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/02.
//

import Foundation

extension DTO {
    /// ETF DTO
    struct MajorETFs: Decodable {
        let SPY, TLT, SHY, VIX: ETF

        struct ETF: Decodable {
            let basic: Basic
            let details: [Detail]
            let status: String

            enum CodingKeys: String, CodingKey {
                case basic = "meta"
                case details = "values"
                case status
            }

            struct Basic: Decodable {
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

            struct Detail: Decodable {
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
