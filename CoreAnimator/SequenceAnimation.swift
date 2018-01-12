//
//  SequenceAnimation.swift
//  CoreAnimator
//
//  Created by Yudai.Hirose on 2017/08/19.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import UIKit

protocol SequenceAnimation {
    var duration: TimeInterval { get }
    
    func animate(with delay: TimeInterval)
}

struct ViewSequenceAnimation: SequenceAnimation {
    typealias View = UIView
    
    let duration: TimeInterval
    let view: View
    let options: UIViewAnimationOptions
    let animation: ((View) -> Void)
    let completion: ((Bool) -> Void)?
    
    func animate(with delay: TimeInterval) {
        UIView.animate(
            withDuration: TimeInterval(duration),
            delay: TimeInterval(delay),
            options: options,
            animations: { 
                self.animation(self.view)
        },
            completion: completion
        )
    }
}

struct LayerSequenceAnimation: SequenceAnimation {
    typealias View = CALayer
    
    let duration: TimeInterval
    let layer: View
    let options: CoreAnimationTimingType
    let keyPath: String
    let fromValue: Any
    let toValue: Any
    let autoreverse: Bool
    let isRemovedOnCompletion: Bool
    let fillMode: CoreAnimationFillMode 
    let completion: (() -> Void)?
    
    func animate(with delay: TimeInterval) {
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.duration = TimeInterval(duration)
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.autoreverses = autoreverse
        animation.isRemovedOnCompletion = isRemovedOnCompletion
        animation.fillMode = fillMode.key
        animation.beginTime = CACurrentMediaTime() + delay
        
        CATransaction.begin()
        CATransaction.setCompletionBlock { 
            self.completion?()
        }
        layer.add(animation, forKey: nil)
        CATransaction.commit()
    }
}
