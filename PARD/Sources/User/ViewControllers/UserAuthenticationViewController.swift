//
//  UserAuthenticationViewController.swift
//  PARD
//
//  Created by 김민섭 on 3/4/24.
//

import UIKit
import PARD_DesignSystem

class UserAuthenticationViewController: UIViewController, UITextFieldDelegate {
    let globalLeading = 24
    let notiView = UIView()
    var notiTextStackView = UIStackView()
    let phoneNumberTextField = PardTextField(placeHolder: "전화번호를 입력해주세요")
    let authCodeTextField = PardTextField(placeHolder: "인증번호(6자리)를 입력해주세요.")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pard.blackBackground
        setNavigation()
        notiContainer()
        setPhonNumber()
        setAuthCode()
        setBottomButtons()
    }
    
    private func setNavigation() {
        self.navigationItem.title = "PARD 회원인증"
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [
                .font:  UIFont.pardFont.head2,
                .foregroundColor: UIColor.white
            ]
        }
        let backButton = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    private func notiContainer() {
        notiView.then {
            view.addSubview($0)
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.backgroundColor = .pard.blackCard
            $0.layer.borderColor = UIColor.pard.gray30.cgColor
            $0.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
                make.centerX.equalToSuperview()
                make.height.equalTo(68)
                make.leading.trailing.equalToSuperview().inset(globalLeading)
            }
        }

        let notiText1 = UILabel().then {
            notiView.addSubview($0)
            $0.text = "PARD 회원임을 인증하기 위해"
            $0.font =  UIFont.pardFont.body4
            $0.textColor = .pard.gray30
            $0.snp.makeConstraints { make in
                make.top.equalTo(notiView.snp.top).offset(16)
                make.centerX.equalToSuperview()
            }
        }
        
        let notiColorText = UILabel().then {
            $0.text = "PARD 등록에 사용한 전화번호"
            $0.font = .pardFont.body4
            $0.textColor = .gradientColor.gra
        }
        let notiText2 = UILabel().then {
            $0.text = "를 입력해주세요."
            $0.font = .pardFont.body4
            $0.textColor = .pard.gray30
        }
        notiTextStackView.then{
            notiView.addSubview($0)
            $0.addArrangedSubview(notiColorText)
            $0.addArrangedSubview(notiText2)
            $0.axis = .horizontal
            $0.spacing = 0
            $0.snp.makeConstraints{ make in
                make.top.equalTo(notiText1.snp.bottom).offset(3)
                make.centerX.equalToSuperview()
            }
        }
    }
    
    private func setPhonNumber() {
        let phoneNumberLabel = UILabel().then {
            view.addSubview($0)
            $0.text = "인증번호"
            $0.textColor = .white
            $0.font =  UIFont.pardFont.head2
            $0.snp.makeConstraints{ make in
                make.top.equalTo(notiView.snp.bottom).offset(48)
                make.leading.equalTo(globalLeading)
            }
        }
        view.addSubview(phoneNumberLabel)
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints{ make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(8)
            make.leading.equalTo(globalLeading)
            make.height.equalTo(48)
            make.width.equalTo(173)
        }
        
        let getPhoneCodeButton = NormalButton(title: "인증번호 받기", didTapHandler: getPhoneCodeButtonTapped, font: .pardFont.body4).then{
            view.addSubview($0)
        }
        getPhoneCodeButton.snp.makeConstraints{ make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(8)
            make.trailing.equalTo(-globalLeading)
            make.height.equalTo(48)
            make.width.equalTo(108)
        }
    }
    
    private func setAuthCode() {
        let authCodeLabel = UILabel().then {
            view.addSubview($0)
            $0.text = "인증번호"
            $0.textColor = .white
            $0.font =  UIFont.pardFont.head2
            $0.snp.makeConstraints{ make in
                make.top.equalTo(phoneNumberTextField.snp.bottom).offset(48)
                make.leading.equalTo(globalLeading)
            }
        }
        view.addSubview(authCodeLabel)
        view.addSubview(authCodeTextField)
        authCodeTextField.snp.makeConstraints{ make in
            make.top.equalTo(authCodeLabel.snp.bottom).offset(8)
            make.leading.equalTo(globalLeading)
            make.height.equalTo(48)
            make.width.equalTo(211)
        }
        
        var checkPhoneCodeButton = NormalButton(title: "인증번호 확인", didTapHandler: getAuthCodeButtonTapped, font: .pardFont.body4).then{
            view.addSubview($0)
        }
        checkPhoneCodeButton.snp.makeConstraints{ make in
            make.top.equalTo(authCodeLabel.snp.bottom).offset(8)
            make.trailing.equalTo(-globalLeading)
            make.height.equalTo(48)
            make.width.equalTo(108)
        }
    }
    
    private func setBottomButtons() {
        let failAuthButton = UIButton()
        view.addSubview(failAuthButton)
        failAuthButton.then{
            $0.setTitle("회원 인증에 실패하셨나요?", for: .normal)
            $0.setTitleColor(.pard.primaryBlue, for: .normal)
            $0.titleLabel?.font =  UIFont.pardFont.caption1
            $0.addTarget(self, action: #selector(failAuthButtonTapped), for: .touchUpInside)
            $0.titleLabel?.setUnderline(range: NSRange(location: 0, length: $0.currentTitle?.count ?? 0))
            $0.snp.makeConstraints{ make in
                make.bottom.equalTo(view.snp.bottom).offset(-44)
                make.centerX.equalToSuperview()
            }
        }
        
        let pardAuthButton = BottomButton(title: "PARD 회원 인증하기", didTapHandler: pardAuthButtonTapped, font: .pardFont.head1)
        view.addSubview(pardAuthButton)
        pardAuthButton.snp.makeConstraints{ make in
            make.bottom.equalTo(failAuthButton.snp.top).offset(-16)
            make.leading.equalTo(globalLeading)
            make.trailing.equalTo(-globalLeading)
            make.height.equalTo(56)
        }
    }
    
    @objc func backButtonTapped(){
        print("go to back !!!")
    }
    
    @objc func getPhoneCodeButtonTapped(){
        print("I will send phone code !")
    }
    
    @objc func getAuthCodeButtonTapped(){
        print("getAuthCodeButtonTapped")
    }
    
    @objc func pardAuthButtonTapped(){
        print("pardAuthButtonTapped")
    }
    
    @objc func failAuthButtonTapped(){
        print("failAuthButtonTapped")
    }
}
