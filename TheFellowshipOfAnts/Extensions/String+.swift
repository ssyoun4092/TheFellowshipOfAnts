//
//  String+.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/30.
//

import Foundation

extension String {
    func floorIfDouble(at num: Int) -> String {
        guard var doubleString = Double(self) else { return "" }

        var pow: Double = 1
        for _ in 0..<num {
            pow *= 10
        }

        doubleString = round(doubleString * pow)

        return String(doubleString / pow)
    }
}
