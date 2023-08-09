//
//  CustomPageControl.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 9.07.23.
//

import UIKit

class CustomPageControl: UIStackView {
    
    // MARK: -
    // MARK: - Public Properties
    
    var numberOfPages: Int = 0 {
        didSet {
            setupDots()
        }
    }
    
    var currentPage: Int = 0 {
        didSet {
            updateDots()
        }
    }
    
    // MARK: -
    // MARK: - Private Properties
    
    private var dots: [UIView] = []
    private var dotWidthConstraints: [NSLayoutConstraint] = []
    
    private let inactiveDotColor: UIColor = Colors.General.whiteMainColor
    private let activeDotColor: UIColor = Colors.General.purpleMainColor
    private let inactiveDotSize = CGSize(width: 16.0, height: 16.0)
    private let activeDotWidthMultiplier: CGFloat = 4.5
    private let dotSpacing: CGFloat = 16.0
    private let animationDuration: TimeInterval = 0.5
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        axis = .horizontal
        distribution = .equalSpacing
        spacing = dotSpacing
        alignment = .center
    }
    
    // MARK: - Private Methods
    
    private func setupDots() {
        dots.forEach { $0.removeFromSuperview() }
        dots.removeAll()
        
        for index in 0..<numberOfPages {
            let dot = UIView()
            dot.backgroundColor = inactiveDotColor
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.layer.cornerRadius = dotSpacing / 2
            dot.clipsToBounds = true
            
            dots.append(dot)
            addArrangedSubview(dot)
//            if index == currentPage {
//                dot.widthAnchor.constraint(equalToConstant: inactiveDotSize.width * activeDotWidthMultiplier)
//            }
            dot.heightAnchor.constraint(equalToConstant: 16).isActive = true
            let widthConstraint = dot.widthAnchor.constraint(equalToConstant: inactiveDotSize.width)
            dotWidthConstraints.append(widthConstraint)
            widthConstraint.isActive = true
        }
        layoutIfNeeded()
        updateDots()
    }
    
    private func updateDots() {
        for (index, dot) in dots.enumerated() {
            
            let isActive = index  == currentPage
            
            dot.backgroundColor = isActive ? self.activeDotColor : self.inactiveDotColor
            
            let dotWidth = isActive ? (self.inactiveDotSize.width * self.activeDotWidthMultiplier) : self.inactiveDotSize.width
            self.dotWidthConstraints[index].constant = dotWidth
            
            UIView.animate(withDuration: animationDuration) {
                self.layoutSubviews()
                self.layoutIfNeeded()
            }
        }
    }
}

