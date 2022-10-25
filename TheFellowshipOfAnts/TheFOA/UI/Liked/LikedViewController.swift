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
    let viewModel: LikedViewModel

    weak var coordinator: LikedCoordinator?

    // MARK: - IBOutlets

    let likedTableView = UITableView()

    // MARK: - Life Cycle

    init(viewModel: LikedViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLikedTableView()
        bind(to: viewModel)
    }

    private func bind(to viewModel: LikedViewModel) {
        rx.viewWillAppear
            .map { _ in () }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)

        likedTableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.likedItemSelected)
            .disposed(by: disposeBag)
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
