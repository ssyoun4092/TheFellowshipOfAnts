import UIKit
import SnapKit

class IndexCollectionViewCell: UICollectionViewCell {
    private lazy var indexName: UILabel = {
        let label = UILabel()
        label.text = "나스닥"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private lazy var currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "11,713.15"
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()

    // 전일 대비
    private lazy var DTDLabel: UILabel = {
        let label = UILabel()
        label.text = "+10.88"
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()

    // 등락률
    private lazy var fluctuationRateLabel: UILabel = {
        let label = UILabel()
        label.text = "(1.3%)"
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()

    private lazy var chartView: IndexChartView = {
        let chartView = IndexChartView()
        return chartView
    }()

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    func setupUI() {
        [indexName, currentPriceLabel, DTDLabel, fluctuationRateLabel, chartView]
            .forEach { contentView.addSubview($0) }

        indexName.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(15)
        }

        currentPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(indexName.snp.leading)
            $0.top.equalTo(indexName.snp.bottom).offset(10)
        }

        DTDLabel.snp.makeConstraints {
            $0.leading.equalTo(currentPriceLabel.snp.trailing).offset(10)
            $0.bottom.equalTo(currentPriceLabel.snp.bottom)
        }

        fluctuationRateLabel.snp.makeConstraints {
            $0.leading.equalTo(DTDLabel.snp.trailing).offset(5)
            $0.bottom.equalTo(currentPriceLabel.snp.bottom)
        }

        chartView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.bottom.equalToSuperview().inset(15)
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
    }
}
