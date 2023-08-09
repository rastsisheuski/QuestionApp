//
//  LaunchViewControllerView.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 17.06.23.
//

protocol LaunchViewControllerViewDelegate: AnyObject {
    func animationWasCompleted()
}

import UIKit

class LaunchViewControllerView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    weak var delegate: LaunchViewControllerViewDelegate?
    
    lazy var topLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.Launch.logoTopImage.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var bottomLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.Launch.logoBottomImage.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var logoFirstPartOfTitleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.Launch.logoFirstPartOfTitle.image
        imageView.contentMode = .right
        return imageView
    }()
    
    lazy var logoSecondPartOfTitleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.Launch.logoSecondPartOfTitle.image
        imageView.contentMode = .left
        return imageView
    }()
    
    lazy var fullLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.Launch.fullLogo.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: -
    // MARK: - Private Properties
    
    private let logoImageViewHeight = Constants.Launch.halfOfLogoBoundsSizeHeight
    private let logoTitleFontSize = Constants.Launch.logoTitleFontSize
    private var firstPartOfLogoTitleAnchor: NSLayoutConstraint!
    private var secondPartOfLogoTitleAnchor: NSLayoutConstraint!
    private var topLogoImageViewAnchor: NSLayoutConstraint!
    private var bottomLogoImageViewAnchor: NSLayoutConstraint!
    private var firstAppear = true
    
    // MARK: -
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if firstAppear {
            layoutElements()
            setupUI()
            firstAppear = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func animateLogoTitleAppearance() {
        firstPartOfLogoTitleAnchor.constant = 0
        secondPartOfLogoTitleAnchor.constant = logoFirstPartOfTitleImageView.bounds.size.width + 8
        
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func showFullLogo() {
        logoFirstPartOfTitleImageView.isHidden = true
        logoSecondPartOfTitleImageView.isHidden = true
        topLogoImageViewAnchor.constant = -logoImageViewHeight / 2
        bottomLogoImageViewAnchor.constant = logoImageViewHeight / 2
        
        UIView.animate(withDuration: 1.0) { [weak self] in
            
            self?.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let self else { return }
            self.topLogoImageView.isHidden = true
            self.bottomLogoImageView.isHidden = true
            self.fullLogoImageView.isHidden = false
            
            UIView.animate(withDuration: 1.0) {
                self.layoutIfNeeded()
            } completion: { [weak self] _ in
                self?.delegate?.animationWasCompleted()
            }
        }
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = .black
        fullLogoImageView.isHidden = true
    }
    
    private func layoutElements() {
        layoutTopLogoImageView()
        layoutBottomLogoImageView()
        layoutLogoFirstPartOfTitleImageView()
        layoutLogoSecondPartOfTitleImageView()
        layoutFullLogoImageView()
    }
    
    private func layoutTopLogoImageView() {
        addSubview(topLogoImageView)
        
        let offsetY = -((logoImageViewHeight / 2) + (logoTitleFontSize / 2))

        NSLayoutConstraint.activate([
            topLogoImageView.heightAnchor.constraint(equalToConstant: logoImageViewHeight),
            topLogoImageView.widthAnchor.constraint(equalTo: topLogoImageView.heightAnchor, multiplier: 3),
            topLogoImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        topLogoImageViewAnchor = topLogoImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: offsetY)
        topLogoImageViewAnchor.isActive = true
    }

    private func layoutBottomLogoImageView() {
        addSubview(bottomLogoImageView)
        
        let offsetY = ((logoImageViewHeight / 2) + (logoTitleFontSize / 2))

        NSLayoutConstraint.activate([
            bottomLogoImageView.heightAnchor.constraint(equalToConstant: logoImageViewHeight),
            bottomLogoImageView.widthAnchor.constraint(equalTo: bottomLogoImageView.heightAnchor, multiplier: 3),
            bottomLogoImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        bottomLogoImageViewAnchor = bottomLogoImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: offsetY)
        bottomLogoImageViewAnchor.isActive = true
    }
    
    private func layoutLogoFirstPartOfTitleImageView() {
        addSubview(logoFirstPartOfTitleImageView)
        
        NSLayoutConstraint.activate([
            logoFirstPartOfTitleImageView.topAnchor.constraint(equalTo: topLogoImageView.bottomAnchor),
            logoFirstPartOfTitleImageView.bottomAnchor.constraint(equalTo: bottomLogoImageView.topAnchor),
            logoFirstPartOfTitleImageView.widthAnchor.constraint(equalToConstant: Constants.Launch.logoTitleWidth)
        ])
        
        firstPartOfLogoTitleAnchor =  logoFirstPartOfTitleImageView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: -frame.width / 2 - Constants.Launch.logoTitleWidth)
        firstPartOfLogoTitleAnchor.isActive = true
    }
    
    private func layoutLogoSecondPartOfTitleImageView() {
        addSubview(logoSecondPartOfTitleImageView)
        
        NSLayoutConstraint.activate([
            logoSecondPartOfTitleImageView.topAnchor.constraint(equalTo: topLogoImageView.bottomAnchor),
            logoSecondPartOfTitleImageView.bottomAnchor.constraint(equalTo: bottomLogoImageView.topAnchor),
            logoSecondPartOfTitleImageView.widthAnchor.constraint(equalToConstant: Constants.Launch.logoTitleWidth)
        ])
        
        secondPartOfLogoTitleAnchor =  logoSecondPartOfTitleImageView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: frame.width / 2 + Constants.Launch.logoTitleWidth)
        secondPartOfLogoTitleAnchor.isActive = true
    }
    
    private func layoutFullLogoImageView() {
        addSubview(fullLogoImageView)
        
        NSLayoutConstraint.activate([
            fullLogoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            fullLogoImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            fullLogoImageView.heightAnchor.constraint(equalTo: topLogoImageView.heightAnchor, multiplier: 2),
            fullLogoImageView.widthAnchor.constraint(equalTo: topLogoImageView.widthAnchor, multiplier: 1)
        ])
    }
}