//
//  StockDetailViewController.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/04.
//

import UIKit
import SwiftUI
import SnapKit

class StockDetailViewController: UIViewController {

    // MARK: - Properties

    var coordinator: HomeCoordinator?

    // MARK: - IBOutlets

    let stockDetailView = StockDetailView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Methods

    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(stockDetailView)

        stockDetailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
