import Foundation

struct IndicesModel: Decodable {
//    let meta: Meta?
    let values: [Value]
}

//// MARK: - Meta
//struct Meta: Decodable {
//    let symbol, interval, currency, exchange_timezone: String?
//    let exchange, mic_code, type: String?
//}

// MARK: - Value
struct Value: Decodable {
    let date, close: String

    enum CodingKeys: String, CodingKey {
        case close
        case date = "datetime"
    }
}


//struct Value: Decodable {
//    let date, close: String?
//
//    enum CodingKeys: String, CodingKey {
//        case date = "datetime"
//    }
//}
