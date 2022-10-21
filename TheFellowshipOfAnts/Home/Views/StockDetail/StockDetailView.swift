//
//  StockDetailView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/04.
//

import UIKit

import Kingfisher
import SnapKit

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

    let stockGraphChartView = StockGraphChartView()

    let informationsVStack = UIStackView()

    let overviewVStack = UIStackView()
    let overviewTitleLabel = UILabel()
    lazy var overviewCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: overviewFlowLayout
    )
    let overviewFlowLayout: UICollectionViewLayout = {
        let cellWidth = ((UIScreen.main.bounds.width - 40) / 3)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: 50)
        layout.minimumInteritemSpacing = CGFloat(0)
        layout.minimumLineSpacing = CGFloat(10)

        return layout
    }()

    let revenueVStack = UIStackView()
    let revenueTitleLabel = UILabel()
    let revenueChartView = AbsoluteValueBarChartView()

    let operatingIncomeVStack = UIStackView()
    let operatingIncomeTitleLabel = UILabel()
    let operatingIncomeChartView = AbsoluteValueBarChartView()

    let operatingIncomeRatioVStack = UIStackView()
    let operatingIncomeRatioTitleLabel = UILabel()
    let operatingIncomeRatioChartView = PercentageValueBarChartView()

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
        operatingIncomeChartView.configure(with: grossProfitValues, periods: periods)

        let grossProfitRatioValues = incomes.map { Double($0.operatingIncomeRatio) }
        operatingIncomeRatioChartView.configure(with: grossProfitRatioValues, periods: periods)
    }

    func bind(to viewModel: StockDetailChartViewModel) {
        logoImageView.kf.setImage(with: URL(string: "https://logo.clearbit.com/\(viewModel.companyName)"))
        companyNameLabel.text = viewModel.companyName
        symbolLabel.text = viewModel.incomeStatements[0].symbol

        let periods = viewModel.incomeStatements.map { $0.calendarYear }

        let revenues = viewModel.incomeStatements.map { $0.revenue }
        revenueChartView.configure(with: revenues, periods: periods)

        let operatingIncomes = viewModel.incomeStatements.map { $0.operatingIncome }
        operatingIncomeChartView.configure(with: operatingIncomes, periods: periods)

        let operatingIncomeRatios = viewModel.incomeStatements.map { $0.operatingIncomeRatio }
        operatingIncomeRatioChartView.configure(with: operatingIncomeRatios, periods: periods)
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
        setupStockGraphChartView()
        setupInformationsVStack()
    }

    private func setupLogoImageView() {
        contentView.addSubview(logoImageView)

        logoImageView.kf.setImage(with: URL(string: "https://companiesmarketcap.com/img/company-logos/64/AAPL.png"))

        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
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
            $0.leading.equalToSuperview().inset(20)
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

    private func setupStockGraphChartView() {
        contentView.addSubview(stockGraphChartView)

        stockGraphChartView.snp.makeConstraints {
            $0.top.equalTo(fluctuationRateLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
    }

    private func setupInformationsVStack() {
        contentView.addSubview(informationsVStack)

        informationsVStack.axis = .vertical
        informationsVStack.spacing = 50

        informationsVStack.snp.makeConstraints {
            $0.top.equalTo(stockGraphChartView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }

        [overviewVStack, revenueVStack, operatingIncomeVStack, operatingIncomeRatioVStack]
            .forEach { informationsVStack.addArrangedSubview($0) }

        setupOverviewVStack()
        setupRevenueVStack()
        setupGrossProfitVStack()
        setupGrossProfitRatioVStack()
    }

    private func setupOverviewVStack() {
        overviewVStack.axis = .vertical
        overviewVStack.spacing = 10

        [overviewTitleLabel, overviewCollectionView].forEach {
            overviewVStack.addArrangedSubview($0)
        }

        overviewTitleLabel.text = "주식 요약"
        overviewTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        overviewCollectionView.register(
            StockOverviewCollectionViewCell.self,
            forCellWithReuseIdentifier: StockOverviewCollectionViewCell.identifier)

        overviewCollectionView.snp.makeConstraints {
            $0.height.equalTo(110)
        }
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
        operatingIncomeVStack.axis = .vertical
        operatingIncomeVStack.spacing = 10

        [operatingIncomeTitleLabel, operatingIncomeChartView].forEach { operatingIncomeVStack.addArrangedSubview($0) }

        operatingIncomeTitleLabel.text = "영업이익"
        operatingIncomeTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        operatingIncomeChartView.snp.makeConstraints {
            $0.height.equalTo(175)
        }
    }

    private func setupGrossProfitRatioVStack() {
        operatingIncomeRatioVStack.axis = .vertical
        operatingIncomeRatioVStack.spacing = 10

        [operatingIncomeRatioTitleLabel, operatingIncomeRatioChartView].forEach { operatingIncomeRatioVStack.addArrangedSubview($0) }

        operatingIncomeRatioTitleLabel.text = "영업이익 마진율"
        operatingIncomeRatioTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        operatingIncomeRatioChartView.snp.makeConstraints {
            $0.height.equalTo(175)
        }
    }
}
