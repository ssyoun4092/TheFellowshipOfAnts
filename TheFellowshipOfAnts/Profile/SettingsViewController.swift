import UIKit

import SnapKit

class SettingsViewController: UIViewController {

    // MARK: - Properties

    weak var coordinator: ProfileCoordinator?

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

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        coordinator?.didFinishProfile()
    }

    deinit {
        print("SettingsVC Deinit")
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
