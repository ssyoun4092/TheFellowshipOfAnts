import UIKit
import SnapKit

class MajorCommodityCollectionViewCell: UICollectionViewCell {
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "원유"

        return label
    }()

    private lazy var commodityName: UILabel = {
        let label = UILabel()
        label.text = "WTI"

        return label
    }()

    private lazy var fluctuationRateLabel: UILabel = {
        let label = UILabel()
        label.text = "+1.34%"

        return label
    }()

    private lazy var currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$97.59"

        return label
    }()

    private lazy var tempLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue

        return view
    }()

    private lazy var tempRedLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(description: String) {
        self.descriptionLabel.text = description
    }

    private func setupUI() {
        [descriptionLabel, commodityName, fluctuationRateLabel, currentPriceLabel, tempLine, tempRedLine]
            .forEach { contentView.addSubview($0)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
        }

        commodityName.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            $0.leading.equalTo(descriptionLabel.snp.leading)
        }

        currentPriceLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(15)
        }

        fluctuationRateLabel.snp.makeConstraints {
            $0.bottom.equalTo(currentPriceLabel.snp.top).offset(5)
            $0.trailing.equalTo(currentPriceLabel)
        }

        tempLine.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(3)
        }

        tempRedLine.snp.makeConstraints {
            $0.leading.equalToSuperview().inset((29.1))
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(1)
        }
    }
}
