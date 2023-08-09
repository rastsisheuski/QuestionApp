//
//  OnboardingView.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 25.06.23.
//

import UIKit

class OnboardingView: UIView {
    
    // MARK: -
    // MARK: - Private Properties
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.General.selectedButton
        label.font = UIFont.useCustomFont(
            withName: Fonts.pattayaRegular.rawValue,
            size: 36
        )
        label.textColor = Colors.General.whiteMainColor
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.General.selectedButton
        label.font = UIFont.useCustomFont(
            withName: Fonts.pattayaRegular.rawValue,
            size: 14
        )
        label.textColor = Colors.General.whiteMainColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
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
        
//        setupUI()
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func setTitleText(text: String) {
        titleLabel.text = text
    }
    
    func setDescriptionText(text: String) {
        descriptionLabel.text = text
    }
    
    func setLabelTransform(for labels: [UILabel], transform: CGAffineTransform) {
        labels.forEach { $0.transform = transform }
    }
    
    func setImageViewImage(image: UIImage) {
        imageView.image = image
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func showImageViewAnimated() {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 1,
                       options: UIView.AnimationOptions.curveEaseInOut,
                       animations: ({
            self.imageView.isHidden = false
        }), completion: nil)
        layoutIfNeeded()
        imageView.layoutIfNeeded()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupUI() {
        imageView.isHidden = true
    }
    
    private func layoutElements() {
        layoutTitleLabel()
        layoutDescriptionLabel()
        layoutImageView()
    }
    
    private func layoutImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: Constants.General.defaultSpacing),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.General.defaultSpacing),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.General.defaultSpacing),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -Constants.Onboarding.imageViewBottomConstraint)
        ])
    }
    
    
    private func layoutTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.General.defaultSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.General.defaultSpacing),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func layoutDescriptionLabel() {
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.General.defaultSpacing),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.General.defaultSpacing),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.General.defaultSpacing)
        ])
    }
}
