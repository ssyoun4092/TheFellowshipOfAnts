import Foundation

// MARK: - Welcome
struct IndexModel: Decodable {
    let values: [Value]
    let status: String
}

// MARK: - Value
struct Value: Decodable {
    let datetime, valueOpen, high, low: String
    let close, volume: String
}
