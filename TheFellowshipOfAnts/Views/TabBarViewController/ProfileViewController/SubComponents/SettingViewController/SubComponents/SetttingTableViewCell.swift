import UIKit
import SnapKit

class SetttingTableViewCell: UITableViewCell {
    //MARK: - Property
    static let identifier = String(describing: SetttingTableViewCell.self)

    private lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.text = "고객 센터"

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

//MARK: - Layout
extension SetttingTableViewCell {
    private func layout() {
        addSubview(itemLabel)

        itemLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }

    func configure(item: String, hasIndicator: Bool) {
        itemLabel.text = item
        hasIndicator ? (accessoryType = .disclosureIndicator) : (accessoryType = .none)
    }
}
