import UIKit
import SnapKit

class MajorETFCollectionViewCell: UICollectionViewCell {
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "원유"

        return label
    }()

    private lazy var ETFName: UILabel = {
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = nil
        ETFName.text = nil
        fluctuationRateLabel.text = nil
        currentPriceLabel.text = nil
    }

    func configure(description: String) {
        self.descriptionLabel.text = description
    }

    private func setupUI() {
        [descriptionLabel, ETFName, fluctuationRateLabel, currentPriceLabel]
            .forEach { contentView.addSubview($0)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
        }

        ETFName.snp.makeConstraints {
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
    }
}
