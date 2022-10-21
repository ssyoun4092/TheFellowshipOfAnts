//
//  LikedViewController.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/21.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class LikedViewController: UIViewController {

    // MARK: - Properties

    let disposeBag = DisposeBag()

    weak var coordinator: LikedCoordinator?

    // MARK: - IBOutlets

    let likedTableView = UITableView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLikedTableView()
    }
}

extension LikedViewController {
    private func setupLikedTableView() {
        view.addSubview(likedTableView)

        likedTableView.register(LikedTableViewCell.self,
                                forCellReuseIdentifier: LikedTableViewCell.identifier)
        likedTableView.rowHeight = 60

        likedTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
