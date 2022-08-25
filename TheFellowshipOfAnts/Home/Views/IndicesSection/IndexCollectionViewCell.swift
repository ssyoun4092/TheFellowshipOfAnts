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
        setupIndexTitleLabel()
        setupCurrentPriceLabel()
        setupDTDLabel()
        setupfluctuationRateLabel()
        setupChartView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        currentPriceLabel.font = .systemFont(ofSize: 30, weight: .bold)

        currentPriceLabel.snp.makeConstraints {
            $0.top.equalTo(indexTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(leading)
        }
    }

    private func setupDTDLabel() {
        contentView.addSubview(DTDLabel)

        DTDLabel.text = "+10.88"
        DTDLabel.textColor = .systemRed
        DTDLabel.font = .systemFont(ofSize: 17, weight: .medium)

        DTDLabel.snp.makeConstraints {
            $0.leading.equalTo(currentPriceLabel.snp.trailing).offset(10)
            $0.bottom.equalTo(currentPriceLabel.snp.bottom)
        }
    }

    private func setupfluctuationRateLabel() {
        contentView.addSubview(fluctuationRateLabel)

        fluctuationRateLabel.text = "(1.3%)"
        fluctuationRateLabel.textColor = .systemRed
        fluctuationRateLabel.font = .systemFont(ofSize: 17, weight: .medium)

        fluctuationRateLabel.snp.makeConstraints {
            $0.leading.equalTo(DTDLabel.snp.trailing).offset(5)
            $0.bottom.equalTo(currentPriceLabel.snp.bottom)
        }
    }

    private func setupChartView() {
        contentView.addSubview(chartView)

        chartView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.bottom.equalToSuperview().inset(trailing)
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
    }
}
