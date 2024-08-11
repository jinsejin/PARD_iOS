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
    private var isTapAllAgreeButton : Bool = false {
        didSet {
            if isTapAllAgreeButton {
                configureForSelectedAgreeButton()
            } else {
                configureForDeselectedAgreeButton()
            }
        }
    }
    
    private var isTapPersonalAgreeButton : Bool = false {
        didSet {
            if isTapPersonalAgreeButton {
                setForSelectedPersonalAgreeButton()
            } else {
                setForNotSelectedPersonalAgreeButton()
            }
        }
    }
    
    private var isTapServiceAgreeButton : Bool = false {
        didSet {
            if isTapServiceAgreeButton {
                setForSelectedServiceAgreeButton()
            } else {
                setForNotSelectedServiceAgreeButton()
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
  
    private let backButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0) // 왼쪽 여백을 10으로 설정
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    
    private lazy var agreeButton = UIButton().then {
        let intervalSpacing = 4.0
        let halfIntervalSpacing = intervalSpacing / 2
        $0.setTitle("서비스 이용약관 전체 동의", for: .normal)
        $0.setTitleColor(UIColor.pard.white100, for: .normal)
        $0.setImage(
            UIImage(named: "checkBox"),
            for: .normal
        )
        $0.tintColor = UIColor.pard.gray30
        $0.semanticContentAttribute = .forceLeftToRight
        $0.contentEdgeInsets = .init(top: 0, left: 4.0 / 2, bottom: 0, right: 4.0)
        $0.imageEdgeInsets = .init(top: 0, left: -halfIntervalSpacing, bottom: 0, right: halfIntervalSpacing)
        $0.titleEdgeInsets = .init(top: 0, left: halfIntervalSpacing, bottom: 0, right: -halfIntervalSpacing)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = .pardFont.head2
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
            title: "개인정보 수집 및 이용동의 (필수)",
            image: UIImage(named: "checkMark"),
            target: self ,
            action: #selector(firstTapCheckAgree)
        )
    }
    
    private lazy var nextBottomButton = NextBottomButton(title: "다음", didTapHandler: changeBottomEnable, font: .pardFont.head1).then {
        view.addSubview($0)
        $0.isEnabled = false
    }
    
    private lazy var secondCheckAgreeButton = UIButton().then {
        configureButton(
            $0,
            title: "서비스 이용약관(필수)",
            image: UIImage(named: "checkMark"),
            target: self ,
            action: #selector(secondTapCheckAgree)
        )
    }
    
    private lazy var checkImgaeButton = UIButton().then {
        $0.setTitle("서비스 이용약관 전체 동의", for: .normal)
        $0.setTitleColor(UIColor.pard.white100, for: .normal)
        $0.setImage(
            UIImage(named: "checkBox_fill"), for: .normal
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
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.pardFont.head2,
            .foregroundColor: UIColor.pard.white100
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        backButton.target = self
        backButton.action = #selector(tapBackButton)
        navigationItem.leftBarButtonItem = backButton
        
    }
    
    private func setUpserviceInfoLabelText() {
        serviceInfoLabel.attributedText = NSMutableAttributedString()
            .regular(string: "서비스 가입 및 이용을 위해 \n", fontSize: 14, fontColor: .pard.gray30)
            .blueHighlight("서비스 이용약관", font: .pardFont.body4)
            .regular(string: "에 동의해주세요.", fontSize: 14, fontColor: .pard.gray30)
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
        isTapAllAgreeButton.toggle()
        
        if isTapPersonalAgreeButton == true && isTapServiceAgreeButton == false {
            isTapServiceAgreeButton.toggle()
        } else if isTapServiceAgreeButton == true && isTapPersonalAgreeButton == false {
            isTapPersonalAgreeButton.toggle()
        } else {
            isTapPersonalAgreeButton.toggle()
            isTapServiceAgreeButton.toggle()
        }
    }
    
    @objc private func firstTapCheckAgree() {
        isTapPersonalAgreeButton.toggle()
        if isTapPersonalAgreeButton {
            guard let url = URL(string: "https://www.notion.so/we-pard/Pard-APP-fc37c472e47941d3958765587b57e21f?pvs=4") else {
               return
            }

            if UIApplication.shared.canOpenURL(url) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        if isTapServiceAgreeButton && isTapPersonalAgreeButton {
            isTapAllAgreeButton = true
        } else {
            isTapAllAgreeButton = false
        }
    }
    
    @objc private func secondTapCheckAgree() {
        isTapServiceAgreeButton.toggle()
        if isTapServiceAgreeButton {
            guard let url = URL(string: "https://www.notion.so/we-pard/Pard-APP-74f6a4d8383d4e4993f28e9463b0d9b0?pvs=4") else {
               return
            }

            if UIApplication.shared.canOpenURL(url) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        if isTapServiceAgreeButton && isTapPersonalAgreeButton {
            isTapAllAgreeButton = true
        } else {
            isTapAllAgreeButton = false
        }
    }
    
    @objc private func changeBottomEnable() {
        if isTapAllAgreeButton {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            let viewController = HomeTabBarViewController()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        } else {
            showToast(message: "서비스 이용약관에 동의해주세요.", font: UIFont.pardFont.body4)
        }
    }
    
    func showToast(message : String, font: UIFont) {
        guard let view = self.view else { return }
        let toastBar = ToastBarBuilder()
            .setMessage("서비스 이용약관에 동의해주세요.")
            .setSuperview(view)
            .setWidth(343)
            .setHeight(52)
            .build()
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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            getUsersMe()
            getRankMe { rank in
                if let rank = rank {
                    DispatchQueue.main.async {
                        print("Success: getRankMe!!")
                        UserDefaults.standard.setValue(rank.partRanking, forKey: "partRanking")
                        UserDefaults.standard.setValue(rank.totalRanking, forKey: "totalRanking")
                    }
                }
                
            }
        }
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

// MARK: AgrreeButton State Functions
extension UserInfoPolicyViewController {
    // - All AgreeButton State -
    private func configureForSelectedAgreeButton() {
        agreeButton.setTitleColor(UIColor.pard.primaryBlue, for: .normal)
        agreeButton.setImage(UIImage(systemName: "checkmark.square.fill")?.withTintColor(UIColor.pard.primaryBlue), for: .normal)
        agreeButton.tintColor = UIColor.pard.primaryBlue
        nextBottomButton.isEnabled = true
      
    }
    
    private func configureForDeselectedAgreeButton() {
        agreeButton.setTitleColor(UIColor.pard.white100, for: .normal)
        agreeButton.setImage(UIImage(systemName: "checkmark.square.fill")?.withTintColor(UIColor.pard.gray30), for: .normal)
        agreeButton.tintColor = UIColor.pard.gray30
        nextBottomButton.isEnabled = false
    }
    
    // - ServiceAgreeButton State -
    private func setForSelectedPersonalAgreeButton() {
        
        firstCheckAgreeButton.setTitleColor(UIColor.pard.primaryBlue, for: .normal)
        firstCheckAgreeButton.setImage(UIImage(named: "checkMark")?.withTintColor(UIColor.pard.primaryBlue), for: .normal)
    }
    
    private func setForNotSelectedPersonalAgreeButton() {
        firstCheckAgreeButton.setTitleColor(UIColor.pard.gray10, for: .normal)
        firstCheckAgreeButton.setImage(UIImage(named: "checkMark")?.withTintColor(UIColor.pard.gray10), for: .normal)
    }
    
    // - ServiceAgreeButton state -
    private func setForSelectedServiceAgreeButton() {
        
        secondCheckAgreeButton.setTitleColor(UIColor.pard.primaryBlue, for: .normal)
        secondCheckAgreeButton.setImage(UIImage(named: "checkMark")?.withTintColor(UIColor.pard.primaryBlue), for: .normal)
    }
    
    private func setForNotSelectedServiceAgreeButton() {
        secondCheckAgreeButton.setTitleColor(UIColor.pard.gray10, for: .normal)
        secondCheckAgreeButton.setImage(UIImage(named: "checkMark")?.withTintColor(UIColor.pard.gray10), for: .normal)
    }
}
