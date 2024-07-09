//
//  Font.swift
//  PARD
//
//  Created by 김하람 on 3/3/24.
//

import UIKit

extension UIFont {
    func withLineHeight(_ lineHeight: CGFloat) -> UIFont {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        return self
    }
    
    static let pardFont = PardAppFont()
    
    final class PardAppFont : NSObject {
        override init() { super.init() }
        // - MARK: Pretendard/Head
        let head1 = UIFont.systemFont(ofSize: 18, weight: .bold).withLineHeight(24)
        let head2 = UIFont.systemFont(ofSize: 16, weight: .bold).withLineHeight(20)
        
        // - MARK: Pretendard/Body
        let body1 = UIFont.systemFont(ofSize: 12, weight: .semibold).withLineHeight(14)
        let body2 = UIFont.systemFont(ofSize: 12, weight: .bold).withLineHeight(16)
        let body3 = UIFont.systemFont(ofSize: 12, weight: .medium).withLineHeight(18)
        let body4 = UIFont.systemFont(ofSize: 14, weight: .semibold).withLineHeight(18)
        let body5 = UIFont.systemFont(ofSize: 14, weight: .medium).withLineHeight(24)
        let body6 = UIFont.systemFont(ofSize: 16, weight: .semibold).withLineHeight(16)
        
        // - MARK: Pretendard/Caption
        let caption1 = UIFont.systemFont(ofSize: 14, weight: .medium).withLineHeight(20)
        let caption2 = UIFont.systemFont(ofSize: 12, weight: .semibold).withLineHeight(16)
    }
}


extension UIColor {
    static let gradientColro = UIColor(patternImage: gradientImage())
    private static func gradientImage() -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        gradientLayer.colors = [UIColor(red: 82/255, green: 98/255, blue: 245/255, alpha: 1).cgColor, UIColor(red: 123/255, green: 63/255, blue: 239/255, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
