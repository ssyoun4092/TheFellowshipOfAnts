import UIKit
import SnapKit

class RecentSearchCell: UICollectionViewCell {
    static let identifer = String(describing: RecentSearchCell.self)

    private lazy var searchedItemLabel: UILabel = {
        let label = UILabel()
        label.text = "에코프로비엠"
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
    }()

    private lazy var deleteLabel: UILabel = {
        let label = UILabel()
        label.text = "X"
        label.font = .systemFont(ofSize: 14, weight: .regular)

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecentSearchCell {
    private func layout() {
        self.layer.cornerRadius = 15

        addSubviews([searchedItemLabel, deleteLabel])

        searchedItemLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }

        deleteLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }

    func configure(item: String) {
        self.searchedItemLabel.text = item
    }
}
