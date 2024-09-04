import UIKit
import SnapKit
import Then

class CalendarViewController: UIViewController {
    var schedules: [ScheduleModel] = []
    private let appearance = UINavigationBarAppearance().then {
        $0.configureWithOpaqueBackground()
        $0.backgroundColor = .pard.blackBackground
        $0.shadowColor = .pard.blackBackground
        $0.titleTextAttributes = [
            .foregroundColor: UIColor.pard.white100,
            .font: UIFont.pardFont.head1
        ]
    }
    
    private let previousAppearance = UINavigationBarAppearance().then {
        $0.configureWithOpaqueBackground()
        $0.backgroundColor = .pard.blackCard
        $0.shadowColor = .pard.blackCard
    }
    
    private var upcomingEvents: [ScheduleModel] = []
    private var pastEvents: [ScheduleModel] = []
    
    private let tableView = UITableView(frame: .zero, style: .grouped).then { tableView in
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .pard.blackBackground
    }
        
    private func setNavigation() {
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [
                .font:  UIFont.pardFont.head2,
                .foregroundColor: UIColor.pard.white100
            ]
        }
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
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview()
        }
    }
    
    func updateEvents() {
        upcomingEvents = schedules.filter { !$0.isPastEvent }.map {
            ScheduleModel(scheduleId: $0.scheduleId, title: $0.title, date: $0.date, content: $0.content, part: $0.part, contentsLocation: $0.contentsLocation, notice: $0.notice, remaingDay: $0.remaingDay, isPastEvent: $0.isPastEvent)
        }
        pastEvents = schedules.filter { $0.isPastEvent }.map {
            ScheduleModel(scheduleId: $0.scheduleId, title: $0.title, date: $0.date, content: $0.content, part: $0.part, contentsLocation: $0.contentsLocation, notice: $0.notice, remaingDay: $0.remaingDay, isPastEvent: $0.isPastEvent)
        }
        tableView.reloadData()
    }
}
// - MARK: CalendarViewController의 생태주기
extension CalendarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .pard.blackBackground
        setNavigation()
        setupTableView()
        getSchedule(for: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.standardAppearance = previousAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = previousAppearance
        removeTabBarFAB(bool: false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        removeTabBarFAB(bool: true)
    }
    
    private func removeTabBarFAB(bool : Bool) {
        tabBarController?.setTabBarVisible(visible: !bool, animated: false)
        if let tabBarViewController = tabBarController as? HomeTabBarViewController {
            tabBarViewController.floatingButton.isHidden = bool
        }
    }
}

// - MARK: CalendarViewControllerd의 UITableViewDelegate, UITableViewDataSource
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
        label.font = .pardFont.head1
        label.text = section == 0 ? "다가오는 일정" : "지난 일정"
        headerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
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
                make.leading.equalToSuperview().offset(2)
                make.trailing.equalToSuperview().offset(-2)
                make.centerY.equalToSuperview()
            }
            return separatorView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }
        let event = indexPath.section == 0 ? upcomingEvents[indexPath.row] : pastEvents[indexPath.row]
        cell.selectionStyle = .none
        if indexPath.section == 0 && event.remaingDay == 0 {
            cell.categoryLabelConfigure(textColor: .pard.gray10, backGroundColor: .gradientColor(frame: cell.bounds))
        } else {
            cell.categoryLabelConfigure(textColor: .gradientColor(frame: cell.bounds), backGroundColor: .pard.blackCard)
        }
        cell.labelConfigure(with: event)
        return cell
    }
}
