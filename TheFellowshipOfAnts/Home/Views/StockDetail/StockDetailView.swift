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

    let scrollView = UIScrollView()
    let contentView = UIView()

    let logoImageView = UIImageView()
    let companyNameLabel = UILabel()
    let symbolLabel = UILabel()

    let currentPriceLabel = UILabel()
    let fluctuationRateLabel = UILabel()

    let chartsVStack = UIStackView()

    let stockGraphChartView = StockGraphChartView()

    let revenueVStack = UIStackView()
    let revenueTitleLabel = UILabel()
    let revenueChartView = AbsoluteValueBarChartView()

    let grossProfitVStack = UIStackView()
    let grossProfitTitleLabel = UILabel()
    let grossProfitChartView = AbsoluteValueBarChartView()

    let grossProfitRatioVStack = UIStackView()
    let grossProfitRatioTitleLabel = UILabel()
    let grossProfitRatioChartView = PercentageValueBarChartView()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupScrollView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with companyName: String, _ incomes: [StockIncome]) {
        logoImageView.kf.setImage(with: URL(string: "https://logo.clearbit.com/\(companyName).com"))
        companyNameLabel.text = companyName
        symbolLabel.text = incomes[0].symbol

        let revenueValues = incomes.map { Double($0.revenue) }
        let periods = incomes.map { $0.calendarYear }
        revenueChartView.configure(with: revenueValues, periods: periods)

        let grossProfitValues = incomes.map { Double($0.operatingIncome) }
        grossProfitChartView.configure(with: grossProfitValues, periods: periods)

        let grossProfitRatioValues = incomes.map { Double($0.operatingIncomeRatio) }
        grossProfitRatioChartView.configure(with: grossProfitRatioValues, periods: periods)
    }
}

extension StockDetailView {
    private func setupScrollView() {
        addSubview(scrollView)

        scrollView.showsVerticalScrollIndicator = false

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        setupContentView()
    }

    private func setupContentView() {
        scrollView.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        setupLogoImageView()
        setupCompanyNameLabel()
        setupSymbolLabel()
        setupCurrenPriceLabel()
        setupFluctuationRateLabel()
        setupChartsVStack()
    }

    private func setupLogoImageView() {
        contentView.addSubview(logoImageView)

        logoImageView.kf.setImage(with: URL(string: "https://companiesmarketcap.com/img/company-logos/64/AAPL.png"))

        logoImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(logoImageView.snp.width)
        }
    }

    private func setupCompanyNameLabel() {
        contentView.addSubview(companyNameLabel)

        companyNameLabel.text = "애플"
        companyNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)

        companyNameLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
            $0.bottom.equalTo(logoImageView.snp.centerY).offset(-2)
        }
    }

    private func setupSymbolLabel() {
        contentView.addSubview(symbolLabel)

        symbolLabel.text = "AAPL"
        symbolLabel.font = .systemFont(ofSize: 14, weight: .medium)

        symbolLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
            $0.top.equalTo(logoImageView.snp.centerY).offset(2)
        }
    }

    private func setupCurrenPriceLabel() {
        contentView.addSubview(currentPriceLabel)

        currentPriceLabel.text = "$155.81"
        currentPriceLabel.font = .systemFont(ofSize: 45, weight: .bold)

        currentPriceLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(15)
            $0.leading.equalToSuperview()
        }
    }

    private func setupFluctuationRateLabel() {
        contentView.addSubview(fluctuationRateLabel)

        fluctuationRateLabel.text = "-1.37%"
        fluctuationRateLabel.font = .systemFont(ofSize: 25, weight: .regular)
        fluctuationRateLabel.textColor = .systemRed

        fluctuationRateLabel.snp.makeConstraints {
            $0.leading.equalTo(currentPriceLabel.snp.trailing).offset(15)
            $0.bottom.equalTo(currentPriceLabel.snp.bottom).offset(-7)
        }
    }

    private func setupChartsVStack() {
        contentView.addSubview(chartsVStack)

        chartsVStack.axis = .vertical
        chartsVStack.spacing = 50

        chartsVStack.snp.makeConstraints {
            $0.top.equalTo(fluctuationRateLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }

        [stockGraphChartView, revenueVStack, grossProfitVStack, grossProfitRatioVStack].forEach { chartsVStack.addArrangedSubview($0) }

        stockGraphChartView.snp.makeConstraints {
            $0.height.equalTo(300)
        }

        setupRevenueVStack()
        setupGrossProfitVStack()
        setupGrossProfitRatioVStack()
    }

    private func setupRevenueVStack() {
        revenueVStack.axis = .vertical
        revenueVStack.spacing = 10

        [revenueTitleLabel, revenueChartView].forEach { revenueVStack.addArrangedSubview($0) }

        revenueTitleLabel.text = "매출액"
        revenueTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        revenueChartView.snp.makeConstraints {
            $0.height.equalTo(175)
        }
    }

    private func setupGrossProfitVStack() {
        grossProfitVStack.axis = .vertical
        grossProfitVStack.spacing = 10

        [grossProfitTitleLabel, grossProfitChartView].forEach { grossProfitVStack.addArrangedSubview($0) }

        grossProfitTitleLabel.text = "영업이익"
        grossProfitTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        grossProfitChartView.snp.makeConstraints {
            $0.height.equalTo(175)
        }
    }

    private func setupGrossProfitRatioVStack() {
        grossProfitRatioVStack.axis = .vertical
        grossProfitRatioVStack.spacing = 10

        [grossProfitRatioTitleLabel, grossProfitRatioChartView].forEach { grossProfitRatioVStack.addArrangedSubview($0) }

        grossProfitRatioTitleLabel.text = "영업이익 마진율"
        grossProfitRatioTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        grossProfitRatioChartView.snp.makeConstraints {
            $0.height.equalTo(175)
        }
    }
}

struct StockDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        StockDetailViewController().toPreview()
    }
}
