//
//  StockDetail.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/05.
//

import Foundation

struct StockIncome: Decodable {
    let symbol: String
    let calendarYear: String
    let revenue: Int
    let grossProfit: Int
    let grossProfitRatio: Double
}

extension StockIncome {
    static let dummy: [StockIncome]  = [
        StockIncome(
            symbol: "AAPL",
            calendarYear: "2021",
            revenue: 365817000000,
            grossProfit: 152836000000,
            grossProfitRatio: 0.4177935962516778),
        StockIncome(
            symbol: "AAPL",
            calendarYear: "2020",
            revenue: 274515000000,
            grossProfit: 104956000000,
            grossProfitRatio: 0.38233247727810865),
        StockIncome(
            symbol: "AAPL",
            calendarYear: "2019",
            revenue: 260174000000,
            grossProfit: 98392000000,
            grossProfitRatio: 0.3781776810903472),
        StockIncome(
            symbol: "AAPL",
            calendarYear: "2018",
            revenue: 265595000000,
            grossProfit: 101839000000,
            grossProfitRatio: 0.38343718820007905),
        StockIncome(
            symbol: "AAPL",
            calendarYear: "2017",
            revenue: 229234000000,
            grossProfit: 88186000000,
            grossProfitRatio: 0.38469860491899105)
    ]
}
