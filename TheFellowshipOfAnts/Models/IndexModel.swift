import Foundation


struct MajorStockIndexes: Decodable {
    let IXIC, SPX, DJI: StockIndex
}

/// 주가지수 모델
struct StockIndex: Decodable {
    let basic: Meta
    let values: [Value]
    let status: String

    enum CodingKeys: String, CodingKey {
        case basic = "meta"
        case values, status
    }
}


struct Meta: Decodable {
    let symbol: String
}

struct Value: Decodable {
    let datetime, open, high, low: String
    let close, volume: String
}

#if DEBUG
struct dummy {
    static let chart1day: [Double] = [
        12017.66895,
        12141.70996,
        12639.25953,
        12431.53027,
        12381.29980,
        12705.21973,
        12965.33984,
        12938.12012,
        13102.54980,
        13128.04980,
        13047.19043,
        12779.91016,
        12854.79980,
        12493.92969,
        12644.45996,
        12657.54980,
        12720.58008,
        12688.16016,
        12348.75977,
        12368.98047,
        12390.69043,
        12162.58984,
        12032.41992,
        11562.57031,
        11782.66992,
        11834.11035,
        12059.61035,
        11897.65039,
        11713.15039
    ]

    static let chart30min: [Double] = [
        12017.72559,
        12071.18457,
        12075.42480,
        12064.13281,
        12099.58301,
        12077.26074,
        12083.29980,
        12053.39160,
        12034.02441,
        11997.33984,
        11994.63281,
        12094.09180,
        12065.63477
    ]
}
#endif
