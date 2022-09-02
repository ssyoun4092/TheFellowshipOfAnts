//
//  Commodity.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/01.
//

import Foundation

protocol CarouselCellType {
    var name: String { get }
    var price: String { get }
    var fluctuationRate: String { get }
}

struct Commodity: CarouselCellType {
    var name: String
    var price: String
    var fluctuationRate: String
}

extension Commodity {
    static let dummy: [Commodity] = [
        Commodity(name: "Gold", price: "1,699.35", fluctuationRate: "0.17%"),
        Commodity(name: "Silver", price: "17.88", fluctuationRate: "0.03%"),
        Commodity(name: "Oil (WTI)", price: "88.38", fluctuationRate: "2.34%"),
        Commodity(name: "Copper", price: "7,701.50", fluctuationRate: "-0.24%"),
        Commodity(name: "Nickel", price: "20,524.00", fluctuationRate: "-3.43%"),
        Commodity(name: "Coffee", price: "2.37", fluctuationRate: "-1.13%")
    ]
}
