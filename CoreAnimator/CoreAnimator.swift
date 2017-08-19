//
//  CoreAnimator.swift
//  CoreAnimator
//
//  Created by Yudai.Hirose on 2017/08/19.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import UIKit

public class SequenceAnimator {
    var animations: [SequenceAnimation] = []
    var allCompletion: (() -> Void)?
    
    public init() {
        
    }
    
//    public static func instantiate(_ closure: (inout SequenceAnimator) -> Void) -> SequenceAnimator {
//        var instance = SequenceAnimator()
//        closure(&instance)
//        return instance
//    }
    
    public func add(
        duration: TimeInterval,
        view: UIView,
        options: UIViewAnimationOptions = .curveEaseInOut,
        animation: @escaping ((UIView) -> Void)
        ) -> SequenceAnimator {
        
        animations.append(
            ViewSequenceAnimation(
                duration: duration,
                view: view,
                options: options,
                animation: animation,
                completion: nil
            )
        )
        return self
    }
    public func add(
        duration: TimeInterval,
        view: UIView,
        options: UIViewAnimationOptions = .curveEaseInOut,
        animation: @escaping ((UIView) -> Void),
        completion: ((Bool) -> Void)?
        ) -> SequenceAnimator {
        
        animations.append(
            ViewSequenceAnimation(
                duration: duration,
                view: view,
                options: options,
                animation: animation,
                completion: completion
            )
        )
        return self
    }
    
    public func add<V: ValueType>(
        duration: TimeInterval,
        layer: CALayer,
        options: CoreAnimationTimingType,
        keyPath: V.Type,
        fromValue: V.Input,
        toValue: V.Output,
        autoreverse: Bool = false,
        isRemovedOnCompletion: Bool = false,
        fillMode: CoreAnimationFillMode = .forwards,
        completion: ((Void) -> Void)? = nil
        ) -> SequenceAnimator {
        
        return add(duration: duration,
            layer: layer,
            options: options,
            keyPath: keyPath.key,
            fromValue: fromValue,
            toValue: toValue,
            autoreverse: autoreverse,
            isRemovedOnCompletion: isRemovedOnCompletion,
            fillMode: fillMode,
            completion: completion
        )
    }
    
    public func add(
        duration: TimeInterval,
        layer: CALayer,
        options: CoreAnimationTimingType,
        keyPath: String,
        fromValue: Any,
        toValue: Any,
        autoreverse: Bool = false,
        isRemovedOnCompletion: Bool = false,
        fillMode: CoreAnimationFillMode = .forwards,
        completion: ((Void) -> Void)? = nil
        ) -> SequenceAnimator {
        
        animations.append(
            LayerSequenceAnimation(
                duration: duration,
                layer: layer,
                options: options,
                keyPath: keyPath,
                fromValue: fromValue,
                toValue: toValue,
                autoreverse: autoreverse,
                isRemovedOnCompletion: isRemovedOnCompletion,
                fillMode: fillMode,
                completion: completion
            )
        )
        return self
    }

    
    public func addCompletion(completion: @escaping (() -> Void)) -> SequenceAnimator {
        allCompletion = completion
        return self
    }
    
    public func animate(with delay: TimeInterval = 0) {
        var beforeDelay: TimeInterval = delay
        animations.forEach {
            $0.animate(with: beforeDelay)
            beforeDelay += $0.duration
        }
    }
}

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
