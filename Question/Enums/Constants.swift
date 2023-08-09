//
//  Constants.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import Foundation

enum Constants {
    
    enum General {
        static let defaultSpacing: CGFloat = 16.0
        static let baseButtonFontSize: CGFloat = 16.0
        static let baseLabelFontSize: CGFloat = 12.0
    }
    
    enum Launch {
        static let logoTitleConstraint: CGFloat = 8.0
        static let halfOfLogoBoundsSizeHeight: CGFloat = 120
        static let logoTitleFontSize: CGFloat = 40
        static let logoTitleWidth: CGFloat = 75
    }
    
    enum Onboarding {
        static let pageControlHeight: CGFloat = 50.0
        static let imageViewBottomConstraint: CGFloat = 60
        static let skipButtonHeight: CGFloat = 25.0
    }
    
    enum SignIn {
        static let stackSpacing: CGFloat = 20.0
        static let baseConstraint: CGFloat = 60.0
    }
    
    enum Registration {
        static let titleLabelTopConstraint: CGFloat = 130.0
        static let baseConstraint: CGFloat = 60.0
        static let backButtonHeightConstraint: CGFloat = 32.0
    }
    
    enum AuthTextField {
        static let errorLabelFontSize: CGFloat = 10.0
        static let animationTime: Double = 0.5
    }
    
    enum TimerInterval {
        static let interval: Double = 1.5
    }
}
