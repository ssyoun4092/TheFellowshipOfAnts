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
    let operatingIncome: Int
    let operatingIncomeRatio: Double
}

extension StockIncome {
    static let dummy: [StockIncome]  = [
        StockIncome(
            symbol: "AAPL",
            calendarYear: "2021",
            revenue: 365817000000,
            operatingIncome: 108949000000,
            operatingIncomeRatio: 0.29782377527561593),
        StockIncome(
            symbol: "AAPL",
            calendarYear: "2020",
            revenue: 274515000000,
            operatingIncome: 66288000000,
            operatingIncomeRatio: 0.24147314354406862),
        StockIncome(
            symbol: "AAPL",
            calendarYear: "2019",
            revenue: 260174000000,
            operatingIncome: 63930000000,
            operatingIncomeRatio: 0.24572017188496928),
        StockIncome(
            symbol: "AAPL",
            calendarYear: "2018",
            revenue: 265595000000,
            operatingIncome: 70898000000,
            operatingIncomeRatio: 0.26694026619477024),
        StockIncome(
            symbol: "AAPL",
            calendarYear: "2017",
            revenue: 229234000000,
            operatingIncome: 61344000000,
            operatingIncomeRatio: 0.2676042820872994)]

}
