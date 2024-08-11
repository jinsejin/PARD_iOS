//
//  RankingViewController.swift
//  PARD
//
//  Created by 김민섭 on 3/4/24.
//

import UIKit
import Then
import SnapKit
import PARD_DesignSystem

class RankingViewController: UIViewController {
    private let appearance = UINavigationBarAppearance().then {
        $0.configureWithOpaqueBackground()
        $0.backgroundColor = .pard.blackBackground
        $0.shadowColor = .pard.blackBackground
        $0.titleTextAttributes = [
            .font: UIFont.pardFont.head1,
            .foregroundColor : UIColor.pard.white100,
        ]
    }
    private let rankingsManager = TotalRankManager.shared
    private let tableView = UITableView().then { view in
        view.backgroundColor = .pard.blackCard
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
    }
    private var rankingData: [TotalRank] = []
    private let textLabel = UILabel()
    
    private func setupTextLabel() {
        let horizontalPadding: CGFloat = 16

        let labelContainerView = UIView()
        labelContainerView.backgroundColor = .pard.blackCard
        labelContainerView.layer.borderWidth = 1
        labelContainerView.layer.borderColor = UIColor.gradientColor.gra.cgColor
        labelContainerView.layer.cornerRadius = 18
        view.addSubview(labelContainerView)

        textLabel.text = "🏆 PARDNERSHIP 🏆"
        textLabel.font = UIFont.pardFont.head2
        textLabel.textColor = .gradientColor.gra
        textLabel.textAlignment = .center
        labelContainerView.addSubview(textLabel)

        labelContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(180 + horizontalPadding * 2)
            $0.height.equalTo(36)
        }

        textLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(horizontalPadding)
        }
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RankingTableViewCell.self, forCellReuseIdentifier: RankingTableViewCell.identifier)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.rowHeight = 68
        tableView.layer.cornerRadius = 10
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        tableView.layer.masksToBounds = true
    }

    private func setNavigation() {
        self.navigationItem.title = "전체 랭킹"
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        let backButton = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = backButton
    }

    @objc func backButtonTapped() {
        removeTabBarFAB(bool: true)
        navigationController?.popViewController(animated: true)
    }
    
    private func getRankAllData() {
        getTotalRank { [weak self] success in
            guard let self = self else { return }
            if success {
                self.rankingData = self.rankingsManager.totalRankList
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Failed to load rank data.")
            }
        }
    }
}

// - MARK: RankingViewController의 생태주기
extension RankingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .pard.blackBackground
        setNavigation()
        setupTextLabel()
        setupTableView()
        getRankAllData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeTabBarFAB(bool: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func removeTabBarFAB(bool : Bool) {
        tabBarController?.setTabBarVisible(visible: !bool, animated: false)
        if let tabBarViewController = tabBarController as? HomeTabBarViewController {
            tabBarViewController.floatingButton.isHidden = bool
        }
    }
}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingTableViewCell.identifier, for: indexPath) as? RankingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        let userInfo = rankingData[indexPath.row]
        cell.configure(with: userInfo, rank: indexPath.row + 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row < rankingData.count - 1 {
            let separatorView = UIView()
            separatorView.backgroundColor = UIColor.pard.gray30
            cell.contentView.addSubview(separatorView)
            separatorView.snp.makeConstraints { make in
                make.leading.equalTo(cell.contentView.snp.leading)
                make.trailing.equalTo(cell.contentView.snp.trailing)
                make.bottom.equalTo(cell.contentView.snp.bottom)
                make.height.equalTo(1)
            }
        }
       
        if indexPath.row == 0 {
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        if indexPath.row == rankingData.count - 1 {
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
}
