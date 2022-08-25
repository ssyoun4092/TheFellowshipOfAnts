import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    //MARK: - SubComponents
    private let scrollView = UIScrollView()
    private let defaultSettingSectionView = DefaultSettingSectionView()
    private let userManageSettingSectionView = UserManagerSectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layoutNavigationBar()
        layout()
    }
}

//MARK: - Layout
extension SettingsViewController {
    private func layoutNavigationBar() {
        title = "설정"
    }

    private func layout() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        layoutScrollView()
    }

    private func layoutScrollView() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        scrollView.addSubviews([defaultSettingSectionView, userManageSettingSectionView])

        defaultSettingSectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
        }

        userManageSettingSectionView.snp.makeConstraints {
            $0.top.equalTo(defaultSettingSectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}
