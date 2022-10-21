//
//  StockIncomeStatementEntity.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/20.
//

import Foundation

extension Entity {
    struct StockIncomeStatement {
        let symbol: String
        let calendarYear: String
        let revenue: Double
        let operatingIncome: Double
        let operatingIncomeRatio: Double
    }
}
