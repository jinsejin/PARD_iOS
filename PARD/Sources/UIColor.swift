//
//  UIColor.swift
//  PARD
//
//  Created by 진세진 on 7/9/24.
//
import UIKit


extension UIColor {
    static let gradientColor = GradientColor()
    
    final class GradientColor : NSObject {
        override init() { super.init()}
        static let gra = UIColor(patternImage: gradientImage())
        
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
    
}
