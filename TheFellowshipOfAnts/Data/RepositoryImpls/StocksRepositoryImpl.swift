//
//  RepositoryImpl.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import SwiftSoup
import RxSwift

class StocksRepositoryImpl: StocksRepository {
    let network: NetworkServable
    let crawlNetwork: CrawlServable
    let disposeBag = DisposeBag()

    init(
        network: NetworkServable = NetworkServiceMoya(),
        crawlNetwork: CrawlServable = CrawlService()
    ) {
        self.network = network
        self.crawlNetwork = crawlNetwork
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

    func fetchStockOverview(for symbol: String) -> Observable<Entity.StockOverview> {

        return network.request(StockOverviewAPI(symbol: symbol))
            .compactMap { [weak self] stockOverviewDTO in
                return self?.convertOverviewDTOToEntity(stockOverviewDTO)
            }
            .asObservable()
    }

    func fetchStockPrices(for symbol: String) -> Observable<[Entity.StockPrice]> {
        return network.request(StockPriceAPI(symbol: symbol))
            .compactMap { [weak self] stockPriceDTO in
                return self?.convertStockPriceDTOToEntity(stockPriceDTO)
            }
            .asObservable()
    }

    func fetchMajorStockIndices() -> Observable<[Entity.StockIndice]> {

        return network.request(MajorStockIndicesAPI(
            indicesSymbol: ["IXIC, SPX, DJI"],
            timeInterval: ._5min)
        )
        .compactMap {[weak self] majorStockIndicesDTO in
            return self?.convertMajorStockIndicesDTOToEntity(majorStockIndicesDTO)
        }
        .asObservable()
    }

    func fetchStockIncomeStatements(for symbol: String) -> Observable<[Entity.StockIncomeStatement]> {

        return network.request(StockIncomeStatementAPI(symbol: symbol))
            .compactMap { [weak self] stockIncomeDTO in
                self?.convertStockIncomeStatementDTOToEntity(stockIncomeDTO)
            }
            .asObservable()
    }

    func fetchTop20Stocks() -> Observable<[Entity.RankStock]> {

        return crawlNetwork.request(Top20StocksCrawlAPI())
            .compactMap { [weak self] elementsArray in
                self?.convertCrawledTop20StocksToEntities(elementsArray)
            }
            .asObservable()
    }

    func fetchMajorCommodities() -> Observable<[Entity.Commodity]> {

        return crawlNetwork.request(MajorCommoditiesCrawlAPI())
            .compactMap { [weak self] elementsArray in
                self?.convertCrawledMajorCommoditiesToEntities(elementsArray)
            }
            .asObservable()
    }

    func fetchMajorETFs() -> Observable<[Entity.ETF]> {

        return network.request(MajorETFsAPI())
            .compactMap { [weak self] majorETFsDTO in
                self?.covertMajorETFsDTOToEntities(majorETFsDTO)
            }
            .asObservable()
    }
}

extension StocksRepositoryImpl {
    private func convertMajorStockIndicesDTOToEntity(_ DTO: DTO.MajorStockIndices)
    -> [Entity.StockIndice] {
        let IXICClosedValues = Array(DTO.IXIC.details.map { $0.close })
        let SPXClosedValues = Array(DTO.SPX.details.map { $0.close})
        let DJIClosedValues = Array(DTO.DJI.details.map { $0.close })

        return [
            .init(title: "나스닥 종합지수",
                  prices: IXICClosedValues,
                  upDown: .check(Double(IXICClosedValues.last ?? "0")!, Double(IXICClosedValues.first ?? "0")!)),
            .init(title: "S&P 500",
                  prices: SPXClosedValues,
                  upDown: .check(Double(SPXClosedValues.last ?? "0")!, Double(SPXClosedValues.first ?? "0")!)),
            .init(title: "다우지수",
                  prices: DJIClosedValues,
                  upDown: .check(Double(DJIClosedValues.last ?? "0")!, Double(DJIClosedValues.first ?? "0")!))
        ]
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

    private func convertStockPriceDTOToEntity(_ DTO: DTO.StockPrice) -> [Entity.StockPrice] {

        return DTO.details.map { .init(close: Double($0.close) ?? 0) }
    }

    private func convertStockIncomeStatementDTOToEntity(_ DTO: [DTO.StockIncomeStatement]) -> [Entity.StockIncomeStatement] {

        return DTO.map { .init(symbol: $0.symbol,
                               calendarYear: $0.calendarYear,
                               revenue: $0.revenue,
                               operatingIncome: $0.operatingIncome,
                               operatingIncomeRatio: $0.operatingIncomeRatio) }
    }

    private func convertCrawledTop20StocksToEntities(_ elementsArray: [Elements]) -> [Entity.RankStock] {
        var rankStocks: [Entity.RankStock] = []
        let companyNames = elementsArray[0]
        let symbols = elementsArray[1]
        let prices = elementsArray[2]
        let fluctuationRates = elementsArray[3]
        let logoURLStrings = elementsArray[4]

        do {
            for index in 0..<20 {
                let rank = String(index + 1)
                let companyName = try companyNames[index].text()
                let symbol = try symbols[index].text()
                let price = try prices[index * 3 + 2].text()
                let fluctuationRate = try fluctuationRates[index + 1].text()
                let logoURLString = try logoURLStrings[index].attr("src").description

                let rankStock = Entity.RankStock(
                    rank: rank,
                    companyName: companyName,
                    symbol: symbol,
                    price: price,
                    fluctuationRate: fluctuationRate,
                    logoURLString: CrawlProvider.companiesMarketCap.baseURLString + logoURLString
                )
                rankStocks.append(rankStock)
            }

            return rankStocks
        } catch {
            print("convertingTop20StocksDTOToEntities Error")

            return rankStocks
        }
    }

    private func convertCrawledMajorCommoditiesToEntities(_ elementsArray: [Elements]) -> [Entity.Commodity] {
        var commodities: [Entity.Commodity] = []
        let commoditiesName: [String] = ["Gold", "Silver", "Oil (WTI)", "Copper", "Nickel", "Coffee"]
        let commoditiesNameLink = elementsArray[0]
        let commoditiesPriceLink = elementsArray[1]

        do {
            for index in 0..<commoditiesNameLink.count - 5 {
                let name = try commoditiesNameLink[index + 5].text()
                if !commoditiesName.contains(name) { continue }
                let price = try commoditiesPriceLink[index * 4].text()
                let fluctuationRate = try commoditiesPriceLink[index * 4 + 1].text()

                let commodity = Entity.Commodity(
                    name: name,
                    price: price,
                    fluctuationRate: fluctuationRate
                )
                commodities.append(commodity)
            }

            return commodities
        } catch {
            print("convertCrawledMajorCommoditiesToEntity error")

            return commodities
        }
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

    private func covertMajorETFsDTOToEntities(_ DTO: DTO.MajorETFs) -> [Entity.ETF] {
        var entities: [Entity.ETF] = []

        let etfs: [DTO.MajorETFs.ETF] = [
            DTO.SHY,
            DTO.VIX,
            DTO.TLT,
            DTO.SPY
        ]

        etfs.forEach { etf in
            let prevValue = Double(etf.details.first!.close)!
            let currentValue = Double(etf.details.last!.close)!

            let tempETF = Entity.ETF(
                name: etf.basic.symbol,
                price: etf.details[0].close.floorIfDouble(at: 2),
                fluctuationRate: (((currentValue - prevValue) / prevValue) * 100)
                    .toStringWithFloor(at: 2)
            )
            entities.append(tempETF)
        }

        return entities
    }
}
