//
//  ViewController.swift
//  PARD
//
//  Created by 김하람 on 3/2/24.
//

import UIKit
import PARD_DesignSystem
import SnapKit
import Then

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pard.errorRed
        setUi()
    }
    
//    private func showCancellablePopup(title: String, body: String, cancelHandler: (() -> Void)? = nil) {
//        ModalBuilder()
//            .add(title: title)
//            .add(body: body)
//            .add(
//                button: .cancellable(
//                    cancelButtonTitle: "예",
//                    confirmButtonTitle: "아니요",
//                    cancelButtonAction: cancelHandler,
//                    confirmButtonAction: nil
//                )
//            )
//            .show(on: self)
//    }
    
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
