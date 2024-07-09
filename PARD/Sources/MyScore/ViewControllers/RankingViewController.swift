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
    
    private let rankings = ["", "", "", "", "", "", ""]
    private let tableView = UITableView()
    private var userInfos: [UserInfo] = PardAppModel.userInfos
    private let textLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pard.blackBackground
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            getTotalRank()
        }
        setNavigation()
        setupTextLabel()
        setupTableView()
        
    }

    private func setupTextLabel() {
        let horizontalPadding: CGFloat = 16

        let labelContainerView = UIView()
        labelContainerView.backgroundColor = .clear
        labelContainerView.layer.borderWidth = 1
        labelContainerView.layer.borderColor = UIColor.GradientColor.gra.cgColor
        labelContainerView.layer.cornerRadius = 18
        view.addSubview(labelContainerView)

        textLabel.text = "🏆 PARDNERSHIP 🏆"
        textLabel.font = UIFont.pardFont.head2
        textLabel.textColor = .GradientColor.gra
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
    
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
}

// - MARK: RankingViewController의 생태주기
extension RankingViewController {

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
        return rankings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell").then {
            $0.textLabel?.text = rankings[indexPath.row]
            $0.textLabel?.textColor = .white
            $0.backgroundColor = indexPath.row < 7 ? UIColor.pard.blackCard : .clear
            $0.selectionStyle = .none
            $0.contentView.layer.cornerRadius = 10
            $0.contentView.layer.masksToBounds = true
        }
        
        let rankView = UIView().then {
            $0.backgroundColor = UIColor.pard.blackCard
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.layer.borderColor = determineBorderColor(for: indexPath.row + 1).cgColor
        }
        cell.contentView.addSubview(rankView)
        
        rankView.translatesAutoresizingMaskIntoConstraints = false
        
        rankView.snp.makeConstraints { make in
            make.leading.equalTo(cell.contentView.snp.leading).offset(22)
            make.top.equalTo(cell.contentView.snp.top).offset(23)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        let rankLabel = UILabel().then {
            $0.textColor = determineLabelColor(for: indexPath.row + 1)
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            $0.text = "\(indexPath.row + 1)등"
        }
        
        rankView.addSubview(rankLabel)
        
        rankLabel.snp.makeConstraints { make in
            make.centerX.equalTo(rankView.snp.centerX)
            make.centerY.equalTo(rankView.snp.centerY)
        }
        
        if indexPath.row < userInfos.count {
            let userInfo = userInfos[indexPath.row]
            
            let rankImageView = UIImageView()
            if indexPath.row == 0 {
                rankImageView.image = UIImage(named: "gold")
            } else if indexPath.row == 1 {
                rankImageView.image = UIImage(named: "silver")
            } else if indexPath.row == 2 {
                rankImageView.image = UIImage(named: "bronze")
            }
            
            if indexPath.row < 3 {
                cell.contentView.addSubview(rankImageView)
                rankImageView.snp.makeConstraints { make in
                    make.top.equalTo(rankView.snp.top).offset(-14)
                    make.trailing.equalTo(rankView.snp.trailing).offset(-9)
                    make.width.equalTo(20)
                    make.height.equalTo(20)
                }

                cell.contentView.bringSubviewToFront(rankImageView)
            }
            
            let userInfoLabel = UILabel().then {
                $0.text = "\(userInfo.name)"
                $0.textColor = .pard.gray10
                $0.font = UIFont.systemFont(ofSize: 16)
            }
            cell.contentView.addSubview(userInfoLabel)
            userInfoLabel.snp.makeConstraints { make in
                make.centerY.equalTo(cell.contentView.snp.centerY)
                make.leading.equalTo(rankView.snp.trailing).offset(8)
            }

            
            let userInfoPartLabel = UILabel().then {
                $0.text = "\(userInfo.part)"
                $0.textColor = .pard.gray30
                $0.font = UIFont.systemFont(ofSize: 12)
            }
            cell.contentView.addSubview(userInfoPartLabel)
            userInfoPartLabel.snp.makeConstraints { make in
                make.centerY.equalTo(cell.contentView.snp.centerY)
                make.leading.equalTo(userInfoLabel.snp.trailing).offset(4)
            }

            
            let userInfoScoreLabel = UILabel().then {
                $0.text = "\(userInfo.score)"
                $0.textColor = .pard.gray10
                $0.font = UIFont.systemFont(ofSize: 12)
            }
            cell.contentView.addSubview(userInfoScoreLabel)
            userInfoScoreLabel.snp.makeConstraints { make in
                make.centerY.equalTo(cell.contentView.snp.centerY)
                make.trailing.equalTo(cell.contentView.snp.trailing).offset(-16)
            }
        }

        if indexPath.row == 0 {
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }

        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row < 6 {
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
        
        if indexPath.row == rankings.count - 1 {
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
}

private func determineBorderColor(for rank: Int) -> UIColor {
    switch rank {
    case 1:
        return UIColor(red: 252/255, green: 196/255, blue: 23/255, alpha: 1)
    case 2:
        return UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    case 3:
        return UIColor(red: 247/255, green: 148/255, blue: 41/255, alpha: 1)
    default:
        return UIColor.pard.gray30
    }
}

private func determineLabelColor(for rank: Int) -> UIColor {
    switch rank {
    case 1:
        return UIColor(red: 252/255, green: 196/255, blue: 23/255, alpha: 1)
    case 2:
        return UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    case 3:
        return UIColor(red: 247/255, green: 148/255, blue: 41/255, alpha: 1)
    default:
        return UIColor.pard.gray30
    }
}
