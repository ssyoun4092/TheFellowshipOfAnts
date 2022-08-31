import UIKit
import SnapKit

class StockRankCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOulets

    let rankLabel = UILabel()
    let logoImage = UIImageView()
    let stockNameLabel = UILabel()
    let ticker = UILabel()
    let currentPrice = UILabel()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupContentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configure(with model: StockRank) {
        rankLabel.text = model.rank
        stockNameLabel.text = model.companyName
        ticker.text = model.ticker
        currentPrice.text = model.price
    }
}

extension StockRankCollectionViewCell {
    private func setupContentView() {
        setupRankLabel()
        setupLogoImage()
        setupStockNameLabel()
        setupStockPriceLabel()
        setupFluctuationRateLabel()
    }

    private func setupRankLabel() {
        contentView.addSubview(rankLabel)

        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }

    private func setupLogoImage() {
        contentView.addSubview(logoImage)

        logoImage.image = UIImage(named: "AppleLoginLogo")
        logoImage.backgroundColor = .black
        logoImage.layer.cornerRadius = 25
        logoImage.clipsToBounds = true

        logoImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(40)
            $0.height.equalToSuperview()
            $0.width.equalTo(logoImage.snp.height)
            $0.centerY.equalToSuperview()
        }
    }

    private func setupStockNameLabel() {
        contentView.addSubview(stockNameLabel)

        stockNameLabel.text = "애플"
        stockNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)

        stockNameLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImage.snp.trailing).offset(10)
            $0.bottom.equalToSuperview { $0.snp.centerY }.offset(-2)
        }
    }

    private func setupStockPriceLabel() {
        contentView.addSubview(ticker)

        ticker.text = "AAPL"
        ticker.font = .systemFont(ofSize: 14, weight: .medium)
        ticker.textColor = .lightGray

        ticker.snp.makeConstraints {
            $0.leading.equalTo(logoImage.snp.trailing).offset(10)
            $0.top.equalToSuperview { $0.snp.centerY }.offset(2)
        }
    }

    private func setupFluctuationRateLabel() {
        contentView.addSubview(currentPrice)

        currentPrice.text = "$158.91"
        currentPrice.font = .systemFont(ofSize: 15, weight: .medium)

        currentPrice.snp.makeConstraints {
            $0.leading.equalTo(ticker.snp.trailing).offset(5)
            $0.bottom.equalTo(ticker.snp.bottom)
        }
    }
}
