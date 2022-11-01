//
//  Fluctuation+.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/11/01.
//

import Foundation

extension Fluctuation {
    static func calculate(prev: Double, current: Double) -> Fluctuation {
        return current - prev > 0 ? .up : .down
    }

    static func rate(prev: Double, current: Double) -> String {
        let type = calculate(prev: prev, current: current)
        let value = abs((((prev - current) / prev) * 100))
        return type.sign + value.toStringWithFloor(at: 2) + "%"
    }
}
