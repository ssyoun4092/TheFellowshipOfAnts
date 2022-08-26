import UIKit
import SnapKit

class SettingsViewController: UIViewController {

    // MARK: - IBOulets

    let settingsView = SettingsView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        settingsView.tableView.dataSource = self
        settingsView.tableView.delegate = self

        setupNavigationBar()
        setupViews()
    }
}

extension SettingsViewController {
    private func setupNavigationBar() {
        title = "설정"
    }

    private func setupViews() {
        view.addSubview(settingsView)

        settingsView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
