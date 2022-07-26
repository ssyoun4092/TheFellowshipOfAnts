import UIKit
import SnapKit

class MajorCommodityCollectionViewCell: UICollectionViewCell {
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "원유"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black.withAlphaComponent(0.5)

        return label
    }()

    private lazy var commodityName: UILabel = {
        let label = UILabel()
        label.text = "WTI"
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.01

        return label
    }()

    private lazy var fluctuationRateLabel: UILabel = {
        let label = UILabel()
        label.text = "+1.34%"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.setLetterSpacing(by: -0.5)

        return label
    }()

    private lazy var currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$395.05"
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.01

        return label
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
        self.backgroundColor = .white
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false

        [descriptionLabel, commodityName, fluctuationRateLabel, currentPriceLabel]
            .forEach { contentView.addSubview($0)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
        }

        commodityName.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.leading.equalTo(descriptionLabel.snp.leading)
            $0.width.equalToSuperview { $0.snp.width }.multipliedBy(0.2)
            $0.height.equalTo(20)
        }

        currentPriceLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(15)
            $0.width.equalToSuperview { $0.snp.width }.multipliedBy(0.5)
            $0.height.equalTo(25)
        }

        fluctuationRateLabel.snp.makeConstraints {
            $0.bottom.equalTo(currentPriceLabel.snp.top)
            $0.trailing.equalTo(currentPriceLabel)
        }
    }
}
