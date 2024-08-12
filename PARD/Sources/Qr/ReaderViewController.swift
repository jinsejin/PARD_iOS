//
//  ReaderViewController.swift
//  PARD
//
//  Created by 김하람 on 3/17/24.
//

import UIKit
import AVFoundation

class ReaderViewController: UIViewController {
    
    var readerView: QrReaderView!
    var titleLabel = UILabel()
    var outlineIcon = UIImageView()
    var cancelButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .clear
//        setAttribute()
//        setupLayouts()
//        readerView.start()
        view.backgroundColor = .clear

            // 카메라 뷰를 먼저 추가
            readerView = QrReaderView()
            readerView.delegate = self
            view.addSubview(readerView)
            
            // 다른 UI 요소 추가
            setAttribute()
            setupLayouts()
            readerView.start()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        readerView.start()
    }
    
    @objc func scanButtonAction(_ sender: UIButton) {
        readerView.start()
        sender.isSelected = readerView.isRunning
    }
    
    func setAttribute() {
        // QR 리더 뷰 초기화 및 추가
        readerView = QrReaderView()
        readerView.delegate = self
        view.addSubview(readerView)

        // 타이틀 라벨 설정 및 추가
        titleLabel.text = "테두리 안에 출석 QR코드를 인식해주세요."
        titleLabel.font = UIFont.pardFont.head2
        titleLabel.textColor = .pard.blackBackground
        view.addSubview(titleLabel)

        // 이미지 설정 및 추가
        outlineIcon.image = UIImage(named: "qr_background")
        outlineIcon.contentMode = .scaleAspectFit
        view.addSubview(outlineIcon)

        // 버튼 설정 및 추가
        cancelButton.setImage(UIImage(named: "cancelButton"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        view.addSubview(cancelButton)
    }

    func setupLayouts() {
        // readerView를 전체 화면으로 설정
        readerView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // 전체 화면을 차지하도록 설정
        }

        // 타이틀 라벨 레이아웃 설정
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(outlineIcon.snp.centerX)
            make.top.equalTo(232)
        }

        // 이미지 레이아웃 설정 (화면 중앙에 배치)
        outlineIcon.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // 버튼을 이미지 위에 배치
        cancelButton.snp.makeConstraints { make in
            make.centerX.equalTo(outlineIcon.snp.centerX)
            make.top.equalTo(626)
            make.width.height.equalTo(50)
        }
        
        // zPosition은 위에 쌓을 때의 순서. 즉, outlineIcon위에 cancelButton, titleLabel이 있음
        outlineIcon.layer.zPosition = 0
        cancelButton.layer.zPosition = 1
        titleLabel.layer.zPosition = 1
    }


//    func setupLayouts() {
//        //        readerView.snp.makeConstraints{ make in
//        //            make.centerX.equalToSuperview()
//        //            make.centerY.equalToSuperview()
//        //            make.width.height.equalTo(280)
//        //        }
//        readerView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        titleLabel.snp.makeConstraints { make in
//            make.bottom.equalTo(readerView.snp.top).offset(-28)
//            make.centerX.equalToSuperview()
//        }
//        outlineIcon.snp.makeConstraints{ make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
//        cancelButton.snp.makeConstraints{ make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(readerView.snp.bottom).offset(80)
//        }
//    }
    
    @objc func cancelButtonTapped() {
        print("button Tapped")
        
        self.navigationController?.popViewController(animated: true)
        //        if let tabBarController = self.tabBarController {
        //            tabBarController.selectedIndex = 0
        //        }
    }
}

extension ReaderViewController: ReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {
        
        var title = ""
        var message = ""
        switch status {
        case let .success(code):
            //            getValidQR(with: code)
            //            ModalBuilder()
            //                .add(title: "출석 체크")
            //                .add(image: "alreadyAttendance")
            //                .add(button: .confirm(title: "확인", action: {
            //                }))
            //                .show(on: self)
            guard let code = code else {
                break
            }
            getValidQR(with: code)
        case .fail:
            title = "에러"
            message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
        case let .stop(isButtonTap):
            if isButtonTap {
                title = "알림"
                message = "바코드 읽기를 멈추었습니다."
                // self.titleLabel.isSelected = readerView.isRunning
            } else {
                // self.titleLabel.isSelected = readerView.isRunning
                return
            }
        }
    }
}
