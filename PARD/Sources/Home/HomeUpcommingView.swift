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
    private var scheduleData : [ScheduleModel] = []
    private var upcomingEvents : [ScheduleModel] = []
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
    
    private let noUpcomingEventsLabel = UILabel().then {
        $0.text = "다가오는 일정이 없어요."
        $0.font = .pardFont.body4
        $0.textColor = .pard.white100
        $0.textAlignment = .center
        $0.isHidden = true
    }
    
    private let eventTypeLabel = UILabel().then {
        $0.font = .pardFont.body2
        $0.textAlignment = .center
        $0.textColor = .pard.white100
        $0.backgroundColor = .GradientColor.gra
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    private let eventTitleLabel = UILabel().then {
        $0.font = .pardFont.head2
        $0.textColor = .pard.white100
    }
    
    private let separator = UIView().then {
        $0.backgroundColor = .pard.gray10
    }
    
    private let dDayLabel = UILabel().then {
        $0.font = .pardFont.body1
        $0.textColor =  .pard.gray10
    }
    
    private let eventLocationLabel = UILabel().then {
        $0.textColor = .pard.white100
        $0.font = .pardFont.body3
    }
    
    private let eventDateLabel = UILabel().then {
        $0.textColor = .pard.white100
        $0.font = .pardFont.body3
    }
    
    convenience init(viewController : UIViewController) {
        self.init(frame: .zero)
        self.viewController = viewController
        getDataSchedule()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
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
        addSubview(noUpcomingEventsLabel)
        
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
            make.bottom.equalToSuperview().offset(-20)
        }
        
        noUpcomingEventsLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(42.5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-46)
        }
    }
    
    @objc private func tappedmoreButton() {
        let nextViewController = CalendarViewController()
        viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    private func getDataSchedule() {
        ScheduleDataList.shared.getSchedule { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let schedules):
                    self?.scheduleData = schedules
                    self?.labelSetup()
                case .failure(_):
                    self?.scheduleData = []
                }
            }
        }
    }
   
}

// MARK: 서버에서 받아온 데이터 UI에 입히기 및 데이터 필터
extension HomeUpcommingView {
    private func showNoUpcomingEvents() {
        noUpcomingEventsLabel.isHidden = false
        eventTypeLabel.isHidden = true
        eventTypeLabel.backgroundColor = .pard.blackCard
        eventTitleLabel.isHidden = true
        dDayLabel.isHidden = true
        eventLocationLabel.isHidden = true
        eventDateLabel.isHidden = true
   }
    
    private func labelSetup() {
        isUpcomingevent()
        if upcomingEvents.isEmpty {
            showNoUpcomingEvents()
            return
        }
        let upcomingDate = dateFromString(upcomingEvents[0].date)
        guard let upcomingDate else { return }
     
        eventTitleLabel.text = upcomingEvents[0].title
        dDayLabel.text = "D - \(String(describing: upcomingEvents[0].remaingDay))"
        eventLocationLabel.text = eventLocationLabelSetup( upcomingEvents[0].contentsLocation)
        eventDateLabel.text = formattedDateString(from: upcomingDate)
        eventTypeLabel.text = upcomingEvents[0].part
    }
    
    private func eventLocationLabelSetup(_ location : String) -> String{
        if location != "" {
            return "장소 : \(location)"
        } else {
            eventLocationLabel.isHidden = true
            return ""
        }
    }
    
    private func isUpcomingevent() {
        upcomingEvents = scheduleData.filter { !$0.isPastEvent }.map {
            ScheduleModel(scheduleId: $0.scheduleId, title: $0.title, date: $0.date, content: $0.content, part: $0.part, contentsLocation: $0.contentsLocation, notice: $0.notice, remaingDay: $0.remaingDay, isPastEvent: $0.isPastEvent)
        }
    }
    
    private func dateFromString(_ dateString: String) -> Date? {
       let dateFormatter = DateFormatter()
       dateFormatter.locale = Locale(identifier: "ko_KR")
       dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
       return dateFormatter.date(from: dateString)
    }

    private func formattedDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "일시 : MM월 dd일 EEEE HH:mm"
        return dateFormatter.string(from: date)
    }
}

