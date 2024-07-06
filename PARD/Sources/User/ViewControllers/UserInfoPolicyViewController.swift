//
//  UserInfoPolicyViewController.swift
//  PARD
//
//  Created by 김민섭 on 3/4/24.
//

import UIKit
import PARD_DesignSystem
import Then
import SnapKit

// - MARK: 개인 정보 ViewController
class UserInfoPolicyViewController: UIViewController {
    private var isTapAgreeButton : Bool = false {
        didSet {
            if isTapAgreeButton {
                agreeButton.tintColor = UIColor.pard.primaryBlue
                agreeButton.setTitleColor(UIColor.pard.primaryBlue, for: .normal)
            } else {
                agreeButton.tintColor = UIColor.pard.gray30
                agreeButton.setTitleColor(UIColor.pard.gray10, for: .normal)
            }
        }
    }
    
    private let serviceInfoLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.backgroundColor = UIColor.pard.blackCard
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.pard.gray30.cgColor
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    
    private let backButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "chevron.backward")
        $0.tintColor = .white
    }
    
    private lazy var agreeButton = UIButton().then {
        let intervalSpacing = 4.0
        let halfIntervalSpacing = intervalSpacing / 2
        $0.setTitle("서비스 이용약관 전체 동의", for: .normal)
        $0.setTitleColor(UIColor.pard.white100, for: .normal)
        $0.setImage(
            UIImage(systemName: "checkmark.square.fill")?
            .withTintColor(UIColor.pard.gray30),
            for: .normal
        )
        $0.tintColor = UIColor.pard.gray30
        $0.semanticContentAttribute = .forceLeftToRight
        $0.contentEdgeInsets = .init(top: 0, left: 4.0 / 2, bottom: 0, right: 4.0)
        $0.imageEdgeInsets = .init(top: 0, left: -halfIntervalSpacing, bottom: 0, right: halfIntervalSpacing)
        $0.titleEdgeInsets = .init(top: 0, left: halfIntervalSpacing, bottom: 0, right: -halfIntervalSpacing)
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(tapAgreeButton), for: .touchUpInside)
    }
    
    private let agreeView = UIView().then {
        $0.backgroundColor = UIColor.pard.blackCard
        $0.layer.borderColor = UIColor.pard.gray30.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.alignment = .leading
    }
    

    private lazy var firstCheckAgreeButton = UIButton().then {
        configureButton(
            $0,
            title: "개인정보 수집및 이용동의(필수)",
            image: UIImage(systemName: "checkmark"),
            target: self ,
            action: #selector(firstTapCheckAgree)
        )
    }
    
    private lazy var nextBottomButton = BottomButton(title: "다음", didTapHandler: changeBottomEnable, font: .pardFont.head1).then {
        view.addSubview($0)
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor.pard.gray30
    }
    
    private lazy var secondCheckAgreeButton = UIButton().then {
        configureButton(
            $0,
            title: "서비스 이용 약관(필수)",
            image: UIImage(systemName: "checkmark"),
            target: self ,
            action: #selector(secondTapCheckAgree)
        )
    }
    
    private lazy var checkImgaeButton = UIButton().then {
        $0.setTitle("서비스 이용약관 전체 동의", for: .normal)
        $0.setTitleColor(UIColor.pard.white100, for: .normal)
        $0.setImage(
            UIImage(systemName: "checkmark.square.fill")?
            .withTintColor(UIColor.pard.gray30),
            for: .normal
        )
        $0.semanticContentAttribute = .forceLeftToRight
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(tapAgreeButton), for: .touchUpInside)
    }
    
    private func setUpNavigaiton() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.title = "이용약관"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        
        backButton.target = self
        backButton.action = #selector(tapBackButton)
        navigationItem.leftBarButtonItem = backButton
        
    }
    
    private func setUpserviceInfoLabelText() {
        serviceInfoLabel.attributedText = NSMutableAttributedString()
            .regular(string: "서비스 이용 및 이용을 위해 \n", fontSize: 13, fontColor: UIColor.pard.gray10)
            .blueHighlight("서비스 이용약관", font: .pardFont.body4)
            .regular(string: "에 동의하세요.", fontSize: 13, fontColor: UIColor.pard.gray10)
    }
    
    private func configureButton(_ button: UIButton, title: String, image: UIImage?, target: Any?, action: Selector) {
        let intervalSpacing = 8.0
        let halfIntervalSpacing = intervalSpacing / 2
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.pardFont.caption1
        button.setUnderline()
        button.setTitleColor(UIColor.pard.gray10, for: .normal)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.pard.gray30
        button.semanticContentAttribute = .forceLeftToRight
        button.backgroundColor = .clear
        button.addTarget(target, action: action, for: .touchUpInside)
        button.contentEdgeInsets = .init(top: 0, left: 8.0 / 2, bottom: 0, right: 8.0)
        button.imageEdgeInsets = .init(top: 0, left: -halfIntervalSpacing, bottom: 0, right: halfIntervalSpacing)
        button.titleEdgeInsets = .init(top: 0, left: halfIntervalSpacing, bottom: 0, right: -halfIntervalSpacing)
    }
    
    @objc private func tapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tapAgreeButton() {
        isTapAgreeButton.toggle()
    }
    
    @objc private func firstTapCheckAgree() {
        
    }
    
    @objc private func secondTapCheckAgree() {
        
    }
    
    @objc private func changeBottomEnable() {
        if isTapAgreeButton {
            let viewController = HomeTabBarViewController()
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            showToast(message: "서비스 이용약관에 동의해주세요.", font: UIFont.pardFont.body4)
        }
    }
    
    func showToast(message : String, font: UIFont) {
        guard let view = self.view else { return } // Ensure the view is available
            let toastBar = ToastBarBuilder()
                .setMessage("서비스 이용약관에 동의해주세요.")
                .setSuperview(view) // Set the superview
                .setWidth(343)
                .setHeight(52)
                .build()
            
            // Add the tooltip to the view
            toastBar.setUpToastBarUIInSuperView()
    }
}

// - MARK: setUp UI
extension UserInfoPolicyViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        view.backgroundColor = UIColor.pard.blackBackground
        setUpUI()
        getUsersMe()
    }
    
    private func setUpUI() {
        view.addSubview(serviceInfoLabel)
        view.addSubview(agreeButton)
        view.addSubview(agreeView)
        agreeView.addSubview(stackView)
        view.addSubview(nextBottomButton)
        stackView.addArrangedSubview(firstCheckAgreeButton)
        stackView.addArrangedSubview(secondCheckAgreeButton)
        
        setUpNavigaiton()
        setUpserviceInfoLabelText()
        
        serviceInfoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(68)
            make.width.equalTo(327)
        }
        agreeButton.snp.makeConstraints { make in
            make.top.equalTo(serviceInfoLabel.snp.bottom).offset(48)
            make.leading.equalTo(serviceInfoLabel.snp.leading)
        }
        agreeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(agreeButton.snp.bottom).offset(10)
            make.height.equalTo(104)
            make.width.equalTo(327)
        }
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        nextBottomButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalTo(327)
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-80)
        }
    }
}
