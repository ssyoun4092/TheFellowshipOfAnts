import UIKit
import SnapKit
import RxSwift

class MessagesViewController: UIViewController, KeyboardHandler {
    var barBottomConstraint: NSLayoutConstraint!
    var disposeBag = DisposeBag()

    private lazy var messagesView = MessagesView()
    private lazy var inputTextContainerView = InputTextContainerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        //        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
        //            self?.showKeyboard(notification: notification)
        //        }
        NotificationCenter.default.addObserver(self, selector: #selector(handlingKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlingKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapView)))
//        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layoutNavigationBar()
        layout()
    }

    @objc func tapView() {
        view.endEditing(true)
    }

    func bind() {
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .map { notification -> (height: CGFloat, duration: TimeInterval) in
                guard let userinfo = notification.userInfo,
                      let keyboardFrame = (userinfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return (height: .zero, duration: 0)}
                let durationNumber = userinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
                return (height: keyboardFrame.height, duration: durationNumber.doubleValue)
            }
            .subscribe { info in
                UIView.animate(withDuration: info.duration) {
                    self.inputTextContainerView.snp.updateConstraints {
                        $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-info.height + self.view.safeAreaInsets.bottom)
                    }
                    self.view.layoutIfNeeded()
                }
            }
            .disposed(by: disposeBag)
    }

    @objc func handlingKeyboard(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if notification.name == UIResponder.keyboardWillHideNotification {
            inputTextContainerView.snp.updateConstraints {
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            }
        } else {
            inputTextContainerView.snp.updateConstraints {
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-keyboardFrame.height + view.safeAreaInsets.bottom)
            }
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        if notification.name == UIResponder.keyboardWillShowNotification {
            messagesView.scroll(to: .bottom)
        }
    }
}

extension MessagesViewController {
    private func layoutNavigationBar() {
        title = "에코프로비엠"
    }

    private func layout() {
        view.backgroundColor = .white
        view.addSubviews([messagesView, inputTextContainerView])

        messagesView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalTo(inputTextContainerView.snp.top).offset(-5)
        }

        inputTextContainerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
