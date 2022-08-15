import UIKit
import SwiftUI
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    let indicesSectionView = IndicesSectionView()
    let stockRankSectionView = StockRankSectionView()
    let majorCommoditiesSectionView = MajorCommoditiesSectionView()
    let majorETFSectionView = MajorETFSectionView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical

        stackView.distribution = .equalSpacing
        stackView.spacing = 13.0

        let spacingView = UIView()
        spacingView.snp.makeConstraints {
            $0.height.equalTo(50)
        }

        [indicesSectionView, stockRankSectionView, majorCommoditiesSectionView, majorETFSectionView, spacingView]
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
    }
}

struct HomeViewControllerPreView: PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
