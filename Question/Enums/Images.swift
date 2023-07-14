//
//  Images.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import UIKit

enum Images {
    case defaultDishImage
    case tabBarBackgroundImage
    case loginBackgroundImage
    case logoImage
    case onboardingBackgroundImage
    case onboardingWelcomeImage
    case onboardingQuestionImage
    case onboardingSolutionImage
    case onboardingHelpImage
    
    var image: UIImage {
        switch self {
            case .defaultDishImage:             return UIImage(named: "defaultDishImage") ?? UIImage()
            case .tabBarBackgroundImage:        return UIImage(named: "tabBarBackgroundImage") ?? UIImage()
            case .loginBackgroundImage:         return UIImage(named: "loginBackgroundImage") ?? UIImage()
            case .logoImage:                    return UIImage(named: "logoImage") ?? UIImage()
            case .onboardingBackgroundImage:    return UIImage(named: "backgroundImage") ?? UIImage()
            case .onboardingWelcomeImage:       return UIImage(named: "welcomeImage") ?? UIImage()
            case .onboardingQuestionImage:      return UIImage(named: "questionImage") ?? UIImage()
            case .onboardingSolutionImage:      return UIImage(named: "solutionImage") ?? UIImage()
            case .onboardingHelpImage:          return UIImage(named: "helpImage") ?? UIImage()
        }
    }
}
