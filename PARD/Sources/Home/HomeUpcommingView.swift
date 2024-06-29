//
//  HomeUpcommingView.swift
//  PARD
//
//  Created by 진세진 on 6/28/24.
//

import UIKit
import Then
import SnapKit

class HomeUpcommingView : UIView {
    private weak var viewController : UIViewController?
    private let upcommingLabel = UILabel().then {
        $0.font = .pardFont.head2
        $0.text = "🗓️ UPCOMMING EVENT 🗓️"
        $0.textColor = .pard.white100
    }
    
    private lazy var moreButton = UIButton().then {
        $0.setTitle("더보기", for: .normal)
        $0.titleLabel?.font = .pardFont.caption2
        $0.titleLabel?.textColor = .pard.gray10
        $0.setUnderline()
        $0.addTarget(self, action: #selector(tappedmoreButton), for: .touchUpInside)
    }
    
    private let eventTypeLabel = UILabel().then {
        $0.font = .pardFont.body2
        $0.textAlignment = .center
        $0.text = "전체"
        $0.textColor = .pard.white100
        $0.backgroundColor = .pard.gra
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    private let eventTitleLabel = UILabel().then {
        $0.font = .pardFont.head2
        $0.textColor = .pard.white100
        $0.text = "함께 자라기"
    }
    
    private let separator = UIView().then {
        $0.backgroundColor = .pard.gray10
    }
    
    private let dDayLabel = UILabel().then {
        $0.font = .pardFont.body2
        $0.textColor = .pard.white100
        $0.text = "D-DAY"
    }
    
    private let eventLocationLabel = UILabel().then {
        $0.text = "장소 : 한동대학교 에벤에셀 헤브론홀"
        $0.textColor = .pard.white100
        $0.font = .pardFont.body3
    }
    
    private let eventDateLabel = UILabel().then {
        $0.text = "일시 : 9월 20일 토요일 14:00-18:00"
        $0.textColor = .pard.white100
        $0.font = .pardFont.body3
    }
    
    convenience init(viewController : UIViewController) {
        self.init(frame: .zero)
        self.viewController = viewController
        setUpUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpUI() {
        addSubview(upcommingLabel)
        addSubview(moreButton)
        addSubview(separator)
        addSubview(eventTypeLabel)
        addSubview(eventTitleLabel)
        addSubview(eventDateLabel)
        addSubview(eventLocationLabel)
        addSubview(dDayLabel)
        
        upcommingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(upcommingLabel)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(upcommingLabel.snp.bottom).offset(15.5)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        eventTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(20.5)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(44)
            make.height.equalTo(25)
        }
        
        eventTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(eventTypeLabel)
            make.leading.equalTo(eventTypeLabel.snp.trailing).offset(8)
        }
        
        dDayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(eventTypeLabel)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        eventDateLabel.snp.makeConstraints { make in
            make.top.equalTo(eventTypeLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        eventLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(eventDateLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
    @objc private func tappedmoreButton() {
        let nextViewController = CalendarViewController()
        viewController?.navigationController?.setViewControllers([nextViewController], animated: false)
    }
}
