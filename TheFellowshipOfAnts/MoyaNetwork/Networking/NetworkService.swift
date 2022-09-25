//
//  NetworkService.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import Moya
import RxCocoa
import RxSwift
import RxMoya

protocol NetworkServable {
    func request<API>(_ api: API) -> Single<API.ResponseDTO> where API: ServiceAPI
}

class NetworkServiceMoya: NetworkServable {
    func request<API>(_ api: API) -> Single<API.ResponseDTO> where API : ServiceAPI {
        let provider = MoyaProvider<API>()

        return provider.rx.request(api)
            .flatMap { response -> Single<API.ResponseDTO> in
                do {
                    _ = try response.filterSuccessfulStatusCodes()

                    return .just(try response.map(API.ResponseDTO.self))
                } catch MoyaError.statusCode(let response) {
                    print("💩💩💩💩 HTTPStatusCode: \(response.statusCode) 문제가 생겼어요!!!")

                    return .error(MoyaError.statusCode(response))
                } catch MoyaError.jsonMapping(let response) {
                    print("💩💩💩💩 \(response) JSON 형태로 맵핑하는데 문제가 생겼어요!!!")

                    return .error(MoyaError.jsonMapping(response))
                } catch MoyaError.objectMapping(let error, let response) {
                    print("💩💩💩💩 \(response) 디코딩하는데 문제가 생겼어요!!!")

                    return .error(MoyaError.objectMapping(error, response))
                }
            }
    }
}
