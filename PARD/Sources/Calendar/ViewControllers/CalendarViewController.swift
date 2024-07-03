import UIKit
import SnapKit
import Then

class CalendarViewController: UIViewController {
    private let appearance = UINavigationBarAppearance().then {
        $0.configureWithOpaqueBackground()
        $0.backgroundColor = .pard.blackBackground
        $0.shadowColor = .pard.blackBackground
    }
    
    private let previousAppearance = UINavigationBarAppearance().then {
        $0.configureWithOpaqueBackground()
        $0.backgroundColor = .pard.blackCard
        $0.shadowColor = .pard.blackCard
    }
    
    private let upcomingEvents: [Event] = Event.upcomingEvents
    
    private let pastEvents: [Event] = Event.pastEvents
    
    private let tableView = UITableView(frame: .zero, style: .grouped).then { tableView in
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .pard.blackBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pard.blackBackground
        setNavigation()
        setupTableView()
    }
    
    private func setNavigation() {
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withRenderingMode(.automatic), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .pard.gray10
        self.title = "일정"
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.standardAppearance = previousAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = previousAppearance
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "EventCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview()
        }
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? upcomingEvents.count : pastEvents.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .pard.blackBackground
        let label = UILabel()
        label.textColor = .pard.white100
        label.font = .pardFont.head2
        label.text = section == 0 ? "다가오는 일정" : "지난 일정"
        headerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let separatorView = UIView()
            separatorView.backgroundColor = .pard.blackBackground
            let separator = UIView()
            separator.backgroundColor = .pard.gray10
            separatorView.addSubview(separator)
            separator.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.leading.trailing.equalToSuperview().inset(16)
                make.centerY.equalToSuperview()
            }
            return separatorView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150  // 각 셀의 높이를 150으로 설정
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }
        let event = indexPath.section == 0 ? upcomingEvents[indexPath.row] : pastEvents[indexPath.row]
        cell.selectionStyle = .none
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.categoryLabelConfigure(textColor: .pard.gray10, backGroundColor: .pard.gra)
        } else {
            cell.categoryLabelConfigure(textColor: .pard.gra, backGroundColor: .pard.blackCard)
        }
        cell.dataConfigure(with: event)
        return cell
    }
}

struct Event {
    let category: String
    let title: String
    let dDay: String
    let date: String
    let location: String
}

extension Event {
    static let upcomingEvents: [Event] = [
        Event(category: "전체", title: "3차 세미나", dDay: "D-DAY", date: "9월 20일 토요일 13:00", location: "한동대학교 에벤에셀 헤브론홀"),
        Event(category: "기획", title: "과제 제출", dDay: "D-7", date: "9월 20일 토요일 13:00", location: "한동대학교 에벤에셀 헤브론홀"),
        Event(category: "기획", title: "과제 제출", dDay: "D-14", date: "9월 27일 토요일 13:00", location: "기획 파트 4차 세미나 일정 공지합니다.")
    ]
    
    static let pastEvents: [Event] = [
        Event(category: "기획", title: "3차 세미나", dDay: "", date: "9월 20일 토요일 14:00-18:00", location: "한동대학교 에벤에셀 헤브론홀"),
        Event(category: "기획", title: "2차 세미나", dDay: "", date: "9월 13일 토요일 14:00-18:00", location: "한동대학교 에벤에셀 헤브론홀")
    ]
}
