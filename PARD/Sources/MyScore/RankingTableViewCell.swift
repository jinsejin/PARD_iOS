//
//  RankingTableViewCell.swift
//  PARD
//
//  Created by 진세진 on 7/12/24.
//
import UIKit
import Then
import SnapKit

class RankingTableViewCell: UITableViewCell {
    static let identifier = "RankingTableViewCell"
    
    private let rankView = UIView().then {
        $0.backgroundColor = UIColor.pard.blackCard
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
    }
    
    private let rankLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    private let rankImageView = UIImageView()
    private let userInfoLabel = UILabel().then {
        $0.textColor = .pard.gray10
        $0.font =  .pardFont.head2
    }
    
    private let userInfoPartLabel = UILabel().then {
        $0.textColor = .pard.gray30
        $0.font = .pardFont.body3
    }
    
    private let userInfoScoreLabel = UILabel().then {
        $0.textColor = .pard.gray10
        $0.font =  .pardFont.body1
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .pard.blackCard
        contentView.backgroundColor = .pard.blackCard
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(rankView)
        rankView.addSubview(rankLabel)
        contentView.addSubview(rankImageView)
        contentView.addSubview(userInfoLabel)
        contentView.addSubview(userInfoPartLabel)
        contentView.addSubview(userInfoScoreLabel)
    }
    
    private func setupConstraints() {
        rankView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(22)
            make.top.equalTo(contentView.snp.top).offset(23)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.centerX.equalTo(rankView.snp.centerX)
            make.centerY.equalTo(rankView.snp.centerY)
        }
        
        rankImageView.snp.makeConstraints { make in
            make.top.equalTo(rankView.snp.top).offset(-14)
            make.trailing.equalTo(rankView.snp.trailing).offset(-9)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(rankView.snp.trailing).offset(8)
        }
        
        userInfoPartLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(userInfoLabel.snp.trailing).offset(4)
        }
        
        userInfoScoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
    }
    
    func configure(with userInfo: TotalRank, rank: Int) {
        rankLabel.text = "\(rank)등"
        rankLabel.textColor = determineLabelColor(for: rank)
        rankView.layer.borderColor = determineBorderColor(for: rank).cgColor
        
        userInfoLabel.text = userInfo.name
        userInfoPartLabel.text = userInfo.part
        userInfoScoreLabel.text = "\(userInfo.totalBonus)점"
        
        if rank == 1 {
            rankImageView.image = UIImage(named: "gold")
        } else if rank == 2 {
            rankImageView.image = UIImage(named: "silver")
        } else if rank == 3 {
            rankImageView.image = UIImage(named: "bronze")
        } else {
            rankImageView.image = nil
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
}
