//
//  StockDetailViewModel.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/21.
//

import Foundation

class StockDetailChartViewModel {
    let companyName: String
    let incomeStatements: [Entity.StockIncomeStatement]

    init(companyName: String, incomeStatements: [Entity.StockIncomeStatement]) {
        self.companyName = companyName
        self.incomeStatements = incomeStatements
    }
}
