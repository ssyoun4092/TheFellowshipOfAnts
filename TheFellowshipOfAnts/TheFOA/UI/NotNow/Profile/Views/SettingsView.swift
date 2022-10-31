//
//  SettingsView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/26.
//

import UIKit

import SnapKit

class SettingsView: UIView {

    // MARK: - IBOutlets

    let tableView = UITableView(
        frame: .zero,
        style: .insetGrouped
    )

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsView {
    private func setupTableView() {
        addSubview(tableView)

        tableView.register(
            SettingTableViewCell.self,
            forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.rowHeight = 45
        tableView.separatorStyle = .singleLine

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
