//
//  ToolTIpViewInMyScore.swift
//  PARD
//
//  Created by 진세진 on 7/9/24.
//

import UIKit

class ToolTipViewInMyScore: UIView {
    
    private let closeButton = UIButton()
    private let contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .pard.blackBackground
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.pard.primaryPurple.cgColor
        
        let mvpLabel = createLabel(text: "MVP", color: .pard.primaryPurple)
        let mvpDetail = createDetailLabel(text: "주요 행사 MVP", details: [("5점", .gray)])
        let mvpSubDetail = createDetailLabel(text: "세미나 파트별 MVP", details: [("3점", .gray)])
        
        let studyLabel = createLabel(text: "스터디", color: .pard.primaryPurple)
        let studyDetail = createDetailLabel(text: "개최 및 수료", details: [("5점", .gray)])
        let studySubDetail = createDetailLabel(text: "참여 및 수료", details: [("3점", .gray)])
        
        let communicationLabel = createLabel(text: "소통", color: .pard.primaryPurple)
        let communicationDetail = createDetailLabel(text: "파드 구성원과의 만남 후 사진을 슬랙에 인증", details: [("1점/주 1회", .gray)])
        
        let reportLabel = createLabel(text: "회고", color: .pard.primaryPurple)
        let reportDetail = createDetailLabel(text: "디스코이엇 작성 후 파트장에게 공유", details: [("3점/필수과제 제외", .gray)])
        
        let penaltyLabel = createLabel(text: "벌점", color: .pard.errorRed)
        
        let penaltyDetail = createDetailLabel(text: "세미나 지각(10분 이내)", details: [("-1점", .gray)])
        
        let penaltyDetail1 = createDetailLabel(text: "세미나 결석", details: [("-2점", .gray)])
        
        let penaltyDetail2 = createDetailLabel(text: "과제 지각", details: [("-0.5점", .gray)])
        
        let penaltyDetail3 = createDetailLabel(text: "과제 미제출", details: [("-1점", .gray)])
        
        let mvpStackView = createStackView(arrangedSubviews: [mvpLabel, mvpDetail, mvpSubDetail])
        let studyStackView = createStackView(arrangedSubviews: [studyLabel, studyDetail, studySubDetail])
        let communicationStackView = createStackView(arrangedSubviews: [communicationLabel, communicationDetail])
        let reportStackView = createStackView(arrangedSubviews: [reportLabel, reportDetail])
        let penaltyStackView = createStackView(arrangedSubviews: [penaltyLabel, penaltyDetail, penaltyDetail1,penaltyDetail2, penaltyDetail3])
        
        let stackView = UIStackView(arrangedSubviews: [
            mvpStackView,
            studyStackView,
            communicationStackView,
            reportStackView,
            penaltyStackView
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        contentView.addSubview(stackView)
        addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        addSubview(closeButton)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    private func createLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.layer.cornerRadius = 8
        label.layer.borderWidth = 1
        label.layer.borderColor = color.cgColor
        label.textAlignment = .center
        label.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(24)
        }
        return label
    }
    
    private func createDetailLabel(text: String, details: [(String, UIColor)]) -> UIStackView {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textAlignment = .left
        
        var views: [UIView] = [label]
        
        for (point, color) in details {
            let pointLabel = UILabel()
            pointLabel.text = point
            pointLabel.textColor = color
            pointLabel.font = UIFont.systemFont(ofSize: 10)
            pointLabel.backgroundColor = .darkGray
            pointLabel.layer.cornerRadius = 4
            pointLabel.layer.masksToBounds = true
            pointLabel.textAlignment = .center
            pointLabel.snp.makeConstraints { make in
                make.width.equalTo(40)
                make.height.equalTo(20)
            }
            views.append(pointLabel)
        }
        
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        
        return stackView
    }
    
    private func createSubDetailLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }
    
    private func createStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        
        arrangedSubviews.forEach { subview in
            if let label = subview as? UILabel {
                label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            }
        }
        
        return stackView
    }
    
    @objc private func closeTapped() {
        removeFromSuperview()
    }
}
