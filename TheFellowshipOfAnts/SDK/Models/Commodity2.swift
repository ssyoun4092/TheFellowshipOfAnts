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

struct Commodity2: CarouselCellType {
    var name: String
    var price: String
    var fluctuationRate: String
}

extension Commodity2 {
    static let dummy: [Commodity2] = [
        Commodity2(name: "Gold", price: "$1,702.40", fluctuationRate: "0.17%"),
        Commodity2(name: "Silver", price: "$17.95", fluctuationRate: "0.03%"),
        Commodity2(name: "Oil (WTI)", price: "$88.25", fluctuationRate: "2.34%"),
        Commodity2(name: "Copper", price: "$7,701.50", fluctuationRate: "-0.24%"),
        Commodity2(name: "Nickel", price: "$20,524.00", fluctuationRate: "-3.43%"),
        Commodity2(name: "Coffee", price: "$2.37", fluctuationRate: "-1.13%")
    ]
}
