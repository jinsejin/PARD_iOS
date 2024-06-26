//
//  PardTextField.swift
//  PARD
//
//  Created by 김하람 on 3/7/24.
import UIKit

public final class PardTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public convenience init(
        placeHolder: String
    ) {
        self.init(frame: .zero)
        self.backgroundColor = .pard.blackCard
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.pard.gray10.cgColor
        self.placeholder = placeHolder
        self.textColor = .white
        self.setPlaceholderColor(.pard.gray30)
        self.font = .pardFont.body5
        self.layer.borderColor = UIColor.pard.gray10.cgColor
        self.textAlignment = .left
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftView = leftPadding
        self.leftViewMode = UITextField.ViewMode.always

        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width + 10, height: self.frame.height))
        self.rightView = rightPadding
        self.rightViewMode = UITextField.ViewMode.always
    }
}

public extension UITextField {
    func setPlaceholderColor(_ placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
}
