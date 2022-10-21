//
//  StockOverviewCollectionViewCell.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/09.
//

import UIKit

import SnapKit

class StockOverviewCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties


    // MARK: - IBOutlets

    let titleLabel = UILabel()
    let contentLabel = UILabel()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupTitleLabel()
        setupValueLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configure(with title: String, value: String) {
        titleLabel.text = title
        contentLabel.text = value
    }

    func bind(to viewModel: StockOverviewCellViewModel) {
        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.content
    }
}

extension StockOverviewCollectionViewCell {
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)

        titleLabel.text = "시가 총액"
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }

    private func setupValueLabel() {
        contentView.addSubview(contentLabel)

        contentLabel.text = "59B"
        contentLabel.font = .systemFont(ofSize: 16, weight: .semibold)

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
