//
//  Images.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import UIKit

enum Images {
    enum Onboarding {
        case backgroundImage
        case welcomeImage
        case questionImage
        case solutionImage
        case helpImage
        
        var image: UIImage {
            switch self {
                case .backgroundImage:    return UIImage(named: "backgroundImage") ?? UIImage()
                case .welcomeImage:       return UIImage(named: "welcomeImage") ?? UIImage()
                case .questionImage:      return UIImage(named: "questionImage") ?? UIImage()
                case .solutionImage:      return UIImage(named: "solutionImage") ?? UIImage()
                case .helpImage:          return UIImage(named: "helpImage") ?? UIImage()
            }
        }
    }
    
    enum SignIn: String {
        case mainImage = "signInMainImage"
        case topWaveImage = "signInTopWave"
        case bottomWaveImage = "signInBottomWave"
        case backgroundImage = "signInBackgroundImage"
        case appleImage = "appleImage"
        case googleImage = "googleImage"
        
        var image: UIImage {
            switch self {
                case .mainImage:        return UIImage(named: "signInMainImage") ?? UIImage()
                case .topWaveImage:     return UIImage(named: "signInTopWave") ?? UIImage()
                case .bottomWaveImage:  return UIImage(named: "signInBottomWave") ?? UIImage()
                case .backgroundImage:  return UIImage(named: "signInBackgroundImage") ?? UIImage()
                case .appleImage:       return UIImage(named: "appleImage") ?? UIImage()
                case .googleImage:      return UIImage(named: "googleImage") ?? UIImage()
            }
        }
    }
}
