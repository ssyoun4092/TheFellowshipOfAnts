import UIKit

import SnapKit

class RecentSearchCell: UICollectionViewCell {

    // MARK: - IBOulets

    let searchedItemLabel = UILabel()
    let deleteLabel = UILabel()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCellLayer()
        setupSearchedItemLabel()
        setupDeleteLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configure(with item: String) {
        self.searchedItemLabel.text = item
    }
}

extension RecentSearchCell {
    private func setupCellLayer() {
        backgroundColor = .lightGray

        layer.cornerRadius = 15
    }

    private func setupSearchedItemLabel() {
        contentView.addSubview(searchedItemLabel)

        searchedItemLabel.text = "에코프로비엠"
        searchedItemLabel.font = .systemFont(ofSize: 16, weight: .medium)

        searchedItemLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }

    private func setupDeleteLabel() {
        contentView.addSubview(deleteLabel)

        deleteLabel.text = "X"
        deleteLabel.font = .systemFont(ofSize: 14, weight: .regular)

        deleteLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }
}
