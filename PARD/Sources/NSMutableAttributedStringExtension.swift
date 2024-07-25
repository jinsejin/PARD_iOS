//
//  NSMutableAttributedStringExtension.swift
//  PARD
//
//  Created by 진세진 on 3/13/24.
//

import UIKit
import PARD_DesignSystem

extension NSMutableAttributedString {
    func blueHighlight(_ value:String , font : UIFont)
    -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font: font,
            .foregroundColor: UIColor.pard.primaryBlue,
            .backgroundColor: UIColor.pard.blackCard
        ]
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func head2MutableAttribute(string: String, fontSize: CGFloat , fontColor : UIColor)
    -> NSMutableAttributedString {
        let font = UIFont.pardFont.head2
        let color = fontColor
        let attributes: [NSAttributedString.Key: Any] = [.font: font , .foregroundColor : color ]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
    
    func head1MutableAttribute(string: String, fontSize: CGFloat , fontColor : UIColor)
    -> NSMutableAttributedString {
        let font = UIFont.pardFont.head1
        let color = fontColor
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor : color ]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
    
    func regular(string: String, fontSize: CGFloat , fontColor : UIColor)
    -> NSMutableAttributedString {
        let font = UIFont.pardFont.body4
        let color = fontColor
        let attributes: [NSAttributedString.Key: Any] =
        [
            .font: font,
            .foregroundColor : color
        ]
       self.append(NSAttributedString(string: string, attributes: attributes))
       return self
    }
    
    func small(string: String, fontSize: CGFloat , fontColor : UIColor)
    -> NSMutableAttributedString {
        let font = UIFont.pardFont.caption2
        let color = fontColor
        let attributes: [NSAttributedString.Key: Any] =
        [
            .font: font,
            .foregroundColor : color
        ]
       self.append(NSAttributedString(string: string, attributes: attributes))
       return self
    }
}
