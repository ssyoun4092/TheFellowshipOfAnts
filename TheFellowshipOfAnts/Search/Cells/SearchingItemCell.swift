import UIKit

import SnapKit

class SearchingItemCell: UITableViewCell {

    // MARK: - IBOutlets

    let logoImageView = UIImageView()
    let companyNameLabel = UILabel()

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLogoImageView()
        setupCompanyNameLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchingItemCell {
    private func setupLogoImageView() {
        contentView.addSubview(logoImageView)

        logoImageView.backgroundColor = .black
        logoImageView.layer.cornerRadius = 20
        logoImageView.clipsToBounds = true

        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(logoImageView.snp.height)
            $0.centerY.equalToSuperview()
        }
    }

    private func setupCompanyNameLabel() {
        contentView.addSubview(companyNameLabel)

        companyNameLabel.text = "애플"

        companyNameLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
}
