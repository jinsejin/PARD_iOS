//
//  ToolTIpViewInMyScore.swift
//  PARD
//
//  Created by 진세진 on 7/9/24.
//

import UIKit

class ToolTIpViewInMyScore: UIView {
    
    private let closeButton = UIButton()
    
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
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = UIColor.pard.gray30
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        addSubview(closeButton)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-8)
            make.width.height.equalTo(20)
        }
        
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 8
        contentStack.alignment = .leading
        contentStack.distribution = .fillProportionally
        addSubview(contentStack)
        
        contentStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)

        }
        
        addMVPRow(to: contentStack, title: "MVP", details: [
            ("주요 행사 MVP", "5점"),
            ("세미나 파트별 MVP", "3점")
        ])
        addStudyRow(to: contentStack, title: "스터디", details: [
            ("개최 및 수료", "5점"),
            ("참여 및 수료", "3점")
        ])
        addRow(to: contentStack, title: "소통", detail: "파드 구성원과의 만남 후 사진을 슬랙에 인증", point: "1점/주 1회", highlight: true)
        addRow(to: contentStack, title: "회고", detail: "디스콰이어 작성 후 파트장에게 공유", point: "3점/필수과제 제외", highlight: true)
        addPenaltyRows(to: contentStack, title: "벌점", details: [
            ("세미나 지각(10분 이내)", "-1점"),
            ("세미나 결석", "-2점"),
            ("과제 지각", "-0.5점"),
            ("과제 미제출", "-1점")
        ])
    }
    
    private func addMVPRow(to stackView: UIStackView, title: String, details: [(String, String)]) {
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.spacing = 8
        rowStack.alignment = .center
        
        let titleLabel = createTitleLabel(withText: title, textColor: UIColor.pard.primaryPurple)
        rowStack.addArrangedSubview(titleLabel)
        
        for (detail, point) in details {
            let detailLabel = createLabel(withText: detail)
            rowStack.addArrangedSubview(detailLabel)
            
            let pointLabel = createDynamicPointLabel(withText: point)
            rowStack.addArrangedSubview(pointLabel)
        }
        
        stackView.addArrangedSubview(rowStack)
    }
    
    private func addStudyRow(to stackView: UIStackView, title: String, details: [(String, String)]) {
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.spacing = 8
        rowStack.alignment = .center
        
        let titleLabel = createTitleLabel(withText: title, textColor: UIColor.pard.primaryPurple)
        rowStack.addArrangedSubview(titleLabel)
        
        for (detail, point) in details {
            let detailLabel = createLabel(withText: detail)
            rowStack.addArrangedSubview(detailLabel)
            
            let pointLabel = createDynamicPointLabel(withText: point)
            rowStack.addArrangedSubview(pointLabel)
        }
        
        stackView.addArrangedSubview(rowStack)
    }
    
    private func addRow(to stackView: UIStackView, title: String, detail: String, point: String, highlight: Bool) {
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.spacing = 8
        rowStack.alignment = .center
        
        let titleLabel = createTitleLabel(withText: title, textColor: highlight ? UIColor.pard.primaryPurple : UIColor.pard.errorRed)
        rowStack.addArrangedSubview(titleLabel)
        
        let detailLabel = createLabel(withText: detail)
        rowStack.addArrangedSubview(detailLabel)
        
        let pointLabel = createDynamicPointLabel(withText: point)
        rowStack.addArrangedSubview(pointLabel)
        
        stackView.addArrangedSubview(rowStack)

    }
    
    private func addPenaltyRows(to stackView: UIStackView, title: String, details: [(String, String)]) {
        let titleLabel = createTitleLabel(withText: title, textColor: UIColor.pard.errorRed)
        
        let titleStack = UIStackView()
        titleStack.axis = .horizontal
        titleStack.spacing = 8
        titleStack.alignment = .center
        titleStack.addArrangedSubview(titleLabel)
        
        let firstRowStack = UIStackView()
        firstRowStack.axis = .horizontal
        firstRowStack.spacing = 8
        firstRowStack.alignment = .center
        
        let secondRowStack = UIStackView()
        secondRowStack.axis = .horizontal
        secondRowStack.spacing = 8
        secondRowStack.alignment = .center
        
        for (index, detail) in details.enumerated() {
            let detailLabel = createLabel(withText: detail.0)
            let pointLabel = createDynamicPointLabel(withText: detail.1)
            
            if index < 2 {
                firstRowStack.addArrangedSubview(detailLabel)
                firstRowStack.addArrangedSubview(pointLabel)
            } else {
                secondRowStack.addArrangedSubview(detailLabel)
                secondRowStack.addArrangedSubview(pointLabel)
            }
        }
        
        let combinedStack = UIStackView()
        combinedStack.axis = .vertical
        combinedStack.spacing = 4
        combinedStack.alignment = .leading
        combinedStack.addArrangedSubview(firstRowStack)
        combinedStack.addArrangedSubview(secondRowStack)
        
        let mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.spacing = 8
        mainStack.alignment = .center
        mainStack.addArrangedSubview(titleStack)
        mainStack.addArrangedSubview(combinedStack)
        
        stackView.addArrangedSubview(mainStack)
    }
    
    private func createLabel(withText text: String, textColor: UIColor = .white) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: 10)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }
    
    private func createTitleLabel(withText text: String, textColor: UIColor = .white) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.borderWidth = 1
        label.layer.borderColor = textColor.cgColor
        label.layer.masksToBounds = true
        label.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }
    
    private func createDynamicPointLabel(withText text: String, textColor: UIColor = .white) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .pard.gray30
        label.font = UIFont.systemFont(ofSize: 9.6)
        label.layer.cornerRadius = 8
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.clear.cgColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.backgroundColor = .pard.blackCard
        label.layer.masksToBounds = true

        label.snp.makeConstraints { make in
            make.height.equalTo(19)
            if text.count > 8 {
                make.width.greaterThanOrEqualTo(82)
            } else if text.count > 5 {
                make.width.greaterThanOrEqualTo(50)
            } else {
                make.width.greaterThanOrEqualTo(27)
            }

        }
        
        return label
    }

    @objc private func closeTapped() {
        removeFromSuperview()
    }
}
