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
    func requestNormal<API>(_ api: API, completion: @escaping (Result<API.ResponseDTO, Error>) -> Void) where API: ServiceAPI
}

class NetworkServiceMoya: NetworkServable {
    init() {}

    func request<API>(_ api: API) -> Single<API.ResponseDTO> where API : ServiceAPI {
        let endPoint = MultiTarget(api)
//        print(#function)
//        print(api)

        return provider.rx.request(endPoint)
            .flatMap { response -> Single<API.ResponseDTO> in
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let decodedData = try JSONDecoder().decode(API.ResponseDTO.self, from: response.data)
                    print("Successfully Decoded!!!!!")
                    return .just(decodedData)
                } catch MoyaError.statusCode(let response) {
                    print("💩💩💩💩 HTTPStatusCode: \(response.statusCode) 문제가 생겼어요!!!")

                    return .error(MoyaError.statusCode(response))
                } catch MoyaError.jsonMapping(let response) {
                    print("💩💩💩💩 \(response) JSON 형태로 맵핑하는데 문제가 생겼어요!!!")

                    return .error(MoyaError.jsonMapping(response))
                } catch MoyaError.objectMapping(let error, let response) {
                    print("error: \(error.localizedDescription)")
                    print("💩💩💩💩 \(response) 디코딩하는데 문제가 생겼어요!!!")

                    return .error(MoyaError.objectMapping(error, response))
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)

                    return .error(NetworkError.unableToDecode)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)

                    return .error(NetworkError.unableToDecode)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)

                    return .error(NetworkError.unableToDecode)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)

                    return .error(NetworkError.unableToDecode)
                } catch {
                    print("error: ", error)

                    return .error(NetworkError.unableToDecode)
                }
            }
    }

    func requestNormal<API>(_ api: API, completion: @escaping (Result<API.ResponseDTO, Error>) -> Void) where API: ServiceAPI {
        let target = MultiTarget(api)
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let decodedData = try JSONDecoder().decode(API.ResponseDTO.self, from: response.data)

                    completion(.success(decodedData))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private let provider = CustomProvider<MultiTarget>()
}
