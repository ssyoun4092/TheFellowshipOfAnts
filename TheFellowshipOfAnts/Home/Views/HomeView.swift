//
//  HomeView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/25.
//

import UIKit
import SnapKit

class HomeView: UIView {

    // MARK: - IBOulets

    let scrollView = UIScrollView()
    let contentView = UIView()

    let VStack = UIStackView()
    let indicesSectionView = IndicesSectionView()
    let stockRankSectionView = StockRankSectionView()
    let majorCommoditiesSectionView = MajorCommoditiesSectionView()
    let majorETFSectionView = MajorETFSectionView()
    let spacingView = UIView()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupScrollView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView {
    private func setupScrollView() {
        addSubview(scrollView)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        setupContentView()
    }

    private func setupContentView() {
        scrollView.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        setupVStack()
    }

    private func setupVStack() {
        contentView.addSubview(VStack)

        VStack.axis = .vertical
        VStack.distribution = .equalSpacing
        VStack.spacing = 13

        VStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        [indicesSectionView, stockRankSectionView, majorCommoditiesSectionView, majorETFSectionView, spacingView].forEach { VStack.addArrangedSubview($0) }

        spacingView.snp.makeConstraints {
            $0.height.equalTo(70)
        }
    }
}
