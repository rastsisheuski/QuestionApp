//
//  Extension + UIFont.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 14.07.23.
//

import UIKit

extension UIFont {
    static func useCustomFont(withName fontName: String, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "\(fontName)", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
}
