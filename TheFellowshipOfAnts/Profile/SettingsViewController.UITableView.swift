//
//  SettingsViewController.UITableView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/26.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

extension SettingsViewController: UITableViewDataSource {
    var settingsSection: [SettingsSection] { return SettingsSection.model }

    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsSection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsSection[section].settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingTableViewCell.identifier,
            for: indexPath
        ) as? SettingTableViewCell else { return UITableViewCell() }

        let setting = settingsSection[indexPath.section].settings[indexPath.row]

        cell.configure(with: setting.itemName, setting.hasIndicator)

        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(
            frame: .init(x: 0,
                         y: 0,
                         width: tableView.frame.size.width,
                         height: 24
                        )
        )
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = settingsSection[section].header

        return label
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(60)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath: \(indexPath)")
        if indexPath == IndexPath(row: 1, section: 1) {
//            UserApi.shared.logout { error in
//                if let error = error {
//                    print("error: \(error.localizedDescription)")
//                } else {
//                    print("Logout Success")
//                }
//            }
            UserApi.shared.unlink { error in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                } else {
                    print("Unlink Success")
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
}
