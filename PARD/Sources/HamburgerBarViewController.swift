//
//  HamburgerBarViewController.swift
//  PARD
//
//  Created by 진세진 on 3/5/24.
//

import UIKit

// - MARK: HamburgerBar
class HamburgerBarViewController: UIViewController {
    private let dimmedView = UIView().then { dimmedView in
        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    var didDismiss: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHamburgerBarUI()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setUpHamburgerBarUI() {
        let hamburgerBar = HamburgerBarView(superview: self.view)

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapedDimmedView)
        )
        
        dimmedView.addGestureRecognizer(tapGesture)
        view.backgroundColor = .clear
        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(hamburgerBar.snp.leading)
            make.bottom.equalToSuperview()
        }
        
    }
    
    @objc private func didTapedDimmedView() {
        self.dismiss(animated: true) {
            self.didDismiss?()
        }
    }
}
