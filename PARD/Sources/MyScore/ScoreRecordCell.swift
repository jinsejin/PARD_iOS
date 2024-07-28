//
//  MyScoreView.swift
//  PARD
//
//  Created by 진세진 on 3/5/24.
//

import UIKit
import SnapKit
import Then

class ScoreRecordCell: UICollectionViewCell {
    static let identifier = "ScoreRecordCell"
    private let tagView = UIView().then { view in
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
    }
    private let tagLabel = UILabel().then { label in
        label.font = UIFont.pardFont.body2
        label.textAlignment = .center
    }
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let pointsLabel = UILabel()
    private let backgroundCardView = UIView()
    private let separatorView = UIView()
    private let redDotView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        
        backgroundCardView.backgroundColor = .pard.blackCard
        backgroundCardView.layer.borderWidth = 1
        backgroundCardView.layer.borderColor = UIColor.pard.blackBackground.cgColor
        contentView.addSubview(backgroundCardView)
        
        redDotView.backgroundColor = .pard.errorRed
        redDotView.layer.cornerRadius = 3
        redDotView.isHidden = true 
        contentView.addSubview(redDotView)
        
        titleLabel.font = UIFont.pardFont.body4
        titleLabel.textColor = .pard.gray10
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        dateLabel.font = UIFont.pardFont.body3
        dateLabel.textColor = .pard.gray30
        dateLabel.textAlignment = .left
        
        pointsLabel.font = UIFont.pardFont.body3
        pointsLabel.textColor = .pard.gray30
        pointsLabel.textAlignment = .right
        
        separatorView.backgroundColor = .pard.gray30
        contentView.addSubview(separatorView)
        
        backgroundCardView.addSubview(tagView)
        tagView.addSubview(tagLabel)
        backgroundCardView.addSubview(titleLabel)
        backgroundCardView.addSubview(dateLabel)
        backgroundCardView.addSubview(pointsLabel)
 
        backgroundCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tagView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(tagView.snp.top).offset(2)
            make.leading.equalTo(tagView.snp.leading).offset(12)
            make.trailing.equalTo(tagView.snp.trailing).offset(-12)
            make.bottom.equalTo(tagView.snp.bottom).offset(-2)
        }
        redDotView.snp.makeConstraints { make in
            make.top.equalTo(backgroundCardView).offset(13)
            make.leading.equalTo(backgroundCardView).offset(29)
            make.width.height.equalTo(5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(tagLabel.snp.bottom).offset(12)
            make.leading.equalTo(backgroundCardView).offset(12)
            make.trailing.equalTo(backgroundCardView).offset(-12)
            make.height.equalTo(36)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(backgroundCardView).offset(28)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.top)
            make.leading.equalTo(dateLabel.snp.trailing).offset(1)
            make.trailing.equalTo(backgroundCardView).offset(-28)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(1)
        }
    }
    
    func configure(with record: ReasonPardnerShip, isLastItem: Bool, isFirstItem: Bool) {
        tagLabel.text = record.reason
        titleLabel.text = record.detail
        dateLabel.text = formatDateString(record.createAt)
        pointsLabel.text = pointConfigure(point: record.point)
        separatorView.isHidden = isLastItem
        redDotView.isHidden = !isFirstItem

        if record.reason == "벌점" {
            tagView.layer.borderColor = UIColor.pard.errorRed.cgColor
            tagLabel.textColor = .pard.errorRed
            tagView.backgroundColor = .clear
        } else {
            tagView.layer.borderColor = UIColor.pard.primaryPurple.cgColor
            tagLabel.textColor = .pard.primaryPurple
            tagView.backgroundColor = .clear
        }
    }
    
    func formatDateString(_ createAtString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // 원본 날짜 포맷
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: createAtString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MM.dd(E) |"
            displayFormatter.locale = Locale(identifier: "ko_KR")
            displayFormatter.timeZone = TimeZone.current
            
            let formattedDateString = displayFormatter.string(from: date)
            return formattedDateString
        } else {
            print("🚨 날짜 변환에 실패했습니다.")
            return ""
        }
    }
    
    private func pointConfigure( point : Float) -> String {
        let formattedPoint: String
        if point.truncatingRemainder(dividingBy: 1) == 0 {
            formattedPoint = String(format: "%.0f", point)
        } else {
            formattedPoint = String(point)
        }

        if point < 0 {
            return "-\(formattedPoint)점"
        } else {
            return "+\(formattedPoint)점"
        }
    }
}

