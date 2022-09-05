//
//  StockDetailViewController.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/04.
//

import UIKit
import SwiftUI
import SnapKit
import TheFellowshipOfAntsKey

class StockDetailViewController: UIViewController {

    // MARK: - Properties
    var stockDatas: StockIndex = StockIndex.stockDummy
    var incomes: [StockIncome] = StockIncome.dummy

    var companyName: String?
    var symbol: String?
    var coordinator: HomeCoordinator?

    // MARK: - IBOutlets

    let stockDetailView = StockDetailView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        stockDetailView.configure(with: companyName ?? "No CompanyName", incomes.reversed())
        let stockValues = stockDatas.details.map { Double($0.close)! }
        stockDetailView.stockGraphChartView.configure(with: stockValues.reversed(), upDown: .down)
//        fetchStockValues()
//        fetchAnnualRevenue()
    }

    // MARK: - Methods

    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(stockDetailView)

        stockDetailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
                    self?.stockDetailView.stockGraphChartView.configure(with: stockValues.reversed(), upDown: upDown)
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
