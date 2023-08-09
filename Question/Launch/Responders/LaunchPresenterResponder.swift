//
//  LaunchPresenterResponder.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 3.08.23.
//

import Foundation

protocol LaunchPresenterResponder {
    func presentForegroundWindow()
    func dismissForegroundWindow(completion: @escaping () -> Void)
}
