//
//  KeyboardObserver.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import UIKit

class KeyboardObserver: UIView {
    
    // MARK: -
    // MARK: - Public properties
    
    var scroll = UIScrollView()
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(scrollView: UIScrollView) {
        super .init(frame: .zero)
        
        self.scroll = scrollView
        addObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: -
// MARK: - Extension KeyboardObserver + @objc Methods

extension KeyboardObserver {
    @objc func keyboardWillShow(notification:NSNotification){
        //        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let keyBoardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        //        let keyboardRectangle = keyboardValue.cgRectValue
        let keyboardHeight = keyBoardFrame.size.height
        
        //        self.scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scroll.contentInset.bottom = keyboardHeight
        print("")
        
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        self.scroll.contentInset = UIEdgeInsets.zero
    }
}

