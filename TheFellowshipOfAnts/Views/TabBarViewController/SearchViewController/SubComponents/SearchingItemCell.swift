import UIKit
import SnapKit

class SearchingItemCell: UITableViewCell {
    static let identifer = String(describing: SearchingItemCell.self)

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AppleLoginLogo"))
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true

        return imageView
    }()

    private lazy var companyName: UILabel = {
        let label = UILabel()
        label.text = "애플"

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchingItemCell {
    private func layout() {
        contentView.addSubviews([logoImageView, companyName])

        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(logoImageView.snp.height)
            $0.centerY.equalToSuperview()
        }

        companyName.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
}
