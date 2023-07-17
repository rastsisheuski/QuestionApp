//
//  LoginButton.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 16.07.23.
//

import UIKit

class LoginButton: UIButton {
    
    // MARK: -
    // MARK: - Private Properties
    
    private let padding = UIEdgeInsets(
        top: Constants.General.defaultSpacing,
        left: Constants.General.defaultSpacing,
        bottom: Constants.General.defaultSpacing,
        right: Constants.General.defaultSpacing
    )
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(
        title: String,
        titleColor: UIColor,
        size: CGFloat,
        backgroundColor: UIColor,
        border: Bool,
        image: UIImage?,
        shadow: Bool
    ) {
        super .init(frame: .zero)
        
        setupConfirmButton(
            title: title,
            titleColor: titleColor,
            size: size,
            backgroundColor: backgroundColor,
            border: border,
            image: image,
            shadow: shadow
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Override Methods
    
    //    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
    //        return contentRect.inset(by: padding)
    //    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupConfirmButton(
        title: String,
        titleColor: UIColor,
        size: CGFloat,
        backgroundColor: UIColor,
        border: Bool,
        image: UIImage?,
        shadow: Bool
    ) {
        
        // MARK: - Base setup
        contentEdgeInsets = padding
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 16
        clipsToBounds = true
        setTitleColor(titleColor, for: .normal)
        setTitle(title, for: .normal)
        
        titleLabel?.font = UIFont.systemFont(ofSize: size, weight: .regular)
        titleLabel?.textAlignment = .center
        
        // MARK: - Setup Bool Values
        switch border {
            case true:
                layer.borderColor = UIColor.black.cgColor
                layer.borderWidth = 1
            case false:
                layer.borderWidth = 0
        }
        
        switch image {
            case .none:
                setImage(.none, for: .normal)
                imageEdgeInsets.left = 0
            case .some:
                setImage(image, for: .normal)
                imageEdgeInsets.left = -20
        }
        
        switch shadow {
            case true:
                makeShadow()
            case false:
                return
        }
    }
}
