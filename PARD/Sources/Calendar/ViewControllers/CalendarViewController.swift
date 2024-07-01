import UIKit
import SnapKit
import Then

class CalendarViewController: UIViewController {
    private let appearance = UINavigationBarAppearance().then {
        $0.configureWithOpaqueBackground()
        $0.backgroundColor = .pard.blackBackground
        $0.shadowColor = .pard.blackBackground
    }
    
    private let upcomingEvents: [Event] = [
        Event(category: "전체", title: "3차 세미나", dDay: "D-DAY", date: "9월 20일 토요일 13:00", location: "한동대학교 에벤에셀 헤브론홀"),
        Event(category: "기획", title: "과제 제출", dDay: "D-7", date: "9월 20일 토요일 13:00", location: "한동대학교 에벤에셀 헤브론홀"),
        Event(category: "기획", title: "과제 제출", dDay: "D-14", date: "9월 27일 토요일 13:00", location: "기획 파트 4차 세미나 일정 공지합니다.")
    ]
    
    private let pastEvents: [Event] = [
        Event(category: "기획", title: "3차 세미나", dDay: "", date: "9월 20일 토요일 14:00-18:00", location: "한동대학교 에벤에셀 헤브론홀"),
        Event(category: "기획", title: "2차 세미나", dDay: "", date: "9월 13일 토요일 14:00-18:00", location: "한동대학교 에벤에셀 헤브론홀")
    ]
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pard.blackBackground
        setNavigation()
        setupTableView()
    }
    
    private func setNavigation() {
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withRenderingMode(.automatic), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .pard.gray10
        self.title = "일정"
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "EventCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .pard.blackBackground
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CalendarViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return upcomingEvents.count
        } else {
            return pastEvents.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 10 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .pard.blackBackground
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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
            separator.backgroundColor = .gray
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }
        let event = indexPath.section == 0 ? upcomingEvents[indexPath.row] : pastEvents[indexPath.row]
        cell.configure(with: event)
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
