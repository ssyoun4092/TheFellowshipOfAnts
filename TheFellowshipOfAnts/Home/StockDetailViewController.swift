//
//  StockDetailViewController.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/04.
//

import UIKit

import SnapKit
import SwiftUI
import TheFellowshipOfAntsKey

class StockDetailViewController: UIViewController {

    // MARK: - Properties
    var stockDatas: StockIndex = StockIndex.stockDummy
    var incomes: [StockIncome] = StockIncome.dummy
    var overviews: [String] = [
        "$" + Double(StockOverview.dummy.marketCap)!.convertToMetrics(),
        "$" + StockOverview.dummy.highIn52Weeks,
        "$" + StockOverview.dummy.lowIn52Weeks,
        StockOverview.dummy.PER,
        StockOverview.dummy.PBR,
        StockOverview.dummy.EPS
    ]

    var companyName: String?
    var symbol: String?
    var coordinator: HomeCoordinator?

    // MARK: - IBOutlets

    let stockDetailView = StockDetailView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupViews()
        stockDetailView.configure(with: companyName ?? "No CompanyName", incomes.reversed())
        let stockValues = stockDatas.details.map { Double($0.close)! }
        stockDetailView.stockGraphChartView.configure(with: stockValues.reversed(), upDown: .down)
        fetchStockOverview()
//        fetchStockValues()
//        fetchAnnualRevenue()
    }

    // MARK: - Methods

    private func setupNavigationBar() {
        title = companyName ?? ""
    }

    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(stockDetailView)

        stockDetailView.overviewCollectionView.dataSource = self
        stockDetailView.overviewCollectionView.delegate = self

        stockDetailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func fetchStockOverview() {
        var tempOvervies: [String] = []

        API<StockOverview>(
            baseURL: TheFellowshipOfAntsRequest.Overview.baseURL,
            params: [
                TheFellowshipOfAntsRequest.Overview.ParamsKey.function: "OVERVIEW",
                TheFellowshipOfAntsRequest.Overview.ParamsKey.symbol: symbol ?? "AAPL"
            ],
            apiKey: TheFellowshipOfAntsRequest.Overview.apiKey
        ).fetch { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let stockOverview):
                print(stockOverview)
                let marketCap = Double(stockOverview.marketCap)!.convertToMetrics()
                tempOvervies.append("$" + marketCap)
                tempOvervies.append("$" + stockOverview.highIn52Weeks)
                tempOvervies.append("$" + stockOverview.lowIn52Weeks)
                tempOvervies.append(stockOverview.PER)
                tempOvervies.append(stockOverview.PBR)
                tempOvervies.append(stockOverview.EPS)

                self.overviews = tempOvervies

                DispatchQueue.main.async {
                    self.stockDetailView.overviewCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchStockValues() {
        API<StockIndex>(
            baseURL: TheFellowshipOfAntsRequest.Indices.baseURL,
            params: [
                TheFellowshipOfAntsRequest.Indices.ParamsKey.symbol: symbol ?? "AAPL",
                TheFellowshipOfAntsRequest.Indices.ParamsKey.interval: "5min",
                TheFellowshipOfAntsRequest.Indices.ParamsKey.outputsize: "78"
            ],
            apiKey: TheFellowshipOfAntsRequest.Indices.apiKey
        ).fetch { [weak self] result in
            switch result {
            case .success(let stockIndex):
                let stockValues = stockIndex.details.map { Double($0.close)! }
                let upDown = UpDown.check(stockValues.last ?? 0, stockValues.first ?? 0)
                DispatchQueue.main.async {
                    self?.stockDetailView.stockGraphChartView.configure(
                        with: stockValues.reversed(),
                        upDown: upDown
                    )
                    self?.stockDetailView.layoutIfNeeded()
                }

            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchAnnualRevenue() {
        API<[StockIncome]>(
            baseURL: TheFellowshipOfAntsRequest.Incomes.baseURL,
            path: symbol ?? "AAPL",
            params: [:],
            apiKey: TheFellowshipOfAntsRequest.Incomes.apiKey
        ).fetch { [weak self] result in
            let companyName = self?.companyName ?? ""
            switch result {
            case .success(let incomes):
                print(incomes)
                DispatchQueue.main.async {
                    self?.stockDetailView.configure(with: companyName, incomes.reversed())
                    self?.stockDetailView.layoutIfNeeded()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
