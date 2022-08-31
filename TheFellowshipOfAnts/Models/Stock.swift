//
//  Stock.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/31.
//

import Foundation

struct Stock: Decodable {
    let basic: Basic
    let timeSeries: [String: TimeSeries]

    enum CodingKeys: String, CodingKey {
        case basic = "Meta Data"
        case timeSeries = "Time Series (Daily)"
    }
}

struct Basic: Decodable {
    let ticker: String

    enum CodingKeys: String, CodingKey {
        case ticker = "Symbol"
    }
}

struct TimeSeries: Decodable {
    let open, high, low, close: String
    let volume: String

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}
