//
//  BaseView.swift
//  Pilyumi
//
//  Created by reda.mimouni on 30/03/2019.
//  Copyright © 2019 Reda Mimouni. All rights reserved.
//

import UIKit

class BaseView: UIView {
    var disabledHighlightedAnimation = false
    
    func resetTransform() {
        transform = .identity
    }
    
    func freezeAnimations() {
        disabledHighlightedAnimation = true
        layer.removeAllAnimations()
    }
    
    func unfreezeAnimations() {
        disabledHighlightedAnimation = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
    
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?=nil) {
        if disabledHighlightedAnimation {
            return
        }
        let animationOptions: UIView.AnimationOptions = GlobalConstants.isEnabledAllowsUserInteractionWhileHighlightingCard
            ? [.allowUserInteraction] : []
        if isHighlighted {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .init(scaleX: GlobalConstants.cardHighlightedFactor, y: GlobalConstants.cardHighlightedFactor)
            }, completion: completion)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .identity
            }, completion: completion)
        }
    }
}
