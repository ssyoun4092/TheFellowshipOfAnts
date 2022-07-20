import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    let indicesSectionView = IndicesSectionView()
    let stockRankSectionView = StockRankSectionView()
    let spacingView = UIView()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.font = .systemFont(ofSize: 50, weight: .bold)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical

        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0

        [indicesSectionView, stockRankSectionView, titleLabel]
            .forEach { stackView.addArrangedSubview($0) }

        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        scrollView.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        contentView.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        spacingView.snp.makeConstraints {
            $0.height.equalTo(70)
        }
    }
}
