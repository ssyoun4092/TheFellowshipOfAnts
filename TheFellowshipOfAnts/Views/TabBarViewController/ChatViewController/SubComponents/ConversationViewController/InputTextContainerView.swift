import UIKit
import SnapKit

class InputTextContainerView: UIView {
    private lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메세지를 입력하세요..."
        textField.addLeftPadding(20)

        return textField
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton()

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InputTextContainerView {
    private func layout() {
        addSubviews([inputTextField, sendButton])

        inputTextField.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.trailing.equalTo(sendButton.snp.leading).offset(10)
        }

        sendButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalTo(50)
        }
    }
}
