import UIKit
import SnapKit

class IndexCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOulets

    let indexTitleLabel = UILabel()
    let currentPriceLabel = UILabel()
    let DTDLabel = UILabel()
    let fluctuationRateLabel = UILabel()
    let chartView = IndexChartView()

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCellLayer()
        setupChartView()
        setupIndexTitleLabel()
        setupCurrentPriceLabel()
        setupDTDLabel()
        setupfluctuationRateLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with indexModel: StockIndex, upDown: UpDown) {
        // TODO: - currentPrice 전날과 비교 로직 추가
        indexTitleLabel.text = indexModel.basic.title
        currentPriceLabel.text = indexModel.values[0].close.floorIfDouble(at: 2)
        currentPriceLabel.textColor = upDown.textColor
        DTDLabel.text = calculateDayToDayPrice(with: indexModel.values.first!.close, indexModel.values.last!.close)
        DTDLabel.textColor = upDown.textColor
        fluctuationRateLabel.text = calculateFluctuation(with: indexModel.values.first!.close, indexModel.values.last!.close) + "%"
        fluctuationRateLabel.textColor = upDown.textColor

        let chartInfos: [Double] = indexModel.values.map { value in
            Double(value.close)!
        }
        chartView.configure(with: chartInfos.reversed(), upDown: upDown)
    }
}

extension IndexCollectionViewCell {
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

        indexTitleLabel.text = "나스닥"
        indexTitleLabel.textColor = .black
        indexTitleLabel.textAlignment = .left
        indexTitleLabel.font = .systemFont(ofSize: 20, weight: .semibold)

        indexTitleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(leading)
        }
    }

    private func setupCurrentPriceLabel() {
        contentView.addSubview(currentPriceLabel)

        currentPriceLabel.text = "11,713.15"
        currentPriceLabel.textColor = .systemRed
        currentPriceLabel.font = .systemFont(ofSize: 25, weight: .bold)
        currentPriceLabel.adjustsFontSizeToFitWidth = true

        currentPriceLabel.snp.makeConstraints {
            $0.top.equalTo(indexTitleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(leading)
            $0.trailing.equalTo(chartView.snp.leading).offset(15)
        }
    }

    private func setupDTDLabel() {
        contentView.addSubview(DTDLabel)

        DTDLabel.text = "+10.88"
        DTDLabel.font = .systemFont(ofSize: 15, weight: .medium)

        DTDLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(leading)
            $0.top.equalTo(currentPriceLabel.snp.bottom).offset(6)
        }
    }

    private func setupfluctuationRateLabel() {
        contentView.addSubview(fluctuationRateLabel)

        fluctuationRateLabel.text = "(1.3%)"
        fluctuationRateLabel.textAlignment = .left
        fluctuationRateLabel.font = .systemFont(ofSize: 15, weight: .medium)
        fluctuationRateLabel.adjustsFontSizeToFitWidth = true

        fluctuationRateLabel.snp.makeConstraints {
            $0.leading.equalTo(DTDLabel.snp.trailing).offset(5)
            $0.bottom.equalTo(DTDLabel.snp.bottom)
        }
    }

    private func setupChartView() {
        contentView.addSubview(chartView)

        chartView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.bottom.equalToSuperview().inset(trailing)
            $0.width.equalToSuperview().multipliedBy(0.4)
        }
    }

    private func calculateDayToDayPrice(with prev: String, _ current: String) -> String {
        let value = Double(prev)! - Double(current)!

        return value.toStringWithFloor(at: 2)
    }

    private func calculateFluctuation(with prev: String, _ current: String) -> String {
        let prevValue = Double(prev)!
        let currentValue = Double(current)!

        return (((currentValue - prevValue) / prevValue) * 100).toStringWithFloor(at: 2)
    }
}
