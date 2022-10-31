import UIKit

import SnapKit

class IndiceCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    private let indexTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "11,713.15"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let fluctuationRateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private let chartView = IndexChartView()

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCellLayer()
        setupChartView()
        setupIndexTitleLabel()
        setupCurrentPriceLabel()
        setupfluctuationRateLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with entity: Entity.StockIndice) {
        indexTitleLabel.text = entity.title
        currentPriceLabel.text = entity.prices.first?.floorIfDouble(at: 2)
        fluctuationRateLabel.text = entity.upDown.sign + calculateFluctuation(with: entity.prices.last!, entity.prices.first!) + "%"
        fluctuationRateLabel.textColor = entity.upDown.textColor

        let chartInfos: [Double] = entity.prices.map { price in Double(price)! }
        chartView.configure(with: chartInfos.reversed(), upDown: entity.upDown)
    }
}

extension IndiceCollectionViewCell {
    var leading: CGFloat { return 15 }
    var trailing: CGFloat { return 15 }

    private func setupCellLayer() {
        backgroundColor = .white
        contentView.layer.cornerRadius = 15.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.cornerRadius = 15.0
        layer.masksToBounds = false
        layer.shadowOpacity = 0.3
    }

    private func setupIndexTitleLabel() {
        contentView.addSubview(indexTitleLabel)

        indexTitleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(leading)
        }
    }

    private func setupCurrentPriceLabel() {
        contentView.addSubview(currentPriceLabel)

        currentPriceLabel.snp.makeConstraints {
            $0.top.equalTo(indexTitleLabel.snp.bottom).offset(3)
            $0.leading.equalToSuperview().inset(leading)
        }
    }

    private func setupfluctuationRateLabel() {
        contentView.addSubview(fluctuationRateLabel)

        fluctuationRateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(leading)
            $0.trailing.equalToSuperview().inset(trailing)
        }
    }

    private func setupChartView() {
        contentView.addSubview(chartView)

        chartView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
    }

    private func calculateFluctuation(with prev: String, _ current: String) -> String {
        let prevValue = Double(prev)!
        let currentValue = Double(current)!
        let absValue = abs(currentValue - prevValue)

        return ((absValue / prevValue) * 100).toStringWithFloor(at: 2)
    }
}
