//
//  EventTableViewCell.swift
//  PARD
//
//  Created by 진세진 on 6/30/24.
//
import UIKit
import SnapKit
import Then

class EventTableViewCell: UITableViewCell {
    private let categoryLabel = UILabel().then { label in
        label.font = .pardFont.body2
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.pard.gra.cgColor
        label.layer.masksToBounds = true
    }
    
    private let titleLabel = UILabel().then { label in
        label.textColor = .pard.gray10
        label.textAlignment = .center
        label.font = .pardFont.head2
    }
    
    private let dDayLabel = UILabel().then { label in
        label.font = .pardFont.body1
        label.textColor = .pard.gray30
    }
    
    private let dateLabel = UILabel().then { label in
        label.font = .pardFont.body5
        label.textColor = .pard.gray10
    }
    
    private let locationLabel = UILabel().then { label in
        label.font = .pardFont.body5
        label.textColor = .pard.gray10
    }
    
    private let stackView = UIStackView().then { stak in
        stak.axis = .vertical
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8.0, left: 0, bottom: 8.0, right: 0))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .pard.blackBackground
        contentView.backgroundColor = .pard.blackCard
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(locationLabel)
        
        contentView.addSubview(stackView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dDayLabel)
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(45)
            make.bottom.equalTo(stackView.snp.top).offset(-16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.leading.equalTo(categoryLabel.snp.trailing).offset(8)
        }
        
        dDayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(stackView.snp.top).offset(-19)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func titleLabelConfigure(titleColor : UIColor , backgroundColor : UIColor) {
        titleLabel.backgroundColor = backgroundColor
        titleLabel.textColor = titleColor
    }
    
    func dataConfigure(with schedule: ScheduleModel) {
        categoryLabel.text = schedule.part
        titleLabel.text = schedule.title
        dDayLabel.text = schedule.remaingDay > 0 ? "D-\(schedule.remaingDay)" : ""
        dateLabel.text = "일시 : \(schedule.date)"
        locationLabel.text = "장소 : \(schedule.contentsLocation)"
    }
    
    func categoryLabelConfigure(textColor : UIColor, backGroundColor : UIColor) {
        categoryLabel.textColor = textColor
        categoryLabel.backgroundColor = backGroundColor
    }
}
