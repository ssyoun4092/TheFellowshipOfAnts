//
//  UserDefaultsManager.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/27.
//

import Foundation

import TheFellowshipOfAntsKey

public enum UserDefaultManager {

    @UserDefault(key: TheFellowshipOfAntsKey.UserDefaultKey.recentSearch, defaultValue: [])
    static var recentSearches: [[String]]


    @UserDefault(key: "recentSearchStocks", defaultValue: [])
    static var recentSearchStocks: [UDSModel.RecentSearchStock]
}
