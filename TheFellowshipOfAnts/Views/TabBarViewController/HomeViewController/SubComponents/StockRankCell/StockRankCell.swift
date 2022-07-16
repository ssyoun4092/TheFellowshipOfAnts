import UIKit

class StockRankCell: UICollectionViewCell {
    private lazy var rankNumber: UILabel = {
        let label = UILabel()
        label.text = "18"
        label.backgroundColor = .green
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()

    private lazy var companyLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AppleLoginLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()

    private lazy var companyName: UILabel = {
        let label = UILabel()
        label.text = "APPLE"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private lazy var currentPrice: UILabel = {
        let label = UILabel()
        label.text = "146.04"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    private lazy var fluctuationRate: UILabel = {
        let label = UILabel()
        label.text = "1.64%"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    private lazy var bottomLabelHorizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currentPrice, fluctuationRate])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()

    private lazy var labelVerticalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [companyName, bottomLabelHorizontalStack])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 7
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        [rankNumber, companyLogo, labelVerticalStack].forEach { contentView.addSubview($0) }
        setupRankNumberUI()
        setupCompanyLogoUI()
        setupLabelVerticalStack()
    }

    private func setupRankNumberUI() {
        rankNumber.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(30)
            $0.centerY.equalToSuperview()
        }
    }

    private func setupCompanyLogoUI() {
        let width = contentView.bounds.height * 0.8
        companyLogo.snp.makeConstraints {
            $0.leading.equalTo(rankNumber.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(width)
        }
    }

    private func setupLabelVerticalStack() {
        labelVerticalStack.snp.makeConstraints {
            $0.leading.equalTo(companyLogo.snp.trailing).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}
