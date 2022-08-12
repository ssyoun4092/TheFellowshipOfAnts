import UIKit
import SnapKit

class InputTextContainerView: UIView {
    private lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메세지를 입력하세요..."
        textField.addLeftPadding(20)
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .lightGray

        return textField
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton()
        let sendImage = UIImage(systemName: "paperpalne")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        button.setImage(sendImage, for: .normal)
        button.backgroundColor = .systemCyan

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
        addSubview(inputTextField)
        inputTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }

        inputTextField.addSubview(sendButton)
        sendButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(50)
        }
    }
}
