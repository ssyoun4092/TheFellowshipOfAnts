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
    let ticker: String

    var title: String {
        switch ticker {
        case "IXIC": return "나스닥"
        case "DJI": return "다우지수"
        case "SPX": return "S&P500"
        default: return ""
        }
    }

    enum CodingKeys: String, CodingKey {
        case ticker = "symbol"
    }
}

struct Value: Decodable {
    let date, open, high, low: String
    let close, volume: String

    enum CodingKeys: String, CodingKey {
        case date = "datetime"
        case open, high, low, close, volume
    }
}

extension MajorStockIndexes {
    static let dummy: MajorStockIndexes = MajorStockIndexes(
        IXIC: StockIndex(
            basic: Meta(ticker: "IXIC"),
            values: [
                Value(
                    date: "2022-08-29 15:30:00",
                    open: "12071.16699",
                    high: "12084.66602",
                    low: "12010.55566",
                    close: "12017.72559",
                    volume: "443728000"),
                Value(
                    date: "2022-08-29 15:00:00",
                    open: "12081.07129",
                    high: "12106.45117",
                    low: "12069.75977",
                    close: "12071.18457",
                    volume: "220758000"),
                Value(
                    date: "2022-08-29 14:30:00",
                    open: "12063.55762",
                    high: "12087.72852",
                    low: "12049.69336",
                    close: "12075.42480",
                    volume: "193492000"),
                Value(
                    date: "2022-08-29 14:00:00",
                    open: "12099.70410",
                    high: "12099.92773",
                    low: "12054.68652",
                    close: "12064.13281",
                    volume: "178788000"),
                Value(
                    date: "2022-08-29 13:30:00",
                    open: "12078.58887",
                    high: "12121.61230",
                    low: "12075.95410",
                    close: "12099.58301",
                    volume: "175758000"),
                Value(
                    date: "2022-08-29 13:00:00",
                    open: "12082.58105",
                    high: "12103.35840",
                    low: "12061.55957",
                    close: "12077.26074",
                    volume: "172806000"),
                Value(
                    date: "2022-08-29 12:30:00",
                    open: "12052.94727",
                    high: "12097.04199",
                    low: "12028.59375",
                    close: "12083.29980",
                    volume: "2135246000"),
                Value(
                    date: "2022-08-29 12:00:00",
                    open: "12035.11133",
                    high: "12078.04980",
                    low: "12031.95605",
                    close: "12053.39160",
                    volume: "1877786000"),
                Value(
                    date: "2022-08-29 11:30:00",
                    open: "11997.36914",
                    high: "12039.52148",
                    low: "11984.88965",
                    close: "12034.02441",
                    volume: "207151000"),
                Value(
                    date: "2022-08-29 11:00:00",
                    open: "11992.67676",
                    high: "12020.84180",
                    low: "11982.22852",
                    close: "11997.33984",
                    volume: "215769000"),
                Value(
                    date: "2022-08-29 10:30:00",
                    open: "12091.33594",
                    high: "12104.83008",
                    low: "11991.00684",
                    close: "11994.63281",
                    volume: "1447848627"),
                Value(
                    date: "2022-08-29 10:00:00",
                    open: "12065.14941",
                    high: "12124.81250",
                    low: "12050.71094",
                    close: "12094.09180",
                    volume: "332809422"),
                Value(
                    date: "2022-08-29 09:30:00",
                    open: "12019.79492",
                    high: "12123.67871",
                    low: "12010.65430",
                    close: "12065.63477",
                    volume: "473286127"),
                Value(
                    date: "2022-08-26 15:30:00",
                    open: "12197.44336",
                    high: "12197.76758",
                    low: "12142.48047",
                    close: "12143.97168",
                    volume: "420318000")
            ],
            status: "ok"),
        SPX: StockIndex(
            basic: Meta(ticker: "SPX"),
            values: [
                Value(
                    date: "2022-08-29 15:30:00",
                    open: "4046.79004",
                    high: "4052.16992",
                    low: "4029.17993",
                    close: "4030.94995",
                    volume: "1672961053"),
                Value(
                    date: "2022-08-29 15:00:00",
                    open: "4051.19995",
                    high: "4060.37012",
                    low: "4046.11011",
                    close: "4046.80005",
                    volume: "1444010356"),
                Value(
                    date: "2022-08-29 14:30:00",
                    open: "4045.61011",
                    high: "4054.58008",
                    low: "4042.37012",
                    close: "4051.17993",
                    volume: "3766345540"),
                Value(
                    date: "2022-08-29 14:00:00",
                    open: "4056.20996",
                    high: "4056.26001",
                    low: "4043.03003",
                    close: "4045.56006",
                    volume: "1253684932"),
                Value(
                    date: "2022-08-29 13:30:00",
                    open: "4049.56006",
                    high: "4062.73999",
                    low: "4048.67993",
                    close: "4056.22998",
                    volume: "81156151"),
                Value(
                    date: "2022-08-29 13:00:00",
                    open: "4051.70996",
                    high: "4056.68994",
                    low: "4044.37988",
                    close: "4049.45996",
                    volume: "87211062"),
                Value(
                    date: "2022-08-29 12:30:00",
                    open: "4043.32007",
                    high: "4057.25000",
                    low: "4036.35010",
                    close: "4051.71997",
                    volume: "1856118939"),
                Value(
                    date: "2022-08-29 12:00:00",
                    open: "4038.91992",
                    high: "4049.19995",
                    low: "4038.72998",
                    close: "4043.34009",
                    volume: "86310762"),
                Value(
                    date: "2022-08-29 11:30:00",
                    open: "4027.08008",
                    high: "4039.87988",
                    low: "4024.28003",
                    close: "4038.72998",
                    volume: "96843854"),
                Value(
                    date: "2022-08-29 11:00:00",
                    open: "4019.07007",
                    high: "4031.64990",
                    low: "4018.60010",
                    close: "4027.12012",
                    volume: "688796299"),
                Value(
                    date: "2022-08-29 10:30:00",
                    open: "4040.08008",
                    high: "4044.12988",
                    low: "4017.93994",
                    close: "4019.37988",
                    volume: "1602971126"),
                Value(
                    date: "2022-08-29 10:00:00",
                    open: "4033.84009",
                    high: "4049.45996",
                    low: "4031.02002",
                    close: "4040.33008",
                    volume: "785995876"),
                Value(
                    date: "2022-08-29 09:30:00",
                    open: "4034.58008",
                    high: "4045.47998",
                    low: "4021.60010",
                    close: "4034.38989",
                    volume: "284685931"),
                Value(
                    date: "2022-08-26 15:30:00",
                    open: "4076.45996",
                    high: "4077.03003",
                    low: "4057.77002",
                    close: "4058.29004",
                    volume: "301529634")
            ],
            status: "ok"),
        DJI: StockIndex(
            basic: Meta(ticker: "DJI"),
            values: [
                Value(
                    date: "2022-08-29 15:30:00",
                    open: "32202.69922",
                    high: "32248.14062",
                    low: "32091.97070",
                    close: "32103.00977",
                    volume: "38035523"),
                Value(
                    date: "2022-08-29 15:00:00",
                    open: "32249.00977",
                    high: "32301.49023",
                    low: "32197.50000",
                    close: "32202.91016",
                    volume: "14870868"),
                Value(
                    date: "2022-08-29 14:30:00",
                    open: "32196.58008",
                    high: "32267.73047",
                    low: "32168.74023",
                    close: "32237.23047",
                    volume: "12993921"),
                Value(
                    date: "2022-08-29 14:00:00",
                    open: "32265.47070",
                    high: "32266.24023",
                    low: "32174.64062",
                    close: "32197.31055",
                    volume: "12734492"),
                Value(
                    date: "2022-08-29 13:30:00",
                    open: "32220.67969",
                    high: "32325.16016",
                    low: "32216.00977",
                    close: "32266.03906",
                    volume: "13164930"),
                Value(
                    date: "2022-08-29 13:00:00",
                    open: "32250.33008",
                    high: "32274.77930",
                    low: "32176.38086",
                    close: "32220.61914",
                    volume: "22257917"),
                Value(
                    date: "2022-08-29 12:30:00",
                    open: "32187.98047",
                    high: "32296.91016",
                    low: "32142.00000",
                    close: "32250.40039",
                    volume: "13427460"),
                Value(
                    date: "2022-08-29 12:00:00",
                    open: "32163.58984",
                    high: "32232.59961",
                    low: "32163.58984",
                    close: "32187.44922",
                    volume: "14945365"),
                Value(
                    date: "2022-08-29 11:30:00",
                    open: "32064.48047",
                    high: "32169.43945",
                    low: "32049.66992",
                    close: "32162.13086",
                    volume: "16396743"),
                Value(
                    date: "2022-08-29 11:00:00",
                    open: "31987.25977",
                    high: "32111.92969",
                    low: "31986.00977",
                    close: "32064.73047",
                    volume: "19448255"),
                Value(
                    date: "2022-08-29 10:30:00",
                    open: "32088.42969",
                    high: "32115.16992",
                    low: "31972.78906",
                    close: "31989.15039",
                    volume: "22987483"),
                Value(
                    date: "2022-08-29 10:00:00",
                    open: "32067.01953",
                    high: "32156.67969",
                    low: "32035.06055",
                    close: "32090.35938",
                    volume: "25384199"),
                Value(
                    date: "2022-08-29 09:30:00",
                    open: "32188.00000",
                    high: "32188.00000",
                    low: "32006.66016",
                    close: "32070.32031",
                    volume: "30105965"),
                Value(
                    date: "2022-08-26 15:30:00",
                    open: "32418.17969",
                    high: "32422.88086",
                    low: "32278.22070",
                    close: "32288.10938",
                    volume: "62403577")
            ],
            status: "ok")
    )
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
