//
//  OnboardingViewController.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 17.06.23.
//

import UIKit

class OnboardingViewController: NiblessViewController {
    
    // MARK: -
    // MARK: - Private Properties
    
    private var contentView: OnboardingViewControllerView {
        view as! OnboardingViewControllerView
    }
    
    private var slides = [OnboardingView]()
    private var currentSlideIndex = 0 {
        didSet {
            showImageViewAnimated(currentIndex: currentSlideIndex)
        }
    }
    
    // MARK: -
    // MARK: - Public Properties
    
    let viewModel: OnboardingViewModel
    let navigationResponder: MainResponder
    
    // MARK: -
    // MARK: - LifeCycle
    
    init(viewModel: OnboardingViewModel, navigationResponer: MainResponder) {
        self.viewModel = viewModel
        self.navigationResponder = navigationResponer
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        
        view = OnboardingViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        setDelegates()
        setupTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        slides = createSlides()
        setupSlidesScrollView(slides: slides)
        hideImageViews()
        hideStartButton()
        showImageViewAnimated(currentIndex: 0)
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setDelegates() {
        contentView.scrollView.delegate = self
    }
    
    private func setupTargets() {
        contentView.skipButton.addTarget(self, action: #selector(skipOnboarding(sender: )), for: .touchUpInside)
        contentView.startButton.addTarget(self, action: #selector(skipOnboarding(sender: )), for: .touchUpInside)
    }
    
    private func hideImageViews() {
        slides.forEach {$0.imageView.isHidden = true }
        slides.forEach {$0.imageView.alpha = 0.0 }
    }
    
    private func hideStartButton() {
        contentView.startButton.isHidden = true
        contentView.startButton.alpha = 0.0
    }
    
    private func createSlides() -> [OnboardingView] {
        var result: [OnboardingView] = []
        OnboardingInfo.allCases.forEach { element in
            let view = OnboardingView()
            view.setTitleText(text: element.title)
            view.setDescriptionText(text: element.description)
            view.setImageViewImage(image: element.image)
            result.append(view)
        }
        return result
    }
    
    private func setupSlidesScrollView(slides: [OnboardingView]) {
        for (index, element) in slides.enumerated() {
            element.translatesAutoresizingMaskIntoConstraints = false
            switch index {
                    //MARK: -  Первая вью
                case 0:
                    layoutOnboardingView(onboardingView: element, previousView: nil, isLast: false)
                    //MARK: -  Последняя вью
                case slides.count - 1:
                    layoutOnboardingView(onboardingView: element, previousView: slides[index - 1], isLast: true)
                    //MARK: -  Промежуточные вью
                default:
                    layoutOnboardingView(onboardingView: element, previousView: slides[index - 1], isLast: false)
            }
        }
    }
    
    private func layoutOnboardingView(
        onboardingView: OnboardingView,
        previousView: OnboardingView?,
        isLast: Bool
    ) {
        contentView.scrollView.addSubview(onboardingView)
        NSLayoutConstraint.activate([
            onboardingView.topAnchor.constraint(equalTo: contentView.scrollView.frameLayoutGuide.topAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: contentView.scrollView.frameLayoutGuide.bottomAnchor),
            onboardingView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1)
        ])
        
        if let previousView {
            NSLayoutConstraint.activate([
                onboardingView.leadingAnchor.constraint(equalTo: previousView.trailingAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                onboardingView.leadingAnchor.constraint(equalTo: contentView.scrollView.contentLayoutGuide.leadingAnchor)
            ])
        }
        
        if isLast {
            NSLayoutConstraint.activate([
                onboardingView.trailingAnchor.constraint(equalTo: contentView.scrollView.contentLayoutGuide.trailingAnchor)
            ])
        }
    }
    
    private func applyTransform(
        persentHorizontalOffset: CGFloat,
        currentIndex: Int
    ) {
        let firstScreenOffsetStep = OnboardingInfo.first.rawValue
        let secondScreenOffsetStep = OnboardingInfo.secont.rawValue
        let thirdScreenOffsetStep = OnboardingInfo.third.rawValue
        let fourthScreenOffsetStep = OnboardingInfo.fourth.rawValue
        
        contentView.pageControl.isHidden = false
        contentView.pageControl.alpha = 1.0
        hideStartButton()
        
        switch persentHorizontalOffset {
            // MARK: - First View
            case firstScreenOffsetStep...secondScreenOffsetStep:
                let firstTransform = CGAffineTransform(
                    scaleX: (secondScreenOffsetStep - persentHorizontalOffset) / secondScreenOffsetStep,
                    y: (secondScreenOffsetStep - persentHorizontalOffset) / secondScreenOffsetStep
                )
                let secondTransform = CGAffineTransform(
                    scaleX: persentHorizontalOffset / secondScreenOffsetStep,
                    y: persentHorizontalOffset / secondScreenOffsetStep
                )
                let firstItem = slides[0]
                let secondItem = slides[1]
                
                firstItem.setlabelTransform(
                    for: [firstItem.titleLabel, firstItem.descriptionLabel],
                    transform: firstTransform
                )
                secondItem.setlabelTransform(
                    for: [secondItem.titleLabel, secondItem.descriptionLabel],
                    transform: secondTransform
                )
                // MARK:  - Second View
            case secondScreenOffsetStep...thirdScreenOffsetStep:
                let secondTransform = CGAffineTransform(
                    scaleX: (thirdScreenOffsetStep - persentHorizontalOffset) / secondScreenOffsetStep,
                    y: (thirdScreenOffsetStep - persentHorizontalOffset) / secondScreenOffsetStep
                )
                let thirdTransform = CGAffineTransform(
                    scaleX: persentHorizontalOffset/thirdScreenOffsetStep,
                    y: persentHorizontalOffset/thirdScreenOffsetStep
                )
                let secontItem = slides[1]
                let thirdItem = slides[2]
                
                secontItem.setlabelTransform(
                    for: [secontItem.titleLabel, secontItem.descriptionLabel],
                    transform: secondTransform
                )
                thirdItem.setlabelTransform(
                    for: [thirdItem.titleLabel, thirdItem.descriptionLabel],
                    transform: thirdTransform
                )
                // MARK: - Third View
            default:
                let thirdTransform = CGAffineTransform(
                    scaleX: (fourthScreenOffsetStep - persentHorizontalOffset) / secondScreenOffsetStep,
                    y: (fourthScreenOffsetStep - persentHorizontalOffset) / secondScreenOffsetStep
                )
                let fourthTransform = CGAffineTransform(
                    scaleX: persentHorizontalOffset,
                    y: persentHorizontalOffset
                )
                let thirdItem = slides[2]
                let fourthItem = slides[3]
                
                thirdItem.setlabelTransform(
                    for: [thirdItem.titleLabel, thirdItem.descriptionLabel],
                    transform: thirdTransform
                )
                fourthItem.setlabelTransform(
                    for: [fourthItem.titleLabel, fourthItem.descriptionLabel],
                    transform: fourthTransform
                )
        }
        if currentIndex == OnboardingInfo.allCases.count - 1 {
            hideFirstAndShowSecondAnimated(firstView: contentView.pageControl, sencondView: contentView.startButton)
        }
    }
    
    private func showImageViewAnimated(currentIndex: Int) {
        self.slides[currentIndex].imageView.isHidden = false
        
        UIView.animate(withDuration: 3.0,
                       delay: 0.5,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 1,
                       options: UIView.AnimationOptions.curveEaseInOut,
                       animations: ({ [weak self] in
            self?.slides[currentIndex].imageView.alpha = 1.0
            self?.slides[currentIndex].imageView.layoutIfNeeded()
        }), completion: nil)
    }
    
    private func hideFirstAndShowSecondAnimated(firstView: UIView, sencondView: UIView) {
        contentView.pageControl.isHidden = true
        contentView.startButton.isHidden = false
        
        UIView.animate(withDuration: 2.0,
                       delay: 0.5,
                       animations: ({ [weak self] in
            self?.contentView.pageControl.alpha = 0.0
            self?.contentView.startButton.alpha = 1.0
            self?.contentView.pageControl.layoutIfNeeded()
            self?.contentView.startButton.layoutIfNeeded()
        }), completion: nil)
    }
}

// MARK: -
// MARK: - Extension OnboardingViewController + UIScrollViewDelegate

extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / contentView.frame.width)
        contentView.pageControl.currentPage = Int(pageIndex)
        
        let maxHoriaontalOffset = scrollView.contentSize.width - contentView.frame.width
        let persentHorizontalOffset = scrollView.contentOffset.x / maxHoriaontalOffset
        
        applyTransform(
            persentHorizontalOffset: persentHorizontalOffset,
            currentIndex: Int(pageIndex)
        )
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / contentView.frame.width)
        contentView.pageControl.currentPage = Int(pageIndex)
        
        showImageViewAnimated(currentIndex: Int(pageIndex))
    }
}

// MARK: -
// MARK: - Extension OnboardingViewController + @Objc Methods

extension OnboardingViewController {
    @objc private func skipOnboarding(sender: UIButton) {
        navigationResponder.showSignIn()
    }
}
