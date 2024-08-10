//
//  HomeViewController.swift
//  PARD
//
//  Created by 김민섭 on 3/4/24.
//

import UIKit
import SnapKit
import Then

class HomeViewController: UIViewController {
    private var esterEggCount = 0
    private lazy var topView = HomeTopView(viewController: self).then { view in
        view.backgroundColor = .pard.blackCard
        view.layer.cornerRadius = 40.0
        view.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 40)
        view.layer.masksToBounds = true
    }
    
    private lazy var pardnerShipView = HomePardnerShipView(viewController: self).then {
        view in
        view.backgroundColor = .pard.blackCard
        view.layer.cornerRadius = 8.0
        view.layer.masksToBounds = true
    }
    
    private lazy var upcommingView = HomeUpcommingView(viewController : self).then {
        view in
        view.backgroundColor = .pard.blackCard
        view.layer.cornerRadius = 8.0
        view.layer.masksToBounds = true
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
  
    private func setNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .pard.blackCard
        appearance.shadowColor = .pard.blackCard
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        let homeButton = UIButton(type: .custom)
        homeButton.setImage(UIImage(named: "pardHomeLogo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        homeButton.showsTouchWhenHighlighted = false
        homeButton.setImage(homeButton.image(for: .normal), for: .highlighted)
        homeButton.addTarget(self, action: #selector(logoTapped), for: .touchUpInside)
        
        let homeBarButtonItem = UIBarButtonItem(customView: homeButton)
        let menuButton = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(menuButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        flexibleSpace.width = 10
        self.navigationItem.leftBarButtonItem = homeBarButtonItem
        self.navigationItem.rightBarButtonItems = [flexibleSpace,menuButton]
    }
    
    @objc private func logoTapped() {
        print("tapped")
        esterEggCount += 1
        if (esterEggCount == 10) {
            print("10 됐음 !! ")
            if let url = URL(string: "https://we-pard.notion.site/d5e1d460c05844c4b810816ff502d5db?pvs=4") {
                UIApplication.shared.open(url)
            }
        }
        
    }
    
    @objc private func menuButtonTapped() {
        let menuBar = HamburgerBarViewController()
        menuBar.modalPresentationStyle = .overCurrentContext
        menuBar.modalTransitionStyle = .crossDissolve
        menuBar.didDismiss = { [weak self] in
            self?.tabBarController?.tabBar.isHidden = false
        }
        if #available(iOS 15, *) {
            if let topViewController = UIApplication.shared.windows.first?.rootViewController {
                    topViewController.present(menuBar, animated: true)
            }
        }
    }
}

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pard.blackBackground
        setUpUI()
        setNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topView)
        contentView.addSubview(pardnerShipView)
        contentView.addSubview(upcommingView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(280)
        }
        
        pardnerShipView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(140)
        }
        
        upcommingView.snp.makeConstraints { make in
            make.top.equalTo(pardnerShipView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
}
