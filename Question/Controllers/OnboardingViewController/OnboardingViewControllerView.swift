//
//  OnboardingViewControllerView.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 17.06.23.
//

import UIKit

class OnboardingViewControllerView: UIView {
    // MARK: -
    // MARK: - Public Properties
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.onboardingBackgroundImage.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        button.setTitleColor(Colors.General.whiteMainColor, for: .normal)
        button.backgroundColor = Colors.OnboardingView.skipButton
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var pageControl: CustomPageControl = {
        let pageControl = CustomPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    // MARK: -
    // MARK: - Private Properties
    
    private var firstAppear = true
    
    // MARK: -
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if firstAppear {
            setupPageControlView()
            setupUI()
            firstAppear = false
        }
    }
    // MARK: -
    // MARK: - Private Methods
    
    private func setupUI() {
        setupSkipButton()
    }
    
    private func setupSkipButton() {
        skipButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        skipButton.layer.cornerRadius = skipButton.frame.size.height / 2
        skipButton.clipsToBounds = true
        skipButton.makeShadow()
    }
    
    private func setupPageControlView() {
        pageControl.numberOfPages = OnboardingInfo.allCases.count
        pageControl.currentPage =  0
        
        pageControl.makeShadow()
    } 
    
    private func layoutElements() {
        layoutScrollView()
        layoutSkipButton()
        layoutBackgroundImageView()
        layoutPageControl()
    }
    
    private func layoutScrollView() {
        addSubview(scrollView)
        
        scrollView.fillSuperview()
    }
    
    private func layoutSkipButton() {
        addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.General.defaultSpacing),
            skipButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.General.defaultSpacing),
//            skipButton.heightAnchor.constraint(equalToConstant: Constants.Onboarding.skipButtonHeight),
            skipButton.widthAnchor.constraint(equalTo: skipButton.heightAnchor, multiplier: 2.3)
        ])
    }
    
    private func layoutBackgroundImageView() {
        scrollView.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor)
        ])
    }
    
    private func layoutPageControl() {
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
