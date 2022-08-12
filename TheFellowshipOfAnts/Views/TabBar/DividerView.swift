import UIKit
import SnapKit

class DividerView: UIView {
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
