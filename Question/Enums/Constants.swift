//
//  Constants.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import Foundation

enum Constants {
    
    enum Onboarding {
        static let pageControlHeight: CGFloat = 50.0
        static let imageViewBottomConstraint: CGFloat = 60
        static let skipButtonHeight: CGFloat = 25.0
    }
    
    
    enum General {
        static let defaultSpacing: CGFloat = 16
    }
    
    enum TabBar {
        static let tabBarHeight: CGFloat = 83
    }
    
    enum InputView {
        static let textFieldHeight: CGFloat = 50
        static let textFieldFontSize: CGFloat = 15
        static let titleFoncSize: CGFloat = 25
        static let fieldLeftViewWidth: CGFloat = 15
        static let mainButtonsHeight: CGFloat = 70
    }
    
    enum AuthTextField {
        static let errorLabelFontSize: CGFloat = 10
        static let animationTime: Double = 0.5
    }
    
    enum RegistrationBottomView {
        static let checkBoxHeight: CGFloat = 32
        static let privacyPolicyStringFontSize: CGFloat = 12
        static let confirmButtonFontSize: CGFloat = 20
        static let titleFontSize: CGFloat = 25
    }
    
    enum LoginBottomView {
        static let titleFontSize: CGFloat = 25
        static let forgotPasswordFontSize: CGFloat = 10
        static let registrationAccountFontSize: CGFloat = 13
        static let backButtonHeight: CGFloat = 32
    }
    
    enum TimerInterval {
        static let interval: Double = 1.5
    }
    
    enum TypesOfDishesView {
        static let separatorHeightConstraint: CGFloat = 0.5
    }
    
    enum TypesOfDishesCollectionViewCell {
        static let containerCornerRadius: CGFloat = 12
        static let dishLabelFontSize: CGFloat = 13
        static let containerViewTopConstraint: CGFloat = 5
        static let containerViewBottomConstraint: CGFloat = 5
    }
    
    enum DishesViewControllerView {
        static let titleLabelFontSize: CGFloat = 25
        static let typesOfDishesViewHeight: CGFloat = 60
    }
    
    enum DishesViewcontroller {
        static let collectionViewCellHeightMultiplier = 1.75
    }
    
    enum MovingBasketView {
        static let hookViewWidth: CGFloat = 30
        static let hookViewHeight: CGFloat = 2
        static let hookViewTopConstraint: CGFloat = 5
        static let tableViewTopConstraint: CGFloat = 10
        static let orderButtonBottomConstraint: CGFloat = 83
    }
    
    enum CustomBasketItemView {
        static let imageWidth: CGFloat = 80
    }
    
    enum BasketTableViewCell {
        static let mainViewLeadingAndTrailingPConstraints: CGFloat = 20
        static let mainViewTopAndBottomConstraints: CGFloat = 10
    }
}
