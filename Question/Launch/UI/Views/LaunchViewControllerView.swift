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
        imageView.contentMode = .center
        return imageView
    }()
    
    lazy var bottomLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.Launch.logoBottomImage.image
        imageView.contentMode = .center
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
        imageView.contentMode = .center
        return imageView
    }()
    
    // MARK: -
    // MARK: - Private Properties
    
    private let logoImageViewHeight = Constants.Launch.halfOfLogoBoundsSizeHeight
    private let logoTitleFontSize = Constants.Launch.logoTitleFontSize
    private let animationDuration: CGFloat = 1.0
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
        
        UIView.animate(withDuration: animationDuration) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func animateLogoTitleDisappearance(completion: @escaping () -> Void) {
        UIView.animate(withDuration: animationDuration / 2) { [weak self] in
            guard let self else { return }
            
            self.logoFirstPartOfTitleImageView.alpha = 0
            self.logoSecondPartOfTitleImageView.alpha = 0
            self.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.logoFirstPartOfTitleImageView.isHidden = true
            self?.logoSecondPartOfTitleImageView.isHidden = true
            self?.layoutIfNeeded()
            completion()
        }
    }
    
    func animateClashLogoImage() {
        topLogoImageViewAnchor.constant = -logoImageViewHeight / 2
        bottomLogoImageViewAnchor.constant = logoImageViewHeight / 2
        
        UIView.animate(withDuration: animationDuration / 2) { [weak self] in
            
            self?.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let self else { return }
            self.topLogoImageView.isHidden = true
            self.bottomLogoImageView.isHidden = true
            self.fullLogoImageView.isHidden = false
            
            UIView.animate(withDuration: animationDuration / 2) {
                self.layoutIfNeeded()
            } completion: { [weak self] _ in
                self?.drawMask {
                    let scenes = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    guard let splashWindow = scenes?.windows.last else { return }
                    
                    splashWindow.alpha = 0
                    splashWindow.isHidden = true
                }
                self?.delegate?.animationWasCompleted()
            }
        }
    }
    
    func drawMask(completion: @escaping () -> Void) {
        let scenes = UIApplication.shared.connectedScenes.first as? UIWindowScene
        guard let splashWindow = scenes?.windows.first else { return }
        guard let trueSplashWindow = scenes?.windows.last else { return }

        trueSplashWindow.alpha = 0

        let mask = CALayer()
        mask.frame = fullLogoImageView.frame
        mask.contents = Images.Launch.fullLogo.image.cgImage
        splashWindow.layer.mask = mask

        let maskBackgroundView = UIImageView(image: Images.Launch.fullLogo.image)
        maskBackgroundView.frame = mask.frame
//        maskBackgroundView.contentMode = .center
        splashWindow.addSubview(maskBackgroundView)
        splashWindow.bringSubviewToFront(maskBackgroundView)
        
        CATransaction.setCompletionBlock {
            splashWindow.layer.mask = nil
            completion()
        }

        CATransaction.begin()

        splashWindow.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        UIView.animate(withDuration: 3, animations: {
            splashWindow.transform = .identity
        })

        [mask, maskBackgroundView.layer].forEach { layer in
            addScalingAnimation(to: layer, duration: 3)
            addRotationAnimation(to: layer, duration: 3)
        }

        UIView.animate(withDuration: 0.1, delay: 0.1, options: [], animations: {
            maskBackgroundView.alpha = 0
        }) { _ in
            maskBackgroundView.removeFromSuperview()
        }

        CATransaction.commit()
    }
    
    private func addRotationAnimation(to layer: CALayer, duration: TimeInterval, delay: CFTimeInterval = 0) {
        let animation = CABasicAnimation()
        
        let tangent = layer.position.y / layer.position.x
        let angle = -1 * atan(tangent)
        
        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateZ)
        animation.fromValue = 0
        animation.toValue = angle
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        layer.add(animation, forKey: "transform")
    }
    
    private func addScalingAnimation(to layer: CALayer, duration: TimeInterval, delay: CFTimeInterval = 0) {
        let animation = CAKeyframeAnimation(keyPath: "bounds")
        
        let width = layer.frame.size.width
        let height = layer.frame.size.height
        let coeficient: CGFloat = 18 / 667
        let finalScale = UIScreen.main.bounds.height * coeficient
        let scales = [1, 0.85, finalScale]
        
        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.keyTimes = [0, 0.2, 1]
        animation.values = scales.map { NSValue(cgRect: CGRect(x: 0, y: 0, width: width * $0, height: height * $0)) }
        animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),
                                     CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        layer.add(animation, forKey: "scaling")
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

// MARK: -
// MARK: - Extension LaunchViewControllerView + LaunchAnimatorResponder

extension LaunchViewControllerView: LaunchAnimatorResponder {
    func animateAppearance() {
        animateLogoTitleAppearance()
    }

    func animateDisappearance(splashAnimationCompletion: @escaping () -> Void) {
        animateLogoTitleDisappearance(completion: splashAnimationCompletion)
    }
}
