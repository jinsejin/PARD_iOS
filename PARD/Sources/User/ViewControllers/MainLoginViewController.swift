//
//  MainLoginViewController.swift
//  PARD
//
//  Created by 김민섭 on 3/4/24.
//
import UIKit
import PARD_DesignSystem
import AuthenticationServices
import GoogleSignIn

class MainLoginViewController: UIViewController {
    let authorizationAppleIDButton = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
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
    
    private lazy var googleLoginBtton = BottomButton(title: "Sign in with Google", didTapHandler: tapGoogleLogin, font: .pardFont.head1).then {
        view.addSubview($0)
    }
    
    private lazy var googleLoginButton = UIButton().then {
        $0.setTitle("Sign in with Google", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 21, weight: .semibold)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 6
        view.addSubview($0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setUpUI()
        setAdditionalPropertyAttributes()
        requestNotificationPermission()
    }
    
    private func setUpUI() {
        view.addSubview(semiTitleLabel)
        view.addSubview(pardLabelImageView)
        view.addSubview(pardMainImageView)
        view.addSubview(authorizationAppleIDButton)
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
        googleLoginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pardMainImageView.snp.bottom).offset(90)
            make.height.equalTo(56)
            make.width.equalTo(327)
        }
        
        if let appleLogo = UIImage(named: "googleLogo") {
            googleLoginButton.setImage(appleLogo, for: .normal)
            googleLoginButton.tintColor = .white
            googleLoginButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            googleLoginButton.semanticContentAttribute = .forceLeftToRight
        } else {
            print("error")
        }
        
        googleLoginButton.addTarget(self, action: #selector(handleGoogleLogin), for: .touchUpInside)
        authorizationAppleIDButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(googleLoginButton.snp.bottom).offset(16)
            make.height.equalTo(56)
            make.width.equalTo(327)
        }
    }
    
    private func setAdditionalPropertyAttributes() {
        authorizationAppleIDButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButton(_:)), for: .touchUpInside)
    }
    
    @objc private func tapGoogleLogin() {
        let userInfoViewController = UserInfoPolicyViewController()
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    
    @objc private func handleAuthorizationAppleIDButton(_ sender: ASAuthorizationAppleIDButton) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.performRequests()
        controller.delegate = self
        controller.presentationContextProvider = self
    }
    
    private func requestNotificationPermission(){
        print("toggle pressed")
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
            if didAllow {
                print("Push: 권한 허용")
            } else {
                print("Push: 권한 거부")
            }
        })
    }
}
