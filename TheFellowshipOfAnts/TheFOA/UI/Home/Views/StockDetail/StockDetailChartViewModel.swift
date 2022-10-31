//
//  StockDetailViewModel.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/21.
//

import Foundation

class StockDetailChartViewModel {
    let companyName: String
    let prices: [Double]
    let incomeStatements: [Entity.StockIncomeStatement]
    let upDown: Fluctuation

    init(
        companyName: String,
        prices: [Double],
        incomeStatements: [Entity.StockIncomeStatement],
        upDown: Fluctuation
    ) {
        self.prices = prices
        self.companyName = companyName
        self.incomeStatements = incomeStatements
        self.upDown = upDown
    }
}
