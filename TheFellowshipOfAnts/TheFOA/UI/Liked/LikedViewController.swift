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

    let likedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "관심 목록"
        label.font = .systemFont(ofSize: 27, weight: .bold)
        return label
    }()
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 관심있는 종목이 없어요.."
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.isHidden = true
        return label
    }()
    lazy var likedTableView: UITableView = {
        let tv = UITableView()
        tv.register(LikedTableViewCell.self, forCellReuseIdentifier: LikedTableViewCell.identifier)
        tv.rowHeight = 100
        tv.separatorStyle = .none
        return tv
    }()

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

        viewModel.likedItems
            .drive(likedTableView.rx.items(
                cellIdentifier: LikedTableViewCell.identifier,
                cellType: LikedTableViewCell.self)
            ) { _, likedEntity, cell in
                cell.configure(with: likedEntity)
            }
            .disposed(by: disposeBag)
    }
}

extension LikedViewController {
    private func setupLikedTableView() {
        view.addSubview(likedTitleLabel)

        likedTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        view.addSubview(emptyLabel)

        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        view.addSubview(likedTableView)

        likedTableView.snp.makeConstraints {
            $0.top.equalTo(likedTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
