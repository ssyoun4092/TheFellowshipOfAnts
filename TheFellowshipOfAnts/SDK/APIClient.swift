//
//  APIClient.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/29.
//

import Foundation

import RxSwift

class API<T: Decodable> {
    var baseURL: String
    var path: String
    var parameters: [String: String]
    var apiKey: String

    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: baseURL + path)!
        var queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        let apiKeyQueryItem = URLQueryItem(name: "apikey", value: apiKey)
        queryItems.append(apiKeyQueryItem)

        urlComponents.queryItems = queryItems

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"

        return request
    }

    init(
        baseURL: String,
        path: String = "",
        params: [String: String],
        apiKey: String = ""
    ) {
        self.baseURL = baseURL
        self.path = path
        self.parameters = params
        self.apiKey = apiKey
    }

    func fetch(completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let apiError = error {
                completion(.failure(apiError))
            }

            guard let response = response as? HTTPURLResponse else { return }

            switch response.statusCode {
            case 200..<300:
                guard let data = data else { return }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    print("==============")
                    completion(.failure(NetworkError.unableToDecode))
                }

            default:
                completion(.failure(NetworkError.clientError))
            }
        }
        .resume()
    }

    func fetchRx() -> Observable<T> {
        return Observable.create { observer -> Disposable in
            URLSession.shared.dataTask(with: self.urlRequest) { data, response, error in
                if let apiError = error {
                    observer.onError(apiError)
                }

                guard let response = response as? HTTPURLResponse else { return }

                switch response.statusCode {
                case 200..<300:
                    guard let data = data else { return }
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(decodedData)
                    } catch {
                        observer.onError(NetworkError.unableToDecode)
                    }

                default:
                    observer.onError(NetworkError.clientError)
                }
            }.resume()

            return Disposables.create()
        }
    }
}

enum NetworkError: Error {
    case clientError
    case unableToDecode
}
