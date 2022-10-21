import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    //MARK: - SubComponents
    let profileSectionView = ProfileView()

    weak var coordinator: ProfileCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutNavigationBar()
        layout()
    }
}

extension ProfileViewController {
    private func layoutNavigationBar() {
        let settingIcon = UIImage(systemName: "gearshape")?.withTintColor(.black, renderingMode: .alwaysOriginal)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: settingIcon, style: .plain, target: self, action: #selector(tappedSettings))
    }

    private func layout() {
        view.addSubview(profileSectionView)

        profileSectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ProfileViewController {
    @objc func tappedSettings() {
        let settingVC = SettingsViewController(nibName: nil, bundle: nil)
        settingVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(settingVC, animated: true)
    }
}
