import UIKit
import SnapKit

class StockRankCollectionViewCell: UICollectionViewCell {
    private lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.text = "17"

        return label
    }()

    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AppleLoginLogo"))
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true

        return imageView
    }()

    private lazy var stockName: UILabel = {
        let label = UILabel()
        label.text = "애플"

        return label
    }()

    private lazy var stockPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$153.04"

        return label
    }()

    private lazy var fluctuationRateLabel: UILabel = {
        let label = UILabel()
        label.text = "+1.35%"
        label.textColor = .systemRed

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(rank: String) {
        self.rankLabel.text = rank
    }

    private func setupUI() {
        [rankLabel, logoImage, stockName, stockPriceLabel, fluctuationRateLabel]
            .forEach { contentView.addSubview($0) }

        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }

        logoImage.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.leading).offset(30)
            $0.height.equalToSuperview()
            $0.width.equalTo(logoImage.snp.height)
            $0.centerY.equalToSuperview()
        }

        stockName.snp.makeConstraints {
            $0.leading.equalTo(logoImage.snp.trailing).offset(10)
            $0.bottom.equalToSuperview { $0.snp.centerY }.offset(-2)
        }

        stockPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImage.snp.trailing).offset(10)
            $0.top.equalToSuperview { $0.snp.centerY }.offset(2)
        }

        fluctuationRateLabel.snp.makeConstraints {
            $0.leading.equalTo(stockPriceLabel.snp.trailing).offset(5)
            $0.bottom.equalTo(stockPriceLabel.snp.bottom)
        }

    }
}
