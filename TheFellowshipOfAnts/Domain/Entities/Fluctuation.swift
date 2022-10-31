//
//  UpDown.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/30.
//

import UIKit

enum Fluctuation {
    case up
    case down

    var textColor: UIColor {
        switch self {
        case .up: return .systemGreen
        case .down: return .systemRed
        }
    }

    var gradient: [CGColor] {
        switch self {
        case .up: return [UIColor.green.cgColor, UIColor.clear.cgColor]
        case .down: return [UIColor.red.cgColor, UIColor.clear.cgColor]
        }
    }

    /// 플러스 마이너스 부호
    var sign: String {
        switch self {
        case .up: return "+"
        case .down: return "-"
        }
    }
}

extension Fluctuation {
    static func calculate(prev: Double, current: Double) -> Fluctuation {
        return current - prev > 0 ? .up : .down
    }
}
