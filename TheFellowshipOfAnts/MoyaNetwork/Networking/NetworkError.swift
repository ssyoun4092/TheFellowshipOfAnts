//
//  NetworkError.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

enum NetworkErrorMoya: Error {
    case unableToDecode // DTO 디코드 에러
    case invalidResponse(Int) // httpResponse에러
}
