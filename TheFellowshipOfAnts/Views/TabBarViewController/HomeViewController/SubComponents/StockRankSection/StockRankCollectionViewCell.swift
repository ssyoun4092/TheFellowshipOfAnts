import UIKit
import SnapKit

class StockRankCollectionViewCell: UICollectionViewCell {
    private lazy var rankNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "17"
        return label
    }()

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.backgroundColor = .systemCyan
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    func setupUI() {
        [rankNumberLabel].forEach { contentView.addSubview($0) }

        rankNumberLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }
    }
}
