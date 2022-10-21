//
//  StockOverviewDTO.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

extension DTO {
    struct StockOverview: Decodable {
        let symbol, assetType, name, description: String
        let cik, exchange, currency, country: String
        let sector, industry, address, fiscalYearEnd: String
        let latestQuarter, marketCapitalization, EBITDA, PER: String
        let PEG, PBR, dividendPerShare, dividendYield: String
        let EPS, revenuePerShareTTM, profitMargin, operatingMarginTTM: String
        let returnOnAssetsTTM, returnOnEquityTTM, revenueTTM, grossProfitTTM: String
        let dilutedEPSTTM, quarterlyEarningsGrowthYOY, quarterlyRevenueGrowthYOY, analystTargetPrice: String
        let trailingPE, forwardPE, priceToSalesRatioTTM, priceToBookRatio: String
        let evToRevenue, evToEBITDA, beta, the52WeekHigh: String
        let the52WeekLow, the50DayMovingAverage, the200DayMovingAverage, sharesOutstanding: String
        let dividendDate, exDividendDate: String

        enum CodingKeys: String, CodingKey {
            case symbol = "Symbol"
            case assetType = "AssetType"
            case name = "Name"
            case description = "Description"
            case cik = "CIK"
            case exchange = "Exchange"
            case currency = "Currency"
            case country = "Country"
            case sector = "Sector"
            case industry = "Industry"
            case address = "Address"
            case fiscalYearEnd = "FiscalYearEnd"
            case latestQuarter = "LatestQuarter"
            case marketCapitalization = "MarketCapitalization"
            case EBITDA
            case PER = "PERatio"
            case PEG = "PEGRatio"
            case PBR = "BookValue"
            case dividendPerShare = "DividendPerShare"
            case dividendYield = "DividendYield"
            case EPS
            case revenuePerShareTTM = "RevenuePerShareTTM"
            case profitMargin = "ProfitMargin"
            case operatingMarginTTM = "OperatingMarginTTM"
            case returnOnAssetsTTM = "ReturnOnAssetsTTM"
            case returnOnEquityTTM = "ReturnOnEquityTTM"
            case revenueTTM = "RevenueTTM"
            case grossProfitTTM = "GrossProfitTTM"
            case dilutedEPSTTM = "DilutedEPSTTM"
            case quarterlyEarningsGrowthYOY = "QuarterlyEarningsGrowthYOY"
            case quarterlyRevenueGrowthYOY = "QuarterlyRevenueGrowthYOY"
            case analystTargetPrice = "AnalystTargetPrice"
            case trailingPE = "TrailingPE"
            case forwardPE = "ForwardPE"
            case priceToSalesRatioTTM = "PriceToSalesRatioTTM"
            case priceToBookRatio = "PriceToBookRatio"
            case evToRevenue = "EVToRevenue"
            case evToEBITDA = "EVToEBITDA"
            case beta = "Beta"
            case the52WeekHigh = "52WeekHigh"
            case the52WeekLow = "52WeekLow"
            case the50DayMovingAverage = "50DayMovingAverage"
            case the200DayMovingAverage = "200DayMovingAverage"
            case sharesOutstanding = "SharesOutstanding"
            case dividendDate = "DividendDate"
            case exDividendDate = "ExDividendDate"
        }
    }
}
