//
//  EventTableViewCell.swift
//  PARD
//
//  Created by 진세진 on 6/30/24.
//

import UIKit


class EventTableViewCell: UITableViewCell {
    
    private let categoryLabel = UILabel()
    private let titleLabel = UILabel()
    private let dDayLabel = UILabel()
    private let dateLabel = UILabel()
    private let locationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .darkGray
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        categoryLabel.textColor = .blue
        categoryLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        dDayLabel.textColor = .white
        dDayLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        dateLabel.textColor = .white
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        
        locationLabel.textColor = .white
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        
        let stackView = UIStackView(arrangedSubviews: [categoryLabel, titleLabel, dDayLabel, dateLabel, locationLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func configure(with event: Event) {
        categoryLabel.text = event.category
        titleLabel.text = event.title
        dDayLabel.text = event.dDay
        dateLabel.text = "일시 : \(event.date)"
        locationLabel.text = "장소 : \(event.location)"
    }
}
