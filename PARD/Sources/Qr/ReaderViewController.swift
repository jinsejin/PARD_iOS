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
        view.backgroundColor = .clear
        readerView = QrReaderView()
        readerView.delegate = self
        view.addSubview(readerView)
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
        
        outlineIcon.image = UIImage(named: "qr_background")
        outlineIcon.contentMode = .scaleAspectFit
        view.addSubview(outlineIcon)
        
        cancelButton.setImage(UIImage(named: "cancelButton"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        view.addSubview(cancelButton)
    }
    
    func setupLayouts() {
        readerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(outlineIcon.snp.centerX)
            make.top.equalTo(232)
        }
        
        outlineIcon.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
    
    @objc func cancelButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ReaderViewController: ReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {
        
        switch status {
        case let .success(code):
            guard let code = code else {
                break
            }
            getValidQR(with: code)
        case .fail: break
        case let .stop(isButtonTap): break
        }
    }
}
