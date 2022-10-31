import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    //MARK: - Property
    static let identifier = String(describing: SettingTableViewCell.self)

    private lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample"

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
extension SettingTableViewCell {
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
