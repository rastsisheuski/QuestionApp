//
//  LaunchAnimatorResponder.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 3.08.23.
//

import Foundation

protocol LaunchAnimatorResponder {
    func animateAppearance()
    func animateDisappearance(splashAnimationCompletion: @escaping () -> Void)
}
