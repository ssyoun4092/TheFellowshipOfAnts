import UIKit
import SnapKit

class MajorCarouselCell: UICollectionViewCell {

    // MARK: - IBOulets

    let descriptionLabel = UILabel()
    let mainLabel = UILabel()
    let fluctuationRateLabel = UILabel()
    let currentPriceLabel = UILabel()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCellLayer()
        setupDescriptionLabel()
        setupMainLabel()
        setupCurrentPriceLabel()
        setupFluctuationRateLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        descriptionLabel.text = nil
        mainLabel.text = nil
        fluctuationRateLabel.text = nil
        currentPriceLabel.text = nil
    }

    // MARK: - Methods

    func configure(description: String) {
        self.descriptionLabel.text = description
    }
}

extension MajorCarouselCell {
    private func setupCellLayer() {
        backgroundColor = .white

        contentView.layer.cornerRadius = 15.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = true

        layer.cornerRadius = 15.0
        layer.masksToBounds = false
    }

    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)

        descriptionLabel.text = "원유"
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        descriptionLabel.textColor = .black.withAlphaComponent(0.5)

        descriptionLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
        }
    }

    private func setupMainLabel() {
        contentView.addSubview(mainLabel)

        mainLabel.text = "WTI"
        mainLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        mainLabel.textAlignment = .right
        mainLabel.adjustsFontSizeToFitWidth = true
        mainLabel.minimumScaleFactor = 0.01

        mainLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.leading.equalTo(descriptionLabel.snp.leading)
            $0.width.equalToSuperview { $0.snp.width }.multipliedBy(0.2)
            $0.height.equalTo(20)
        }
    }

    private func setupCurrentPriceLabel() {
        contentView.addSubview(currentPriceLabel)

        currentPriceLabel.text = "+1.34%"
        currentPriceLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)

        currentPriceLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(15)
            $0.width.equalToSuperview { $0.snp.width }.multipliedBy(0.5)
            $0.height.equalTo(25)
        }
    }

    private func setupFluctuationRateLabel() {
        contentView.addSubview(fluctuationRateLabel)

        fluctuationRateLabel.text = "+1.34%"
        fluctuationRateLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)

        fluctuationRateLabel.snp.makeConstraints {
            $0.bottom.equalTo(currentPriceLabel.snp.top)
            $0.trailing.equalTo(currentPriceLabel)
        }
    }
}