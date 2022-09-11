import UIKit

import SnapKit

class SettingTableViewCell: UITableViewCell {

    //MARK: - IBOulets

    let itemLabel = UILabel()

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupItemLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingTableViewCell {
    private func setupItemLabel() {
        contentView.addSubview(itemLabel)

        itemLabel.text = "Sample"

        itemLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }

    func configure(with item: String, _ hasIndicator: Bool) {
        itemLabel.text = item
        accessoryType = hasIndicator ? .disclosureIndicator : .none
    }
}
