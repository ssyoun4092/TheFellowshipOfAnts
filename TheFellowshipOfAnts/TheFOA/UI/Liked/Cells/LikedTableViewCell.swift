//
//  LikedTableViewCell.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/21.
//

import UIKit

import Charts
import SnapKit

class LikedTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    let wrapperView = UIView()
    let logoImageView = UIImageView()
    let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    let companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    let chartView = LineChartView()
    let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        return label
    }()
    let fluctuationRateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        setupWrapperView()
        setupLogoImageView()
        setupSymbolLabel()
        setupCompanyNameLabel()
        setupCurrentPriceLabel()
        setupFluctuationRateLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: Entity.Liked) {
        logoImageView.kf.setImage(with: item.logoImageURL)
        companyNameLabel.text = item.companyName
        symbolLabel.text = item.symbol
    }

    private func drawCharts(with values: [Double]) {

    }
}

extension LikedTableViewCell {
    private func setupWrapperView() {
        contentView.addSubview(wrapperView)

        wrapperView.backgroundColor = .systemGray.withAlphaComponent(0.2)
        wrapperView.layer.cornerRadius = 17

        wrapperView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

    private func setupLogoImageView() {
        wrapperView.addSubview(logoImageView)

        logoImageView.layer.cornerRadius = 15
        logoImageView.clipsToBounds = true

        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.height.equalTo(wrapperView.snp.height).multipliedBy(0.6)
            $0.width.equalTo(logoImageView.snp.height)
            $0.centerY.equalToSuperview()
        }
    }

    private func setupSymbolLabel() {
        wrapperView.addSubview(symbolLabel)

        symbolLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10).priority(.low)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().multipliedBy(0.35)
            $0.bottom.equalTo(wrapperView.snp.centerY).offset(-2)
        }
    }

    private func setupCompanyNameLabel() {
        wrapperView.addSubview(companyNameLabel)

        companyNameLabel.snp.makeConstraints {
            $0.top.equalTo(wrapperView.snp.centerY).offset(4)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().multipliedBy(0.35)
            $0.bottom.equalToSuperview().inset(10).priority(.low)
        }
    }

    private func setupCurrentPriceLabel() {
        wrapperView.addSubview(currentPriceLabel)

        currentPriceLabel.text = "$139.35"

        currentPriceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10).priority(.low)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(wrapperView.snp.centerY).offset(-2)
        }
    }

    private func setupFluctuationRateLabel() {
        wrapperView.addSubview(fluctuationRateLabel)

        fluctuationRateLabel.text = "+3.21%"

        fluctuationRateLabel.snp.makeConstraints {
            $0.top.equalTo(wrapperView.snp.centerY).offset(4)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10).priority(.low)
        }
    }
}
