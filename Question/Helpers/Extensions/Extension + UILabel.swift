//
//  Extension + UILabel.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 16.07.23.
//

import UIKit

extension UILabel {
    func underlineText(firstRange: String, fontSize: CGFloat, weight: UIFont.Weight, color: UIColor) {
        if let textString = self.text {
            let str = NSString(string: textString)
            let attributedString = NSMutableAttributedString(string: textString)
        
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor : color,  NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize, weight: weight) as Any, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue], range: str.range(of: firstRange))
            attributedText = attributedString
        }
    }
}
