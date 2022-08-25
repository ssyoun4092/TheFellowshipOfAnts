import UIKit
import SwiftUI
import SnapKit
import RxSwift
import RxCocoa

class EmailLoginViewController: UIViewController {

    // MARK: - Properties

    var disposeBag = DisposeBag()
    let viewModel = EmailLoginViewModel()

    // MARK: - IBOulet

    let emailLoginView = EmailLoginView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }

    // MARK: - Methods

    func bind() {
        emailLoginView.emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailInput)
            .disposed(by: disposeBag)

        viewModel.emailValid
            .subscribe(onNext: { [weak self] valid in
                //                if valid {
                //                    borderColor = UIColor.systemGreen.cgColor
                //                } else {
                //                    borderColor = UIColor.black.cgColor
                //                }
            })
            .disposed(by: disposeBag)
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(emailLoginView)

        emailLoginView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
    }
}

struct EmailLoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        EmailLoginViewController().toPreview()
    }
}
