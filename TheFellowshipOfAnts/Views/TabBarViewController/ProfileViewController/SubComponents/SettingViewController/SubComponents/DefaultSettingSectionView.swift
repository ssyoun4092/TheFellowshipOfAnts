import UIKit
import SnapKit

class DefaultSettingSectionView: UIView {
    //MARK: - Property
    private let settingInfos = SettingInfo.defaultSettings

    //MARK: - SubComponents
    private let dividerView = DividerView()

    private lazy var settingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SetttingTableViewCell.self, forCellReuseIdentifier: SetttingTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DefaultSettingSectionView {
    private func layout() {
        addSubviews([settingTableView, dividerView])

        settingTableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(cellHeight * CGFloat(settingInfos.count))
        }

        dividerView.snp.makeConstraints {
            $0.top.equalTo(settingTableView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(13)
            $0.bottom.equalToSuperview()
        }
    }
}

extension DefaultSettingSectionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return settingInfos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SetttingTableViewCell.identifier, for: indexPath) as? SetttingTableViewCell else { return UITableViewCell() }
        let settingInfo = settingInfos[indexPath.row]
        cell.configure(item: settingInfo.itemName, hasIndicator: settingInfo.hasIndicator)

        return cell
    }
}

extension DefaultSettingSectionView: UITableViewDelegate {
    var cellHeight: CGFloat {

        return CGFloat(27)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return cellHeight
    }
}
