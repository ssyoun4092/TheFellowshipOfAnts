//
//  NetworkService.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/19.
//

import Foundation

import TheFellowshipOfAntsKey

class NetworkService {
    static func fetchSearchingStocks(text: String, completion: @escaping (Result<[SymbolSearchInfo], Error>) -> Void) {
        API<SymbolSearch>(
            baseURL: TheFellowshipOfAntsRequest.SymbolSearch.baseURL,
            params: [
                TheFellowshipOfAntsRequest.SymbolSearch.ParamsKey.symbol: text
            ],
            apiKey: TheFellowshipOfAntsRequest.SymbolSearch.apikey
        ).fetch { result in
            switch result {
            case .success(let searchedSymbols):
                let filteredSymbols = searchedSymbols.symbolSearchInfos.filter { $0.country == "United States"}
                completion(.success(filteredSymbols))
            case .failure(let error):
                print(#function)
                print(error)
                completion(.failure(error))
            }
        }
    }

    static func fetchLogoURLString(symbols: [String], completion: @escaping (_ urlStrings: [String]) -> Void) {
        let dispatchGroup = DispatchGroup()
        var tempURLStrings: [String] = []
        symbols.forEach { symbol in
            dispatchGroup.enter()
            API<Logo>(
                baseURL: TheFellowshipOfAntsRequest.Logo.baseURL,
                params: [
                    TheFellowshipOfAntsRequest.Logo.ParamsKey.symbol: symbol
                ],
                apiKey: TheFellowshipOfAntsRequest.Logo.apiKey
            ).fetch { result in
                switch result {
                case .success(let logo):
                    tempURLStrings.append(logo.url)
                    dispatchGroup.leave()
                case .failure(let error):
                    print(error)
                    tempURLStrings.append("")
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(tempURLStrings)
        }
    }

    static func fetchSearchingStocksInfo(text: String, completion: @escaping (Result<[SearchedStock], Error>) -> Void) {
        var tempSearchInfos: [SearchedStock] = []
        fetchSearchingStocks(text: text) { result in
            switch result {
            case .success(let symbolInfos):
                let symbols = symbolInfos.map { $0.symbol }
                fetchLogoURLString(symbols: symbols) { urlStrings in
                    for index in 0..<symbolInfos.count {
                        tempSearchInfos.append(SearchedStock(
                            symbol: symbolInfos[index].symbol,
                            instrumentName: symbolInfos[index].instrumentName,
                            country: symbolInfos[index].instrumentName,
                            logoURLString: urlStrings[index])
                        )
                    }
                    completion(.success(tempSearchInfos))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func translateKoreanToEnglish(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        let papagoURL = URL(string: TheFellowshipOfAntsRequest.Translate.baseURL)

        var request = URLRequest(url: papagoURL!)
        request.httpMethod = "POST"
        request.addValue(
            TheFellowshipOfAntsRequest.Translate.clientID,
            forHTTPHeaderField: "X-Naver-Client-Id"
        )
        request.addValue(
            TheFellowshipOfAntsRequest.Translate.clientSecret,
            forHTTPHeaderField: "X-Naver-Client-Secret"
        )

        let parameters = "source=ko&target=en&text=\(text)"
        let paramData = parameters.data(using: .utf8)
        request.httpBody = paramData
        request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let apiError = error {
                completion(.failure(apiError))
            }
            guard let response = response as? HTTPURLResponse else { return }

            switch response.statusCode {
            case 200..<300:
                guard let data = data else { return }
                do {
                    let decodedData = try JSONDecoder().decode(Translated.self, from: data)
                    completion(.success(decodedData.message.result.translatedText))
                } catch {
                    completion(.failure(NetworkError.unableToDecode))
                }

            default:
                completion(.failure(NetworkError.unableToDecode))
            }
        }
        .resume()
    }
}
