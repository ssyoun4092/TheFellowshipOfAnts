//
//  StockDetailView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/04.
//

import UIKit

import Lottie
import Kingfisher
import SnapKit

class StockDetailView: UIView {

    // MARK: - Properties


    // MARK: - IBOutlets

    let scrollView = UIScrollView()
    let contentView = UIView()

    let lottieHeartView: LottieAnimationView = {
        let view = LottieAnimationView(name: "Lottie-like")
        view.contentMode = .scaleAspectFit
        view.loopMode = .playOnce
        return view
    }()

    let logoImageView = UIImageView()
    let companyNameLabel = UILabel()
    let symbolLabel = UILabel()
    let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleToFill
        return button
    }()

    let currentPriceLabel = UILabel()
    let fluctuationRateLabel = UILabel()

    let stockGraphChartView = StockGraphChartView()
    let stockGraphChartCoverView = UIView()

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

    func bind(to viewModel: StockDetailChartViewModel) {
        logoImageView.kf.setImage(with: URL(string: "https://logo.clearbit.com/\(viewModel.companyName).com"))
        companyNameLabel.text = viewModel.companyName
        symbolLabel.text = viewModel.incomeStatements.first?.symbol ?? ""
        currentPriceLabel.text = "$" + String(viewModel.prices.last ?? 0).floorIfDouble(at: 2)
        fluctuationRateLabel.text = viewModel.upDown.sign + calculateFluctuation(with: viewModel.prices.first, viewModel.prices.last) + "%"
        fluctuationRateLabel.textColor = viewModel.upDown.textColor
        stockGraphChartView.configure(with: viewModel.prices, upDown: viewModel.upDown)
        animateStockGraphChart()

        let periods = viewModel.incomeStatements.map { $0.calendarYear }

        let revenues = viewModel.incomeStatements.map { $0.revenue }
        revenueChartView.configure(with: revenues, periods: periods)

        let operatingIncomes = viewModel.incomeStatements.map { $0.operatingIncome }
        operatingIncomeChartView.configure(with: operatingIncomes, periods: periods)

        let operatingIncomeRatios = viewModel.incomeStatements.map { $0.operatingIncomeRatio }
        operatingIncomeRatioChartView.configure(with: operatingIncomeRatios, periods: periods)
    }

    func setHeartButtonImage(isLiked: Bool) {
        if isLiked {
            heartButton.setImage(UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
//            animateLottieHeartView()
        } else {
            heartButton.setImage(UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }

    private func animateLottieHeartView() {
        // TODO: - 수정 필요
        guard let window = UIApplication.shared.keyWindow else { return }
        contentView.addSubview(lottieHeartView)
        lottieHeartView.center = CGPoint(x: window.bounds.size.width / 2, y: window.bounds.size.height / 2)
        lottieHeartView.frame.size = CGSize(width: 300, height: 300)
        lottieHeartView.isHidden = false
        lottieHeartView.play { didComplete in
            if didComplete {
                self.lottieHeartView.isHidden = true
                self.lottieHeartView.removeFromSuperview()
            }
        }
    }

    private func animateStockGraphChart() {
        superview?.layoutIfNeeded()
        stockGraphChartCoverView.snp.updateConstraints {
            $0.width.equalTo(0)
        }

        UIView.animate(withDuration: 1.5) {
            self.superview?.layoutIfNeeded()
        } completion: { didComplete in
            if didComplete { self.stockGraphChartCoverView.isHidden = true }
        }
    }

    private func calculateFluctuation(with prev: Double?, _ current: Double?) -> String {
        guard let prev = prev,
              let current = current else { return "" }
        let absFluctuationValue = abs((((prev - current) / prev) * 100))

        return absFluctuationValue.toStringWithFloor(at: 2)
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
        setupHeartAnimationView()
        setupCurrenPriceLabel()
        setupFluctuationRateLabel()
        setupStockGraphChartView()
        setupStockGraphChartCoverView()
        setupInformationsVStack()
//        setupLottieHeartView()
    }

    private func setupLogoImageView() {
        contentView.addSubview(logoImageView)

        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(40)
            $0.height.equalTo(logoImageView.snp.width)
        }
    }

    private func setupCompanyNameLabel() {
        contentView.addSubview(companyNameLabel)

        companyNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)

        companyNameLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
            $0.bottom.equalTo(logoImageView.snp.centerY).offset(-2)
        }
    }

    private func setupSymbolLabel() {
        contentView.addSubview(symbolLabel)

        symbolLabel.font = .systemFont(ofSize: 14, weight: .medium)

        symbolLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
            $0.top.equalTo(logoImageView.snp.centerY).offset(2)
        }
    }

    private func setupHeartAnimationView() {
        contentView.addSubview(heartButton)

        heartButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(40)
            $0.bottom.equalTo(logoImageView.snp.bottom)
        }
    }

    private func setupCurrenPriceLabel() {
        contentView.addSubview(currentPriceLabel)

        currentPriceLabel.font = .systemFont(ofSize: 45, weight: .bold)

        currentPriceLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(20)
        }
    }

    private func setupFluctuationRateLabel() {
        contentView.addSubview(fluctuationRateLabel)

        fluctuationRateLabel.font = .systemFont(ofSize: 25, weight: .regular)

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

    private func setupStockGraphChartCoverView() {
        stockGraphChartView.addSubview(stockGraphChartCoverView)

        stockGraphChartCoverView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        stockGraphChartCoverView.backgroundColor = .white
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

    private func setupLottieHeartView() {
        contentView.addSubview(lottieHeartView)

        lottieHeartView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(contentView).multipliedBy(0.333)
            $0.height.equalTo(lottieHeartView.snp.width)
        }
    }
}
