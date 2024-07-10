//
//  SplashViewController.swift
//  PARD
//
//  Created by 김하람 on 3/2/24.
//

import UIKit
import PARD_DesignSystem
import SnapKit
import Then

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.showMainViewController()
            }
        }
    
    func showMainViewController() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            navigationController?.pushViewController(HomeTabBarViewController(), animated: true)
        } else {
            navigationController?.pushViewController(MainLoginViewController(), animated: true)
        }
    }
    
    private let semiTitleLabel = UILabel().then {
        $0.font = UIFont.pardFont.body3
        $0.textColor = UIColor.pard.gray10
        $0.text =  "Pay it Forward를 실천하는 IT 협업 동아리"
        $0.textAlignment = .center
    }
    
    private let pardLabelImageView = UIImageView().then {
        $0.image = UIImage(named: "pardMainLogo")
    }
    
    private let pardMainImageView = UIImageView().then {
        $0.image = UIImage(named: "pardMainLogin")
    }
    
    private func setUpUI() {
        view.addSubview(semiTitleLabel)
        view.addSubview(pardLabelImageView)
        view.addSubview(pardMainImageView)
        semiTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(146)
        }
        
        pardLabelImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(semiTitleLabel.snp.bottom).offset(12)
        }
        pardMainImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    
    
    
    
    // MARK: - Pard Design System 사용 방법을 알려주기 위한 코드들 입니다.
    private lazy var titleLabel = UILabel().then{
        view.addSubview($0)
        $0.text = "< Test >"
        $0.font = UIFont.pardFont.head2
        $0.textColor = .pard.primaryPurple
    }
    
    private lazy var normalButton = NormalButton(title: "normal Button", didTapHandler: normalButtonTapped, font: .pardFont.body4).then{
        view.addSubview($0)
    }
    
    private lazy var changeNormalButton = NormalButton(title: "change normal button", didTapHandler: changeNormalEnable, font: .pardFont.body4).then{
        view.addSubview($0)
    }
    
    private lazy var bottomButton = BottomButton(title: "bottom Button", didTapHandler: bottomButtonTapped, font: .pardFont.body4).then{
        view.addSubview($0)
    }
    
    private lazy var changeBottomButton = BottomButton(title: "change bottom button", didTapHandler: changeBottomEnable, font: .pardFont.body4).then{
        view.addSubview($0)
    }
    
    private lazy var textfieldComponent = PardTextField(placeHolder: "test").then{
        view.addSubview($0)
    }
    
    private func setUi() {
        titleLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        normalButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        changeNormalButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(normalButton.snp.bottom).offset(30)
            make.height.equalTo(48)
        }
        
        bottomButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(changeNormalButton.snp.bottom).offset(30)
        }
        
        changeBottomButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(bottomButton.snp.bottom).offset(30)
            make.height.equalTo(48)
        }
        
        textfieldComponent.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(changeBottomButton.snp.bottom).offset(30)
            make.height.equalTo(48)
        }
        
        let rankingButton = UIButton().then {
            $0.setTitle("Go to Ranking", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .pard.primaryPurple
            $0.addTarget(self, action: #selector(rankingButtonTapped), for: .touchUpInside)
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(textfieldComponent.snp.bottom).offset(30)
                make.width.equalTo(200)
                make.height.equalTo(50)
            }
        }
    }
    
    @objc func normalButtonTapped() {
        print("🌱 normal tapped !")
        print("change normal !")
//        showCancellablePopup(title: "test", body: "body hello")
    }
    
    @objc func changeNormalEnable() {
        normalButton.isEnabled.toggle()
    }
    
    @objc func bottomButtonTapped() {
        print("🌱 bottom tapped !")
    }
    
    @objc func changeBottomEnable() {
        bottomButton.isEnabled.toggle()
        print("change Bottom !")
    }
    
    @objc func rankingButtonTapped() {
        let rankingVC = MyScoreViewController()
        let navController = UINavigationController(rootViewController: rankingVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
}
