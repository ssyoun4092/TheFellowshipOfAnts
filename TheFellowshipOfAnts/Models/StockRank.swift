//
//  StockRank.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/31.
//

import Foundation

struct StockRank {
    let rank: String
    let logoURL: String
    let companyName: String
    let symbol: String
    let price: String
    let fluctuationRate: String
    let upDown: UpDown
}

extension StockRank {
//    static let dummy: [StockRank] =  [
//        StockRank(
//            rank: "1",
//            companyName: "Apple",
//            symbol: "AAPL",
//            price: "$158.91",
//            upDown: .down),
//        StockRank(rank: "2",
//                  companyName: "Microsoft",
//                  symbol: "MSFT",
//                  price: "$262.97",
//                  upDown: .down),
//        StockRank(rank: "3",
//                  companyName: "Alphabet (Google)",
//                  symbol: "GOOG",
//                  price: "$109.91",
//                  upDown: .up),
//        StockRank(rank: "4",
//                  companyName: "Amazon",
//                  symbol: "AMZN",
//                  price: "$128.73"),
//        StockRank(rank: "5",
//                  companyName: "Tesla",
//                  symbol: "TSLA",
//                  price: "$277.70"),
//        StockRank(rank: "6",
//                  companyName: "Berkshire Hathaway",
//                  symbol: "BRK-B",
//                  price: "$285.42"),
//        StockRank(rank: "7",
//                  companyName: "UnitedHealth",
//                  symbol: "UNH",
//                  price: "$522.84"),
//        StockRank(rank: "8",
//                  companyName: "Johnson & Johnson",
//                  symbol: "JNJ",
//                  price: "$162.43"),
//        StockRank(rank: "9",
//                  companyName: "Visa",
//                  symbol: "V",
//                  price: "$201.38"),
//        StockRank(rank: "10",
//                  companyName: "Meta Platforms (Facebook)",
//                  symbol: "META",
//                  price: "$157.16"),
//        StockRank(rank: "11",
//                  companyName: "Exxon Mobil",
//                  symbol: "XOM",
//                  price: "$96.31"),
//        StockRank(rank: "12",
//                  companyName: "NVIDIA",
//                  symbol: "NVDA",
//                  price: "$154.68"),
//        StockRank(rank: "13",
//                  companyName: "Walmart",
//                  symbol: "WMT",
//                  price: "$132.48"),
//        StockRank(rank: "14",
//                  companyName: "JPMorgan Chase",
//                  symbol: "JPM",
//                  price: "$114.41"),
//        StockRank(rank: "15",
//                  companyName: "Procter & Gamble",
//                  symbol: "PG",
//                  price: "$140.18"),
//        StockRank(rank: "16",
//                  companyName: "Mastercard",
//                  symbol: "MA",
//                  price: "$327.81"),
//        StockRank(rank: "17",
//                  companyName: "Chevron",
//                  symbol: "CVX",
//                  price: "$160.62"),
//        StockRank(rank: "18",
//                  companyName: "Home Depot",
//                  symbol: "HD",
//                  price: "$293.10"),
//        StockRank(rank: "19",
//                  companyName: "Eli Lilly",
//                  symbol: "LLY",
//                  price: "$307.04"),
//        StockRank(rank: "20",
//                  companyName: "Bank of America",
//                  symbol: "BAC",
//                  price: "$34.09")
//    ]
}
