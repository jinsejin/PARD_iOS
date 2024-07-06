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
        view.backgroundColor = UIColor(red: 133/255.0, green: 133/255.0, blue: 133/255.0, alpha: 0.6)
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
        readerView = QrReaderView()
        readerView.delegate = self
        view.addSubview(readerView)
        titleLabel.text = "테두리 안에 출석 QR코드를 인식해주세요."
        titleLabel.font = UIFont.pardFont.head2
        titleLabel.textColor = .pard.blackBackground
        view.addSubview(titleLabel)
        outlineIcon.image = UIImage(named: "qr_outline")
        view.addSubview(outlineIcon)
        cancelButton.setImage(UIImage(named: "cancelButton"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        view.addSubview(cancelButton)
    }
    
    func setupLayouts() {
        readerView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(280)
        }
        titleLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(readerView.snp.top).offset(-28)
            make.centerX.equalToSuperview()
        }
        outlineIcon.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        cancelButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(readerView.snp.bottom).offset(80)
        }
    }
    
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
            guard let code = code else {
                title = "에러"
                message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
                break
            }
            title = "알림"
            message = "인식성공\n\(code)"
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
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
