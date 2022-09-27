//
//  RepositoryImpl.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import RxSwift

class StocksRepositoryImpl: StocksRepository {
    let network: NetworkServable
    let disposeBag = DisposeBag()
    init(network: NetworkServable = NetworkServiceMoya()) {
        self.network = network
    }

    func searchStockList(text: String) -> Observable<[Entity.SearchStock]> {
        let publishSubject = PublishSubject<[Entity.SearchStock]>()
        let dispatchGroup = DispatchGroup()
        var tempSearchStocks: [Entity.SearchStock] = []
        var dictLogoURLStringSymbol: [String: String] = [:]

        let fetchedSymbols = network.request(SearchStockAPI(symbol: text))
            .map({ $0.SearchStockInfos.filter { $0.country == "United States" } })
            .do { [unowned self] dto in
                tempSearchStocks = self.convertSearchStockDTOToEntity(dto)
            }
            .map { $0.map { $0.symbol } }

        fetchedSymbols
            .subscribe(onSuccess: { [weak self] symbols in
                guard let self = self else { return }

                symbols.forEach { symbol in
                    dispatchGroup.enter()
                    self.fetchLogoURLString(symbol: symbol)
                        .subscribe(onSuccess: {
                            dictLogoURLStringSymbol[symbol] = $0.url
                            dispatchGroup.leave()
                        })
                        .disposed(by: self.disposeBag)
                }

                dispatchGroup.notify(queue: .main) {
                    for index in 0..<dictLogoURLStringSymbol.count {
                        let symbol: String = tempSearchStocks[index].symbol
                        let logoURLString = dictLogoURLStringSymbol[symbol] ?? ""
                        tempSearchStocks[index].logoURLString = logoURLString
                    }
                    publishSubject.onNext(tempSearchStocks)
                }
            })
            .disposed(by: disposeBag)

        return publishSubject
            .asObservable()
    }

    func fetchStockOverview(symbol: String) -> Observable<Entity.StockOverview> {
        return network.request(StockOverviewAPI(symbol: symbol))
            .compactMap { [weak self] stockOverviewDTO in
                return self?.convertOverviewDTOToEntity(stockOverviewDTO)
            }
            .asObservable()
    }

    private func convertOverviewDTOToEntity(_ DTO: DTO.StockOverview) -> Entity.StockOverview {
        return .init(
            marketCap: DTO.marketCapitalization,
            PER: DTO.PER,
            PBR: DTO.PBR,
            EPS: DTO.EPS,
            the52WeekHigh: DTO.the52WeekHigh,
            the52WeekLow: DTO.the52WeekLow
        )
    }

    private func convertSearchStockDTOToEntity(_ DTO: [DTO.SearchStocks.SearchStockInfo]) -> [Entity.SearchStock] {
        DTO.map { DTO -> Entity.SearchStock in
                .init(
                    symbol: DTO.symbol,
                    companyName: DTO.companyName,
                    logoURLString: ""
                )
        }
    }

    private func fetchLogoURLString(symbol: String) -> Single<DTO.Logo> {

        return network.request(LogoAPI(symbol: symbol))
    }
}
