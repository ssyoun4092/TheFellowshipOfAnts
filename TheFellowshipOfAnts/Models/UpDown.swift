//
//  UpDown.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/30.
//

import UIKit

enum UpDown {
    case up
    case down

    var textColor: UIColor {
        switch self {
        case .up: return .systemRed
        case .down: return .systemBlue
        }
    }

    var gradient: [CGColor] {
        switch self {
        case .up: return [UIColor.red.cgColor, UIColor.clear.cgColor]
        case .down: return [UIColor.blue.cgColor, UIColor.clear.cgColor]
        }
    }
}

extension UpDown {
    static func checkUpDown(_ prev: Double, _ current: Double) -> UpDown {
        return current - prev > 0 ? .up : .down
    }
}
