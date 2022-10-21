//
//  StockIncomStatementDTO.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/20.
//

import Foundation

extension DTO {
    struct StockIncomeStatement: Decodable {
        let date, symbol, reportedCurrency, cik: String
        let fillingDate, acceptedDate, calendarYear, period: String
        let revenue, costOfRevenue: Double
        let grossProfit, grossProfitRatio: Double
        let researchAndDevelopmentExpenses, generalAndAdministrativeExpenses: Double
        let sellingAndMarketingExpenses, sellingGeneralAndAdministrativeExpenses: Double
        let otherExpenses: Double
        let operatingExpenses: Double
        let costAndExpenses: Double
        let interestIncome, interestExpense: Double
        let depreciationAndAmortization: Double
        let ebitda, ebitdaratio: Double
        let operatingIncome, operatingIncomeRatio: Double
        let totalOtherIncomeExpensesNet: Double
        let incomeBeforeTax, incomeBeforeTaxRatio, incomeTaxExpense: Double
        let netIncome, netIncomeRatio: Double
        let eps, epsdiluted: Double
        let weightedAverageShsOut, weightedAverageShsOutDil: Double
        let link: String
        let finalLink: String
    }
}
