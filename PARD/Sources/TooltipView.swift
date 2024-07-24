//
//  TooltipView.swift
//  PARD
//
//  Created by 진세진 on 6/28/24.
//

import UIKit
import SnapKit
import Then

class TooltipBuilder {
    private var message: String = ""
    private var message2: String = ""
    private var message3 : String = ""
    private var superview: UIView?
    private var targetView: UIView?
    private var offset: CGFloat = 8

    func setMessage(_ message: String) -> TooltipBuilder {
        self.message = message
        return self
    }
    
    func setMessage2(_ message: String) -> TooltipBuilder {
        self.message2 = message
        return self
    }
    
    func setMessage3(_ message: String) -> TooltipBuilder {
        self.message3 = message
        return self
    }

    func setSuperview(_ superview: UIView) -> TooltipBuilder {
        self.superview = superview
        return self
    }

    func setTargetView(_ targetView: UIView) -> TooltipBuilder {
        self.targetView = targetView
        return self
    }

    func setOffset(_ offset: CGFloat) -> TooltipBuilder {
        self.offset = offset
        return self
    }

    func build() -> ToolTipView {
        guard let superview = superview, let targetView = targetView else {
            fatalError("Superview and TargetView must be set.")
        }

        let toolTipView = ToolTipView()
        toolTipView.show(in: superview, targetView: targetView, message: message, message2: message2, message3: message3 ,offset: offset)
        return toolTipView
    }
}


class ToolTipView : UIView {
    private var touchDismissView = UIView()
    
    private lazy var closeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .pard.gray30
        $0.addTarget(self, action: #selector(tappedCloesedButton), for: .touchUpInside)
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = .pard.blackCard
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GradientColor.gra.cgColor
    }
    
    private let messageLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .white
        $0.backgroundColor = .pard.blackCard
        $0.clipsToBounds = true
        $0.font = .pardFont.caption1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        addSubview(contentView)
        contentView.addSubview(messageLabel)
        contentView.addSubview(closeButton)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(12)
            make.leading.equalTo(contentView.snp.leading).offset(12)
            make.bottom.equalTo(contentView.snp.bottom).offset(-14)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(11)
            make.leading.equalTo(messageLabel.snp.trailing)
            make.trailing.equalTo(contentView.snp.trailing).offset(-12)
        }
    }

    func setMessage(_ message: String ,_ message2 : String, _ message3 : String) {
        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 3
        
        let attributedString = NSMutableAttributedString()
            .small(string: message, fontSize: 0, fontColor: .pard.white100)
            .blueHighlight(message2, font: .pardFont.caption2)
            .small(string: message3, fontSize: 0, fontColor: .pard.white100)
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        messageLabel.attributedText = attributedString
        messageLabel.textAlignment = .center
    }


    func show(in view: UIView, targetView: UIView, message: String, message2 : String, message3 : String, offset: CGFloat = 8) {
        setMessage(message, message2, message3)
        touchDismissView.backgroundColor = UIColor.clear
        touchDismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
        
        view.addSubview(touchDismissView)
        touchDismissView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        touchDismissView.addSubview(self)
        
        self.snp.makeConstraints { make in
            make.top.equalTo(targetView.snp.bottom).offset(offset)
            make.trailing.equalToSuperview().offset(-24
            )
            make.leading.equalToSuperview().offset(41)
            make.height.equalTo(60)
        }
        
        animateIn()
    }
    
    @objc func dismiss() {
        touchDismissView.removeFromSuperview()
    }

    @objc private func tappedCloesedButton() {
        touchDismissView.removeFromSuperview()
    }
    private func animateIn() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
}
