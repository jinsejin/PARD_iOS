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
