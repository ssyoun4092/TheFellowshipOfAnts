import UIKit
import SnapKit

class MarketIndexCollectionViewCell: UICollectionViewCell {
    
    struct MarketIndexInfoModel: MarketInfoModel {
        let indexName: String
        let currentPrice: String
        let priceUpDown: String
        let chartViewModel: IndexChartInfo
    }

    let indexNameLabel: UILabel = {
        let label = UILabel()
        label.text = "나스닥"
        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "11000"
        label.backgroundColor = .red
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    let priceUpDownLabel: UILabel = {
        let label = UILabel()
        label.text = "1.57%"
        label.backgroundColor = .brown
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    private let miniIndexChartView: IndexChartView = {
        let chartView = IndexChartView()
        return chartView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        indexNameLabel.text = nil
        currentPriceLabel.text = nil
        priceUpDownLabel.text = nil
        miniIndexChartView.reset()
    }

    private func setupUI() {
        contentView.backgroundColor = .lightGray
        [indexNameLabel, currentPriceLabel, priceUpDownLabel, miniIndexChartView].forEach { contentView.addSubview($0) }
        configMarketIndexLabel()
        configCurrentPriceLabel()
        configPriceUpDownLabel()
        configMiniIndexChartView()
    }

    private func configMarketIndexLabel() {
        indexNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalToSuperview().inset(15)
        }
    }

    private func configCurrentPriceLabel() {
        currentPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(indexNameLabel)
            $0.top.equalTo(indexNameLabel.snp.bottom).offset(10)
        }
    }

    private func configPriceUpDownLabel() {
        priceUpDownLabel.snp.makeConstraints {
            $0.leading.equalTo(currentPriceLabel.snp.trailing).offset(15)
            $0.centerY.equalTo(currentPriceLabel)
        }
    }

    private func configMiniIndexChartView() {
        miniIndexChartView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(indexNameLabel.snp.top)
            $0.bottom.equalToSuperview().inset(15)
            $0.width.equalTo(100)
        }
    }

    func configure(with viewModel: MarketIndexInfoModel) {
        self.indexNameLabel.text = viewModel.indexName
        self.currentPriceLabel.text = viewModel.currentPrice
        self.priceUpDownLabel.text = viewModel.priceUpDown
        self.miniIndexChartView.configure(with: viewModel.chartViewModel)
    }
}
