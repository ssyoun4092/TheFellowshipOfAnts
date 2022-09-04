//
//  StockDetailView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/04.
//

import UIKit
import SnapKit
import SwiftUI
import Kingfisher

class StockDetailView: UIView {

    // MARK: - Properties


    // MARK: - IBOutlets

    let logoImageView = UIImageView()
    let companyNameLabel = UILabel()
    let symbolLabel = UILabel()
    let currentPriceLabel = UILabel()
    let fluctuationRateLabel = UILabel()
    let stockGraphChartView = StockGraphChartView()
    let revenueTitleLabel = UILabel()
    let revenueChartView = RevenueChartView()
    let grossProfitTitleLabel = UILabel()
    let grossProfitChartView = GrossProfitChartView()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLogoImageView()
        setupCompanyNameLabel()
        setupSymbolLabel()
        setupCurrenPriceLabel()
        setupFluctuationRateLabel()
        setupStockGraphChartView()
        stockGraphChartView.configure()
        setupRevenueTitleLabel()
        setupRevenueChartView()
        revenueChartView.configure()
        setupGrossProfitTitleLable()
        setupGrossProfitChartView()
        grossProfitChartView.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StockDetailView {
    private func setupLogoImageView() {
        addSubview(logoImageView)

        logoImageView.kf.setImage(with: URL(string: "https://companiesmarketcap.com/img/company-logos/64/AAPL.png"))

        logoImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(logoImageView.snp.width)
        }
    }

    private func setupCompanyNameLabel() {
        addSubview(companyNameLabel)

        companyNameLabel.text = "애플"
        companyNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)

        companyNameLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
            $0.bottom.equalTo(logoImageView.snp.centerY).offset(-2)
        }
    }

    private func setupSymbolLabel() {
        addSubview(symbolLabel)

        symbolLabel.text = "AAPL"
        symbolLabel.font = .systemFont(ofSize: 14, weight: .medium)

        symbolLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
            $0.top.equalTo(logoImageView.snp.centerY).offset(2)
        }
    }

    private func setupCurrenPriceLabel() {
        addSubview(currentPriceLabel)

        currentPriceLabel.text = "$155.81"
        currentPriceLabel.font = .systemFont(ofSize: 45, weight: .bold)

        currentPriceLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(15)
            $0.leading.equalToSuperview()
        }
    }

    private func setupFluctuationRateLabel() {
        addSubview(fluctuationRateLabel)

        fluctuationRateLabel.text = "-1.37%"
        fluctuationRateLabel.font = .systemFont(ofSize: 25, weight: .regular)
        fluctuationRateLabel.textColor = .systemRed

        fluctuationRateLabel.snp.makeConstraints {
            $0.leading.equalTo(currentPriceLabel.snp.trailing).offset(15)
            $0.bottom.equalTo(currentPriceLabel.snp.bottom).offset(-7)
        }
    }

    private func setupStockGraphChartView() {
        addSubview(stockGraphChartView)

        stockGraphChartView.snp.makeConstraints {
            $0.top.equalTo(fluctuationRateLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
    }

    private func setupRevenueTitleLabel() {
        addSubview(revenueTitleLabel)

        revenueTitleLabel.text = "연간 매출"
        revenueTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        revenueTitleLabel.snp.makeConstraints {
            $0.top.equalTo(stockGraphChartView.snp.bottom).offset(30)
            $0.leading.equalToSuperview()
        }
    }

    private func setupRevenueChartView() {
        addSubview(revenueChartView)

        revenueChartView.snp.makeConstraints {
            $0.top.equalTo(revenueTitleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(175)
        }
    }

    private func setupGrossProfitTitleLable() {
        addSubview(grossProfitTitleLabel)

        grossProfitTitleLabel.text = "연간 이익"
        grossProfitTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        grossProfitTitleLabel.snp.makeConstraints {
            $0.top.equalTo(revenueChartView.snp.bottom).offset(50)
            $0.leading.equalToSuperview()
        }
    }

    private func setupGrossProfitChartView() {
        addSubview(grossProfitChartView)

        grossProfitChartView.snp.makeConstraints {
            $0.top.equalTo(grossProfitTitleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(175)
        }
    }
}

struct StockDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        StockDetailViewController().toPreview()
    }
}
