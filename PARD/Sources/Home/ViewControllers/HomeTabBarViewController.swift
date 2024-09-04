//
//  HomeTableViewController.swift
//  PARD
//
//  Created by 김민섭 on 3/4/24.
//
import UIKit

class HomeTabBarViewController: UITabBarController {
    let floatingButton = UIButton().then { button in
        button.isHidden = false
        button.layer.cornerRadius = 40
        button.layer.shadowColor = UIColor.pard.white100.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 3
        button.backgroundColor = .gradientColor.gra
        button.setImage(UIImage(named: "scan")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pard.blackBackground
        self.navigationController?.navigationBar.isHidden = false
        setUpTabbarView()
        setUpTabBarLayout()
        setUpTabBarAppearance()
        setUpTabBarItems()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpTabbarView() {
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "home")?.withRenderingMode(.automatic), tag: 0)
        homeViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: -12, right: 0)
        homeViewController.tabBarItem.selectedImage = UIImage(named: "home")?.withTintColor(.pard.primaryBlue)
        homeViewController.tabBarController?.tabBar.itemPositioning = .centered
        
        let myPageViewController = MyPageViewController()
        myPageViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "person")?.withTintColor(.pard.gray30), tag: 1)
        myPageViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: -12, right: 0)
        myPageViewController.tabBarItem.selectedImage = UIImage(named: "person")?.withTintColor(.pard.primaryBlue)
        
        let navigationHome = UINavigationController(rootViewController: homeViewController)
        let navigationMypage = UINavigationController(rootViewController: myPageViewController)
        setViewControllers([navigationHome, navigationMypage], animated: false)
        
        let tabBarAppearance = UITabBarAppearance()
        configureTabBarAppearance(tabBarAppearance: tabBarAppearance)

        tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        
        let isCompactDevice = isCompactDeviceWithHomeButton()
        for item in tabBar.items ?? [] {
            if !isCompactDevice {
                item.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -20, right: 0)
            } else {
                self.tabBar.itemPositioning = .centered
            }
        }
        setUpfloatingQRButton()
    }
    
    private func isCompactDeviceWithHomeButton() -> Bool {
        let smallDeviceScreenSizes: [CGSize] = [
            CGSize(width: 320, height: 568), // iPhone SE (1st gen)
            CGSize(width: 375, height: 667), // iPhone SE (2nd gen)
            CGSize(width: 414, height: 736)  // iPhone 6,7,8
        ]
        let screenSize = UIScreen.main.bounds.size
        return smallDeviceScreenSizes.contains { $0 == screenSize || CGSize(width: $0.height, height: $0.width) == screenSize }
    }
    
    private func configureTabBarAppearance(tabBarAppearance: UITabBarAppearance) {
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        itemAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)

        tabBarAppearance.stackedLayoutAppearance = itemAppearance
    }
    
    private func setUpfloatingQRButton() {
        self.view.addSubview(floatingButton)
        let isCompactDevice = isCompactDeviceWithHomeButton()
        if !isCompactDevice {
            floatingButton.snp.makeConstraints { make in
                make.width.height.equalTo(80)
                make.centerX.equalToSuperview()
                make.bottom.equalTo(view.snp.bottom).offset(-40)
            }
        } else {
            floatingButton.snp.makeConstraints { make in
                make.width.height.equalTo(80)
                make.centerX.equalToSuperview()
                make.bottom.equalTo(view.snp.bottom).offset(-10)
            }
        }
        floatingButton.addTarget(self, action: #selector(floatingQRButtonTapped), for: .touchUpInside)
    }
    
    @objc private func floatingQRButtonTapped() {
        print("tapped qr code page")
        let QRVC = ReaderViewController()
        navigationController?.pushViewController(QRVC, animated: false)
    }
    
    private func setUpTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .pard.blackCard
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = .pard.gray30
        itemAppearance.selected.iconColor = .pard.primaryBlue
        
        if #available(iOS 15.0, *) {
            appearance.stackedLayoutAppearance = itemAppearance
            appearance.inlineLayoutAppearance = itemAppearance
            appearance.compactInlineLayoutAppearance = itemAppearance
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        } else {
            appearance.stackedLayoutAppearance = itemAppearance
            appearance.inlineLayoutAppearance = itemAppearance
            appearance.compactInlineLayoutAppearance = itemAppearance
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.backgroundColor = .pard.blackCard
        tabBar.tintColor = .gradientColor.gra
        tabBar.unselectedItemTintColor = .pard.gray30
    }
    
    private func setUpTabBarLayout() {
        tabBar.layer.cornerRadius = 20
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.itemWidth = 18
        tabBar.itemPositioning = .centered
    }
    
    private func setUpTabBarItems() {
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        self.title = nil
    }
}

extension UITabBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        let isCompactDevice = isCompactDeviceWithHomeButton()
        var ratio: CGFloat = 0.073
        if !isCompactDevice {
             ratio = 0.088
        }
        sizeThatFits.height = UIScreen.main.bounds.height * ratio
        return sizeThatFits
    }
    
    private func isCompactDeviceWithHomeButton() -> Bool {
        let smallDeviceScreenSizes: [CGSize] = [
            CGSize(width: 320, height: 568), // iPhone SE (1st gen)
            CGSize(width: 375, height: 667), // iPhone SE (2nd gen)
            CGSize(width: 414, height: 736)  // iPhone 6,7,8
        ]
        let screenSize = UIScreen.main.bounds.size
        return smallDeviceScreenSizes.contains { $0 == screenSize || CGSize(width: $0.height, height: $0.width) == screenSize }
    }
}

extension HomeTabBarViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let tabBarItemIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            if tabBarItemIndex == 0 {
                floatingButton.isEnabled = true
                floatingButton.backgroundColor = .gradientColor(frame: floatingButton.bounds)
            } else {
                floatingButton.isEnabled = false
                floatingButton.backgroundColor = .pard.gray30
            }
        }
    }
}
