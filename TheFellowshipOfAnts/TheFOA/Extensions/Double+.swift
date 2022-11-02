//
//  Double+.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/30.
//

import Foundation

extension Double {
    func toStringWithFloor(at num: Int) -> String {
        return String(format: "%.\(num)f", self)
    }

    func asMetrics() -> String {
        var value = self

        let isNegativeValue = value < 0
        if isNegativeValue { value *= -1 }

        var formattedValue: Double = 0
        var formattedMetrics: String = ""

        switch value {
        case ..<1_000:
            formattedMetrics = String(value)
        case ..<1_000_000:
            formattedValue = value / 1_000
            formattedMetrics = String(format: "%.1f", formattedValue) + "K"
        case ..<1_000_000_000:
            formattedValue = value / 1_000_000
            formattedMetrics = String(format: "%.1f", formattedValue) + "M"
        case ..<1_000_000_000_000:
            formattedValue = value / 1_000_000_000
            formattedMetrics = String(format: "%.1f", formattedValue) + "B"
        case ..<1_000_000_000_000_000:
            formattedValue = value / 1_000_000_000_000
            formattedMetrics = String(format: "%.1f", formattedValue) + "T"
        default:
            return String(value)
        }

        return isNegativeValue ? "-" + formattedMetrics : formattedMetrics
    }
}
