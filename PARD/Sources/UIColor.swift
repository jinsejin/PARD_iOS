//
//  UIColor.swift
//  PARD
//
//  Created by 진세진 on 7/9/24.
//
import UIKit


extension UIColor {
    static let gradientColor = GradientColor()

    final class GradientColor: NSObject {
        override init() { super.init() }

        let gra = UIColor(patternImage: gradientImage())

        private static func gradientImage() -> UIImage {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
            gradientLayer.colors = [UIColor(red: 82/255, green: 98/255, blue: 245/255, alpha: 1).cgColor, UIColor(red: 123/255, green: 63/255, blue: 239/255, alpha: 1).cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
            
            UIGraphicsBeginImageContext(gradientLayer.bounds.size)
            gradientLayer.render(in: UIGraphicsGetCurrentContext() ?? UIGraphicsBeginImageContext(CAGradientLayer().bounds.size) as! CGContext)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image ?? UIImage()
        }
    }
    
    static func gradientColor(frame: CGRect) -> UIColor {
        // Define the gradient colors
        let startColor = UIColor(red: 82/255.0, green: 98/255.0, blue: 245/255.0, alpha: 1.0).cgColor
        let endColor = UIColor(red: 123/255.0, green: 63/255.0, blue: 239/255.0, alpha: 1.0).cgColor

        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [startColor, endColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//        gradientLayer.locations = [0.3, 0.6]

       
        // Create a UIImage from the gradient layer
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return UIColor.clear }
        gradientLayer.render(in: context)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // Return UIColor from the gradient image
        return UIColor(patternImage: gradientImage ?? UIImage())
    }
}
