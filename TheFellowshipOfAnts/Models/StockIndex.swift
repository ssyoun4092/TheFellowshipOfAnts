import Foundation


struct MajorStockIndexes: Decodable {
    let IXIC, SPX, DJI: StockIndex
}

/// 주가지수 모델
struct StockIndex: Decodable {
    let basic: StockIndexBasic
    let details: [StockIndexDetail]
    let status: String

    enum CodingKeys: String, CodingKey {
        case basic = "meta"
        case details = "values"
        case status
    }
}


struct StockIndexBasic: Decodable {
    let symbol: String

    var title: String {
        switch symbol {
        case "IXIC": return "나스닥"
        case "DJI": return "다우지수"
        case "SPX": return "S&P500"
        default: return ""
        }
    }

    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
    }
}

struct StockIndexDetail: Decodable {
    let date, open, high, low: String
    let close, volume: String

    enum CodingKeys: String, CodingKey {
        case date = "datetime"
        case open, high, low, close, volume
    }
}

extension MajorStockIndexes {
    static let IndexesDummy: MajorStockIndexes = MajorStockIndexes(
        IXIC: StockIndex(
            basic: StockIndexBasic(symbol: "IXIC"),
            details: [
                StockIndexDetail(
                    date: "2022-08-29 15:30:00",
                    open: "12071.16699",
                    high: "12084.66602",
                    low: "12010.55566",
                    close: "12017.72559",
                    volume: "443728000"),
                StockIndexDetail(
                    date: "2022-08-29 15:00:00",
                    open: "12081.07129",
                    high: "12106.45117",
                    low: "12069.75977",
                    close: "12071.18457",
                    volume: "220758000"),
                StockIndexDetail(
                    date: "2022-08-29 14:30:00",
                    open: "12063.55762",
                    high: "12087.72852",
                    low: "12049.69336",
                    close: "12075.42480",
                    volume: "193492000"),
                StockIndexDetail(
                    date: "2022-08-29 14:00:00",
                    open: "12099.70410",
                    high: "12099.92773",
                    low: "12054.68652",
                    close: "12064.13281",
                    volume: "178788000"),
                StockIndexDetail(
                    date: "2022-08-29 13:30:00",
                    open: "12078.58887",
                    high: "12121.61230",
                    low: "12075.95410",
                    close: "12099.58301",
                    volume: "175758000"),
                StockIndexDetail(
                    date: "2022-08-29 13:00:00",
                    open: "12082.58105",
                    high: "12103.35840",
                    low: "12061.55957",
                    close: "12077.26074",
                    volume: "172806000"),
                StockIndexDetail(
                    date: "2022-08-29 12:30:00",
                    open: "12052.94727",
                    high: "12097.04199",
                    low: "12028.59375",
                    close: "12083.29980",
                    volume: "2135246000"),
                StockIndexDetail(
                    date: "2022-08-29 12:00:00",
                    open: "12035.11133",
                    high: "12078.04980",
                    low: "12031.95605",
                    close: "12053.39160",
                    volume: "1877786000"),
                StockIndexDetail(
                    date: "2022-08-29 11:30:00",
                    open: "11997.36914",
                    high: "12039.52148",
                    low: "11984.88965",
                    close: "12034.02441",
                    volume: "207151000"),
                StockIndexDetail(
                    date: "2022-08-29 11:00:00",
                    open: "11992.67676",
                    high: "12020.84180",
                    low: "11982.22852",
                    close: "11997.33984",
                    volume: "215769000"),
                StockIndexDetail(
                    date: "2022-08-29 10:30:00",
                    open: "12091.33594",
                    high: "12104.83008",
                    low: "11991.00684",
                    close: "11994.63281",
                    volume: "1447848627"),
                StockIndexDetail(
                    date: "2022-08-29 10:00:00",
                    open: "12065.14941",
                    high: "12124.81250",
                    low: "12050.71094",
                    close: "12094.09180",
                    volume: "332809422"),
                StockIndexDetail(
                    date: "2022-08-29 09:30:00",
                    open: "12019.79492",
                    high: "12123.67871",
                    low: "12010.65430",
                    close: "12065.63477",
                    volume: "473286127"),
                StockIndexDetail(
                    date: "2022-08-26 15:30:00",
                    open: "12197.44336",
                    high: "12197.76758",
                    low: "12142.48047",
                    close: "12143.97168",
                    volume: "420318000")
            ],
            status: "ok"),
        SPX: StockIndex(
            basic: StockIndexBasic(symbol: "SPX"),
            details: [
                StockIndexDetail(
                    date: "2022-08-29 15:30:00",
                    open: "4046.79004",
                    high: "4052.16992",
                    low: "4029.17993",
                    close: "4030.94995",
                    volume: "1672961053"),
                StockIndexDetail(
                    date: "2022-08-29 15:00:00",
                    open: "4051.19995",
                    high: "4060.37012",
                    low: "4046.11011",
                    close: "4046.80005",
                    volume: "1444010356"),
                StockIndexDetail(
                    date: "2022-08-29 14:30:00",
                    open: "4045.61011",
                    high: "4054.58008",
                    low: "4042.37012",
                    close: "4051.17993",
                    volume: "3766345540"),
                StockIndexDetail(
                    date: "2022-08-29 14:00:00",
                    open: "4056.20996",
                    high: "4056.26001",
                    low: "4043.03003",
                    close: "4045.56006",
                    volume: "1253684932"),
                StockIndexDetail(
                    date: "2022-08-29 13:30:00",
                    open: "4049.56006",
                    high: "4062.73999",
                    low: "4048.67993",
                    close: "4056.22998",
                    volume: "81156151"),
                StockIndexDetail(
                    date: "2022-08-29 13:00:00",
                    open: "4051.70996",
                    high: "4056.68994",
                    low: "4044.37988",
                    close: "4049.45996",
                    volume: "87211062"),
                StockIndexDetail(
                    date: "2022-08-29 12:30:00",
                    open: "4043.32007",
                    high: "4057.25000",
                    low: "4036.35010",
                    close: "4051.71997",
                    volume: "1856118939"),
                StockIndexDetail(
                    date: "2022-08-29 12:00:00",
                    open: "4038.91992",
                    high: "4049.19995",
                    low: "4038.72998",
                    close: "4043.34009",
                    volume: "86310762"),
                StockIndexDetail(
                    date: "2022-08-29 11:30:00",
                    open: "4027.08008",
                    high: "4039.87988",
                    low: "4024.28003",
                    close: "4038.72998",
                    volume: "96843854"),
                StockIndexDetail(
                    date: "2022-08-29 11:00:00",
                    open: "4019.07007",
                    high: "4031.64990",
                    low: "4018.60010",
                    close: "4027.12012",
                    volume: "688796299"),
                StockIndexDetail(
                    date: "2022-08-29 10:30:00",
                    open: "4040.08008",
                    high: "4044.12988",
                    low: "4017.93994",
                    close: "4019.37988",
                    volume: "1602971126"),
                StockIndexDetail(
                    date: "2022-08-29 10:00:00",
                    open: "4033.84009",
                    high: "4049.45996",
                    low: "4031.02002",
                    close: "4040.33008",
                    volume: "785995876"),
                StockIndexDetail(
                    date: "2022-08-29 09:30:00",
                    open: "4034.58008",
                    high: "4045.47998",
                    low: "4021.60010",
                    close: "4034.38989",
                    volume: "284685931"),
                StockIndexDetail(
                    date: "2022-08-26 15:30:00",
                    open: "4076.45996",
                    high: "4077.03003",
                    low: "4057.77002",
                    close: "4058.29004",
                    volume: "301529634")
            ],
            status: "ok"),
        DJI: StockIndex(
            basic: StockIndexBasic(symbol: "DJI"),
            details: [
                StockIndexDetail(
                    date: "2022-08-29 15:30:00",
                    open: "32202.69922",
                    high: "32248.14062",
                    low: "32091.97070",
                    close: "32103.00977",
                    volume: "38035523"),
                StockIndexDetail(
                    date: "2022-08-29 15:00:00",
                    open: "32249.00977",
                    high: "32301.49023",
                    low: "32197.50000",
                    close: "32202.91016",
                    volume: "14870868"),
                StockIndexDetail(
                    date: "2022-08-29 14:30:00",
                    open: "32196.58008",
                    high: "32267.73047",
                    low: "32168.74023",
                    close: "32237.23047",
                    volume: "12993921"),
                StockIndexDetail(
                    date: "2022-08-29 14:00:00",
                    open: "32265.47070",
                    high: "32266.24023",
                    low: "32174.64062",
                    close: "32197.31055",
                    volume: "12734492"),
                StockIndexDetail(
                    date: "2022-08-29 13:30:00",
                    open: "32220.67969",
                    high: "32325.16016",
                    low: "32216.00977",
                    close: "32266.03906",
                    volume: "13164930"),
                StockIndexDetail(
                    date: "2022-08-29 13:00:00",
                    open: "32250.33008",
                    high: "32274.77930",
                    low: "32176.38086",
                    close: "32220.61914",
                    volume: "22257917"),
                StockIndexDetail(
                    date: "2022-08-29 12:30:00",
                    open: "32187.98047",
                    high: "32296.91016",
                    low: "32142.00000",
                    close: "32250.40039",
                    volume: "13427460"),
                StockIndexDetail(
                    date: "2022-08-29 12:00:00",
                    open: "32163.58984",
                    high: "32232.59961",
                    low: "32163.58984",
                    close: "32187.44922",
                    volume: "14945365"),
                StockIndexDetail(
                    date: "2022-08-29 11:30:00",
                    open: "32064.48047",
                    high: "32169.43945",
                    low: "32049.66992",
                    close: "32162.13086",
                    volume: "16396743"),
                StockIndexDetail(
                    date: "2022-08-29 11:00:00",
                    open: "31987.25977",
                    high: "32111.92969",
                    low: "31986.00977",
                    close: "32064.73047",
                    volume: "19448255"),
                StockIndexDetail(
                    date: "2022-08-29 10:30:00",
                    open: "32088.42969",
                    high: "32115.16992",
                    low: "31972.78906",
                    close: "31989.15039",
                    volume: "22987483"),
                StockIndexDetail(
                    date: "2022-08-29 10:00:00",
                    open: "32067.01953",
                    high: "32156.67969",
                    low: "32035.06055",
                    close: "32090.35938",
                    volume: "25384199"),
                StockIndexDetail(
                    date: "2022-08-29 09:30:00",
                    open: "32188.00000",
                    high: "32188.00000",
                    low: "32006.66016",
                    close: "32070.32031",
                    volume: "30105965"),
                StockIndexDetail(
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
extension StockIndex {
    static let stockDummy: StockIndex = StockIndex(
        basic: StockIndexBasic(symbol: "AAPL"),
        details:  [
            StockIndexDetail(
                date: "2022-09-02 15:55:00",
                open: "155.97000",
                high: "155.99001",
                low: "155.39500",
                close: "155.81000",
                volume: "1211208"),
            StockIndexDetail(
                date: "2022-09-02 15:50:00",
                open: "155.41000",
                high: "155.82001",
                low: "155.32001",
                close: "155.73000",
                volume: "222238"),
            StockIndexDetail(
                date: "2022-09-02 15:45:00",
                open: "154.99001",
                high: "155.48990",
                low: "154.96500",
                close: "155.45000",
                volume: "470216"),
            StockIndexDetail(
                date: "2022-09-02 15:40:00",
                open: "155.28000",
                high: "155.33000",
                low: "154.98100",
                close: "155.00999",
                volume: "235423"),
            StockIndexDetail(
                date: "2022-09-02 15:35:00",
                open: "155.50999",
                high: "155.52000",
                low: "155.08940",
                close: "155.25999",
                volume: "205316"),
            StockIndexDetail(
                date: "2022-09-02 15:30:00",
                open: "155.85001",
                high: "155.88000",
                low: "155.50999",
                close: "155.52000",
                volume: "181549"),
            StockIndexDetail(
                date: "2022-09-02 15:25:00",
                open: "155.62000",
                high: "155.97000",
                low: "155.50999",
                close: "155.88000",
                volume: "203712"),
            StockIndexDetail(
                date: "2022-09-02 15:20:00",
                open: "156.06000",
                high: "156.31000",
                low: "155.54500",
                close: "155.60001",
                volume: "223117"),
            StockIndexDetail(
                date: "2022-09-02 15:15:00",
                open: "156.11000",
                high: "156.31000",
                low: "155.92000",
                close: "156.08000",
                volume: "114572"),
            StockIndexDetail(
                date: "2022-09-02 15:10:00",
                open: "156.16000",
                high: "156.31000",
                low: "155.98000",
                close: "156.14999",
                volume: "171561"),
            StockIndexDetail(
                date: "2022-09-02 15:05:00",
                open: "156.38000",
                high: "156.50500",
                low: "156.14000",
                close: "156.19000",
                volume: "105158"),
            StockIndexDetail(
                date: "2022-09-02 15:00:00",
                open: "155.99001",
                high: "156.50000",
                low: "155.89999",
                close: "156.35001",
                volume: "80312"),
            StockIndexDetail(
                date: "2022-09-02 14:55:00",
                open: "156.19000",
                high: "156.20621",
                low: "155.88000",
                close: "155.98000",
                volume: "66392"),
            StockIndexDetail(
                date: "2022-09-02 14:50:00",
                open: "156.28000",
                high: "156.39999",
                low: "156.20000",
                close: "156.23000",
                volume: "88837"),
            StockIndexDetail(
                date: "2022-09-02 14:45:00",
                open: "156.42000",
                high: "156.50980",
                low: "156.22000",
                close: "156.28000",
                volume: "71830"),
            StockIndexDetail(
                date: "2022-09-02 14:40:00",
                open: "156.48000",
                high: "156.56500",
                low: "156.25999",
                close: "156.49001",
                volume: "70366"),
            StockIndexDetail(
                date: "2022-09-02 14:35:00",
                open: "156.25999",
                high: "156.56000",
                low: "156.12000",
                close: "156.47000",
                volume: "88021"),
            StockIndexDetail(
                date: "2022-09-02 14:30:00",
                open: "156.48000",
                high: "156.48500",
                low: "156.19000",
                close: "156.28000",
                volume: "82115"),
            StockIndexDetail(
                date: "2022-09-02 14:25:00",
                open: "156.03000",
                high: "156.55000",
                low: "156.00999",
                close: "156.41000",
                volume: "95099"),
            StockIndexDetail(
                date: "2022-09-02 14:20:00",
                open: "156.05000",
                high: "156.18340",
                low: "155.97000",
                close: "156.07001",
                volume: "53337"),
            StockIndexDetail(
                date: "2022-09-02 14:15:00",
                open: "155.95000",
                high: "156.16000",
                low: "155.85010",
                close: "156.03999",
                volume: "86899"),
            StockIndexDetail(
                date: "2022-09-02 14:10:00",
                open: "156.00000",
                high: "156.13000",
                low: "155.79500",
                close: "156.00999",
                volume: "117609"),
            StockIndexDetail(
                date: "2022-09-02 14:05:00",
                open: "155.94000",
                high: "156.08000",
                low: "155.68500",
                close: "155.97000",
                volume: "86234"),
            StockIndexDetail(
                date: "2022-09-02 14:00:00",
                open: "155.66000",
                high: "156.03999",
                low: "155.64999",
                close: "155.92999",
                volume: "149330"),
            StockIndexDetail(
                date: "2022-09-02 13:55:00",
                open: "155.91000",
                high: "155.95010",
                low: "155.65010",
                close: "155.71001",
                volume: "157980"),
            StockIndexDetail(
                date: "2022-09-02 13:50:00",
                open: "156.03999",
                high: "156.13901",
                low: "155.78999",
                close: "155.92999",
                volume: "167036"),
            StockIndexDetail(
                date: "2022-09-02 13:45:00",
                open: "156.50000",
                high: "156.78500",
                low: "156.05000",
                close: "156.08000",
                volume: "249617"),
            StockIndexDetail(
                date: "2022-09-02 13:40:00",
                open: "156.30000",
                high: "156.59911",
                low: "156.25500",
                close: "156.53999",
                volume: "178610"),
            StockIndexDetail(
                date: "2022-09-02 13:35:00",
                open: "156.24001",
                high: "156.60500",
                low: "156.09000",
                close: "156.34000",
                volume: "103263"),
            StockIndexDetail(
                date: "2022-09-02 13:30:00",
                open: "156.35001",
                high: "156.56000",
                low: "156.19000",
                close: "156.25999",
                volume: "130077"),
            StockIndexDetail(
                date: "2022-09-02 13:25:00",
                open: "156.34000",
                high: "156.48000",
                low: "156.28000",
                close: "156.39999",
                volume: "128720"),
            StockIndexDetail(
                date: "2022-09-02 13:20:00",
                open: "157.21001",
                high: "157.23000",
                low: "156.31000",
                close: "156.39000",
                volume: "187471"),
            StockIndexDetail(
                date: "2022-09-02 13:15:00",
                open: "157.03999",
                high: "157.45000",
                low: "156.80000",
                close: "157.22000",
                volume: "72311"),
            StockIndexDetail(
                date: "2022-09-02 13:10:00",
                open: "157.05000",
                high: "157.17999",
                low: "156.78999",
                close: "157.03000",
                volume: "89838"),
            StockIndexDetail(
                date: "2022-09-02 13:05:00",
                open: "157.22000",
                high: "157.27000",
                low: "156.87000",
                close: "157.03000",
                volume: "118080"),
            StockIndexDetail(
                date: "2022-09-02 13:00:00",
                open: "157.63000",
                high: "157.72330",
                low: "156.78999",
                close: "157.19000",
                volume: "188449"),
            StockIndexDetail(
                date: "2022-09-02 12:55:00",
                open: "157.64999",
                high: "157.81911",
                low: "157.48000",
                close: "157.67999",
                volume: "137839"),
            StockIndexDetail(
                date: "2022-09-02 12:50:00",
                open: "157.70000",
                high: "157.75000",
                low: "157.20000",
                close: "157.64000",
                volume: "180562"),
            StockIndexDetail(
                date: "2022-09-02 12:45:00",
                open: "157.70000",
                high: "157.89000",
                low: "157.50999",
                close: "157.75000",
                volume: "75478"),
            StockIndexDetail(
                date: "2022-09-02 12:40:00",
                open: "158.09000",
                high: "158.19820",
                low: "157.75999",
                close: "157.78999",
                volume: "215359"),
            StockIndexDetail(
                date: "2022-09-02 12:35:00",
                open: "158.50000",
                high: "158.55000",
                low: "157.95000",
                close: "158.16000",
                volume: "80110"),
            StockIndexDetail(
                date: "2022-09-02 12:30:00",
                open: "158.62000",
                high: "158.83369",
                low: "158.21001",
                close: "158.50000",
                volume: "194229"),
            StockIndexDetail(
                date: "2022-09-02 12:25:00",
                open: "158.82001",
                high: "158.86000",
                low: "158.58189",
                close: "158.66000",
                volume: "126961"),
            StockIndexDetail(
                date: "2022-09-02 12:20:00",
                open: "159.17000",
                high: "159.25999",
                low: "158.55000",
                close: "158.86000",
                volume: "139924"),
            StockIndexDetail(
                date: "2022-09-02 12:15:00",
                open: "159.58000",
                high: "159.60001",
                low: "159.16000",
                close: "159.17999",
                volume: "143894"),
            StockIndexDetail(
                date: "2022-09-02 12:10:00",
                open: "159.58000",
                high: "159.70000",
                low: "159.42999",
                close: "159.61000",
                volume: "101455"),
            StockIndexDetail(
                date: "2022-09-02 12:05:00",
                open: "159.69000",
                high: "159.72000",
                low: "159.49001",
                close: "159.59000",
                volume: "64450"),
            StockIndexDetail(
                date: "2022-09-02 12:00:00",
                open: "159.81000",
                high: "159.89999",
                low: "159.60001",
                close: "159.70000",
                volume: "64457"),
            StockIndexDetail(
                date: "2022-09-02 11:55:00",
                open: "159.89999",
                high: "159.97501",
                low: "159.70000",
                close: "159.78000",
                volume: "80749"),
            StockIndexDetail(
                date: "2022-09-02 11:50:00",
                open: "159.86000",
                high: "159.98000",
                low: "159.78000",
                close: "159.92000",
                volume: "79726"),
            StockIndexDetail(
                date: "2022-09-02 11:45:00",
                open: "159.59000",
                high: "159.92081",
                low: "159.52000",
                close: "159.84000",
                volume: "61261"),
            StockIndexDetail(
                date: "2022-09-02 11:40:00",
                open: "159.94000",
                high: "159.96500",
                low: "159.42000",
                close: "159.59000",
                volume: "69956"),
            StockIndexDetail(
                date: "2022-09-02 11:35:00",
                open: "159.92999",
                high: "160.06000",
                low: "159.83009",
                close: "159.94000",
                volume: "44778"),
            StockIndexDetail(
                date: "2022-09-02 11:30:00",
                open: "159.94000",
                high: "160.12000",
                low: "159.73000",
                close: "159.89999",
                volume: "87273"),
            StockIndexDetail(
                date: "2022-09-02 11:25:00",
                open: "159.85001",
                high: "159.99001",
                low: "159.70000",
                close: "159.92999",
                volume: "179656"),
            StockIndexDetail(
                date: "2022-09-02 11:20:00",
                open: "159.83000",
                high: "159.94000",
                low: "159.76601",
                close: "159.85001",
                volume: "100688"),
            StockIndexDetail(
                date: "2022-09-02 11:15:00",
                open: "159.73000",
                high: "159.89000",
                low: "159.49500",
                close: "159.85001",
                volume: "138200"),
            StockIndexDetail(
                date: "2022-09-02 11:10:00",
                open: "159.47000",
                high: "159.75000",
                low: "159.42500",
                close: "159.74001",
                volume: "148784"),
            StockIndexDetail(
                date: "2022-09-02 11:05:00",
                open: "159.72000",
                high: "159.81850",
                low: "159.32001",
                close: "159.46001",
                volume: "168440"),
            StockIndexDetail(
                date: "2022-09-02 11:00:00",
                open: "159.47000",
                high: "159.71001",
                low: "159.34000",
                close: "159.67999",
                volume: "191590"),
            StockIndexDetail(
                date: "2022-09-02 10:55:00",
                open: "159.28999",
                high: "159.47000",
                low: "158.98000",
                close: "159.45000",
                volume: "172122"),
            StockIndexDetail(
                date: "2022-09-02 10:50:00",
                open: "159.86000",
                high: "159.97000",
                low: "159.30000",
                close: "159.30000",
                volume: "190397"),
            StockIndexDetail(
                date: "2022-09-02 10:45:00",
                open: "159.97000",
                high: "160.02499",
                low: "159.78000",
                close: "159.86000",
                volume: "67409"),
            StockIndexDetail(
                date: "2022-09-02 10:40:00",
                open: "160.13000",
                high: "160.28000",
                low: "159.92999",
                close: "159.97000",
                volume: "143944"),
            StockIndexDetail(
                date: "2022-09-02 10:35:00",
                open: "160.31000",
                high: "160.36000",
                low: "160.03999",
                close: "160.06000",
                volume: "134153"),
            StockIndexDetail(
                date: "2022-09-02 10:30:00",
                open: "160.08000",
                high: "160.36200",
                low: "160.06000",
                close: "160.30000",
                volume: "166374"),
            StockIndexDetail(
                date: "2022-09-02 10:25:00",
                open: "159.92000",
                high: "160.17000",
                low: "159.78110",
                close: "160.10001",
                volume: "133743"),
            StockIndexDetail(
                date: "2022-09-02 10:20:00",
                open: "159.67999",
                high: "160.09000",
                low: "159.53999",
                close: "159.95000",
                volume: "405142"),
            StockIndexDetail(
                date: "2022-09-02 10:15:00",
                open: "159.57001",
                high: "159.82809",
                low: "159.53999",
                close: "159.66000",
                volume: "151357"),
            StockIndexDetail(
                date: "2022-09-02 10:10:00",
                open: "159.00999",
                high: "159.59000",
                low: "158.97009",
                close: "159.56000",
                volume: "152438"),
            StockIndexDetail(
                date: "2022-09-02 10:05:00",
                open: "158.85001",
                high: "159.05000",
                low: "158.66010",
                close: "158.99001",
                volume: "190470"),
            StockIndexDetail(
                date: "2022-09-02 10:00:00",
                open: "159.35001",
                high: "159.42000",
                low: "158.72000",
                close: "158.80000",
                volume: "214131"),
            StockIndexDetail(
                date: "2022-09-02 09:55:00",
                open: "159.63000",
                high: "159.78000",
                low: "159.25999",
                close: "159.32001",
                volume: "198019"),
            StockIndexDetail(
                date: "2022-09-02 09:50:00",
                open: "159.46001",
                high: "159.87000",
                low: "159.39500",
                close: "159.56000",
                volume: "212940"),
            StockIndexDetail(
                date: "2022-09-02 09:45:00",
                open: "159.20000",
                high: "159.58929",
                low: "159.17999",
                close: "159.39000",
                volume: "158578"),
            StockIndexDetail(
                date: "2022-09-02 09:40:00",
                open: "159.77000",
                high: "159.85001",
                low: "159.14000",
                close: "159.20000",
                volume: "152180"),
            StockIndexDetail(
                date: "2022-09-02 09:35:00",
                open: "159.22000",
                high: "159.87000",
                low: "159.17999",
                close: "159.75000",
                volume: "241477"),
            StockIndexDetail(
                date: "2022-09-02 09:30:00",
                open: "159.89999",
                high: "160.00000",
                low: "159.14999",
                close: "159.23000",
                volume: "334846")
        ],
        status: "ok")
}

#if DEBUG
struct IndexesDummy {
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
