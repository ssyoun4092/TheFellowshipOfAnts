//
//  LikedTableViewCell.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/21.
//

import UIKit

import SnapKit

class LikedTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    let logoImageView = UIImageView()
    let companyNameLabel = UILabel()
    let symbolLabel = UILabel()
    let currentPrieeLabel = UILabel()
    let fluctuationRateLabel = UILabel()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLogoImageView()
        setupCompanyLabel()
        setupSymbolLabel()
        setupCurrentPriceLabel()
        setupFluctuationRateLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LikedTableViewCell {
    private func setupLogoImageView() {
        contentView.addSubview(logoImageView)

        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(logoImageView.snp.height)
            $0.centerY.equalToSuperview()
        }
    }

    private func setupCompanyLabel() {
        contentView.addSubview(companyNameLabel)

        companyNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(15)
        }
    }

    private func setupSymbolLabel() {
        contentView.addSubview(symbolLabel)

        symbolLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(15)
            $0.bottom.equalToSuperview().inset(10)
        }
    }

    private func setupCurrentPriceLabel() {
        contentView.addSubview(currentPrieeLabel)

        currentPrieeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(15)
        }
    }

    private func setupFluctuationRateLabel() {
        contentView.addSubview(fluctuationRateLabel)

        fluctuationRateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
