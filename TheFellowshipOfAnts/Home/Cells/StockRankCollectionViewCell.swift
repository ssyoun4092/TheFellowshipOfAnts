import UIKit

import Kingfisher
import SnapKit

class StockRankCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    let rankLabel = UILabel()
    let logoImageView = UIImageView()
    let companyNameLabel = UILabel()
    let symbolLabel = UILabel()
    let currentPriceLabel = UILabel()
    let fluctuationRateLabel = UILabel()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupContentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

//    func configure(with model: StockRank) {
//        rankLabel.text = model.rank
//        logoImageView.kf.setImage(with: URL(string: model.logoURL))
//        companyNameLabel.text = model.companyName
//        symbolLabel.text = model.symbol
//        currentPriceLabel.text = model.price
//        fluctuationRateLabel.text = model.upDown.sign + model.fluctuationRate
//        fluctuationRateLabel.textColor = model.upDown.textColor
//    }

    func configure(with entity: Entity.RankStock) {
        rankLabel.text = entity.rank
        print("logoURLString: ", entity.logoURLString)
        logoImageView.kf.setImage(with: URL(string: entity.logoURLString))
        companyNameLabel.text = entity.companyName
        symbolLabel.text = entity.symbol
        currentPriceLabel.text = entity.price
        fluctuationRateLabel.text = entity.fluctuationRate
        fluctuationRateLabel.textColor = .red
    }
}

extension StockRankCollectionViewCell {
    private func setupContentView() {
        setupRankLabel()
        setupLogoImage()
        setupCompanyNameLabel()
        setupSymbolLabel()
        setupCurrentPriceLabel()
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
        contentView.addSubview(logoImageView)

        logoImageView.image = UIImage(named: "AppleLoginLogo")
        logoImageView.backgroundColor = .white
        logoImageView.layer.cornerRadius = 25
        logoImageView.clipsToBounds = true

        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(40)
            $0.height.equalToSuperview()
            $0.width.equalTo(logoImageView.snp.height)
            $0.centerY.equalToSuperview()
        }
    }

    private func setupCompanyNameLabel() {
        contentView.addSubview(companyNameLabel)

        companyNameLabel.text = "애플"
        companyNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)

        companyNameLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
            $0.bottom.equalToSuperview { $0.snp.centerY }.offset(-2)
        }
    }

    private func setupSymbolLabel() {
        contentView.addSubview(symbolLabel)

        symbolLabel.text = "AAPL"
        symbolLabel.font = .systemFont(ofSize: 14, weight: .medium)
        symbolLabel.textColor = .lightGray

        symbolLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
            $0.top.equalToSuperview { $0.snp.centerY }.offset(2)
        }
    }

    private func setupCurrentPriceLabel() {
        contentView.addSubview(currentPriceLabel)

        currentPriceLabel.text = "$158.91"
        currentPriceLabel.font = .systemFont(ofSize: 15, weight: .medium)

        currentPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(symbolLabel.snp.trailing).offset(5)
            $0.bottom.equalTo(symbolLabel.snp.bottom)
        }
    }

    private func setupFluctuationRateLabel() {
        contentView.addSubview(fluctuationRateLabel)

        fluctuationRateLabel.text = "+1.3%"
        fluctuationRateLabel.font = .systemFont(ofSize: 15, weight: .medium)

        fluctuationRateLabel.snp.makeConstraints {
            $0.leading.equalTo(currentPriceLabel.snp.trailing).offset(5)
            $0.bottom.equalTo(currentPriceLabel.snp.bottom)
        }
    }
}
