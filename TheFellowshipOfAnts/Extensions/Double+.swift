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

    func convertToMetrics() -> String {
        switch self {
        case ..<1_000:
            return String(self)
        case ..<1_000_000:
            let formattedValue = self / 1_000
            return String(format: "%.1f", formattedValue) + "K"
        case ..<1_000_000_000:
            let formattedValue = self / 1_000_000
            return String(format: "%.1f", formattedValue) + "M"
        case ..<1_000_000_000_000:
            let formattedValue = self / 1_000_000_000
            return String(format: "%.1f", formattedValue) + "B"
        case ..<1_000_000_000_000:
            let formattedValue = self / 1_000_000_000_000
            return String(format: "%.1f", formattedValue) + "T"
        default:
            return String(self)
        }
    }
}
