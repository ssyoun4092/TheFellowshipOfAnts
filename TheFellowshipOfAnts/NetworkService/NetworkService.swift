//
//  NetworkService.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/19.
//

import Foundation

import TheFellowshipOfAntsKey

class NetworkService {
    static func fetchSearchStocks(text: String, completion: @escaping (Result<[SymbolSearchInfo], Error>) -> Void) {
        API<SymbolSearch>(
            baseURL: TheFellowshipOfAntsRequest.SymbolSearch.baseURL,
            params: [
                TheFellowshipOfAntsRequest.SymbolSearch.ParamsKey.symbol: text
            ],
            apiKey: TheFellowshipOfAntsRequest.SymbolSearch.apikey
        ).fetch { result in
            switch result {
            case .success(let searchedSymbols):
                let stocksInUS = searchedSymbols.symbolSearchInfos.filter { $0.country == "United States"}
                completion(.success(stocksInUS))
            case .failure(let error):
                print(#function)
                print(error)
                completion(.failure(error))
            }
        }
    }

    static func fetchLogoURLString(symbols: [String], completion: @escaping (_ logoURLStringOfSymbol: [String: String]) -> Void) {
        let dispatchGroup = DispatchGroup()

        var logoURLStringOfSymbol: [String: String] = [:]

        symbols.forEach { symbol in
            dispatchGroup.enter()

            API<LogoData>(
                baseURL: TheFellowshipOfAntsRequest.Logo.baseURL,
                params: [
                    TheFellowshipOfAntsRequest.Logo.ParamsKey.symbol: symbol
                ],
                apiKey: TheFellowshipOfAntsRequest.Logo.apiKey
            ).fetch { result in
                switch result {
                case .success(let logo):
                    logoURLStringOfSymbol[symbol] = logo.url
                    dispatchGroup.leave()
                case .failure(let error):
                    print(error)
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(logoURLStringOfSymbol)
        }
    }

    static func fetchSearchingStocksInfo(text: String, completion: @escaping (Result<[SearchStock], Error>) -> Void) {
        var tempSearchInfos: [SearchStock] = []
        fetchSearchStocks(text: text) { result in
            switch result {
            case .success(let symbolInfos):
                let symbols = symbolInfos.map { $0.symbol }
                fetchLogoURLString(symbols: symbols) { logoURLStringOfSymbol in
                    for index in 0..<symbolInfos.count {
                        let targetSymbol = symbolInfos[index].symbol
                        let logoURLString = logoURLStringOfSymbol[targetSymbol] ?? ""
                        tempSearchInfos.append(SearchStock(
                            symbol: symbolInfos[index].symbol,
                            instrumentName: symbolInfos[index].instrumentName,
                            country: symbolInfos[index].instrumentName,
                            logoURLString: logoURLString)
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
