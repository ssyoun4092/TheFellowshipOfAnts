//
//  UserDefaults.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Codable> {
    private let key: String
    private let defaultValue: T
    public let storage: UserDefaults

    init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }

    var wrappedValue: T {
        get {
            guard let data = self.storage.object(forKey: key) as? Data else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }

        set {
            let data = try? JSONEncoder().encode(newValue)

            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
