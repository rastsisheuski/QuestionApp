//
//  Colors.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import UIKit

enum Colors {
    
    enum General {
        static let selectedButton: UIColor = #colorLiteral(red: 0.9411764706, green: 0.7333333333, blue: 0.3058823529, alpha: 1)
        static let unSelectedButton: UIColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        static let placeholderText: UIColor = UIColor.lightGray
        static let placeholderBackground: UIColor = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2235294118, alpha: 1)
        static let lightGrayColor: UIColor = UIColor.lightGray
        static let blackColor: UIColor = UIColor.black
        static let whiteColor: UIColor = UIColor.white
        static let purpleMainColor: UIColor = #colorLiteral(red: 0.3647058824, green: 0.2549019608, blue: 0.6039215686, alpha: 1)
        static let whiteMainColor: UIColor = #colorLiteral(red: 1, green: 0.9529411765, blue: 0.9882352941, alpha: 1)
        
    }
    
    enum signIn {
        static let logInBottomColor: UIColor = #colorLiteral(red: 0.3294117647, green: 0.1137254902, blue: 0.3803921569, alpha: 1)
    }
    
    enum OnboardingView {
        static let skipButtonColor: UIColor = #colorLiteral(red: 0.4352941176, green: 0.1450980392, blue: 0.6352941176, alpha: 1)
        static let startButtonColor: UIColor = #colorLiteral(red: 0.3647058824, green: 0.2549019608, blue: 0.6039215686, alpha: 1)
    }
    
    enum SpinnerView {
        static let mainColorWithAlpha: UIColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.1176470588, alpha: 0.4006105132)
    }
    
    enum OrderButton {
        static let backgroundLabelOrderButton: UIColor = #colorLiteral(red: 0.8862745098, green: 0.6980392157, blue: 0.3098039216, alpha: 1)
        
    }
    
    enum TypeOfDish {
        static let selectedTypeOfDish: UIColor = #colorLiteral(red: 0.9411764706, green: 0.7333333333, blue: 0.3058823529, alpha: 1)
        static let unselectedTypeOfDish: UIColor = #colorLiteral(red: 0.2588235294, green: 0.2549019608, blue: 0.2784313725, alpha: 1)
    }
    
    enum Gradient {
        static let topColorForGradient: UIColor = #colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1843137255, alpha: 1)
        static let bottomColorForGradient: UIColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.1176470588, alpha: 1)
    }
    
    enum RegistrationBottomView {
        static let confirmButtonTextColor = #colorLiteral(red: 0.2588235294, green: 0.2549019608, blue: 0.2784313725, alpha: 1)
    }
    
    enum DishesViewControllerView {
        static let viewBackgroundColor: UIColor = #colorLiteral(red: 0.1215686275, green: 0.1176470588, blue: 0.1411764706, alpha: 1)
    }
    
    enum BasketViewControllerView {
        static let viewBackgroundColor: UIColor = #colorLiteral(red: 0.1215686275, green: 0.1176470588, blue: 0.1411764706, alpha: 1)
    }
    
    enum basketItemView {
        static let backgroundColor: UIColor = #colorLiteral(red: 0.2588235294, green: 0.2549019608, blue: 0.2784313725, alpha: 1)
    }
}
