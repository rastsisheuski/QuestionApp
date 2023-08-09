//
//  Images.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import UIKit

enum Images {
    
    enum Launch: String {
        case logoTopImage
        case logoBottomImage
        case logoFirstPartOfTitle
        case logoSecondPartOfTitle
        case fullLogo
        
        var image: UIImage {
            switch self {
                case .logoTopImage:             return UIImage(named: rawValue) ?? UIImage()
                case .logoBottomImage:          return UIImage(named: rawValue) ?? UIImage()
                case .logoFirstPartOfTitle:     return UIImage(named: rawValue) ?? UIImage()
                case .logoSecondPartOfTitle:    return UIImage(named: rawValue) ?? UIImage()
                case .fullLogo:                 return UIImage(named: rawValue) ??  UIImage()
            }
        }
    }
    
    enum Onboarding: String {
        case backgroundImage
        case welcomeImage
        case questionImage
        case solutionImage
        case helpImage
        
        var image: UIImage {
            switch self {
                case .backgroundImage:    return UIImage(named: rawValue) ?? UIImage()
                case .welcomeImage:       return UIImage(named: rawValue) ?? UIImage()
                case .questionImage:      return UIImage(named: rawValue) ?? UIImage()
                case .solutionImage:      return UIImage(named: rawValue) ?? UIImage()
                case .helpImage:          return UIImage(named: rawValue) ?? UIImage()
            }
        }
    }
    
    enum SignIn: String {
        case signInMainImage
        case signInTopWave
        case signInBottomWave
        case signInBackgroundImage
        case appleImage
        case googleImage
        
        var image: UIImage {
            switch self {
                case .signInMainImage:        return UIImage(named: rawValue) ?? UIImage()
                case .signInTopWave:     return UIImage(named: rawValue) ?? UIImage()
                case .signInBottomWave:  return UIImage(named: rawValue) ?? UIImage()
                case .signInBackgroundImage:  return UIImage(named: rawValue) ?? UIImage()
                case .appleImage:       return UIImage(named: rawValue) ?? UIImage()
                case .googleImage:      return UIImage(named: rawValue) ?? UIImage()
            }
        }
    }
}
