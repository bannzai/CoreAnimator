//
//  AnimationKeyPath.swift
//  CoreAnimator
//
//  Created by Yudai.Hirose on 2017/08/19.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import UIKit


public protocol Animatable: class {
    
}

extension UIView: Animatable {

}

extension CALayer: Animatable {
    
}

public enum CoreAnimationFillMode: Int {
    case forwards
    case backwards
    case both
    case removed

    var key: String {
        switch self {
        case .forwards:
            return kCAFillModeForwards
        case .backwards:
            return kCAFillModeBackwards
        case .both:
            return kCAFillModeBoth
        case .removed:
            return kCAFillModeRemoved
        }
    }
}

public enum CoreAnimationTimingType: Int {
    case linear
    case easeIn
    case easeOut
    case easeInOut 
    case `default`
    
    var key: String {
        switch self {
        case .linear:
            return kCAMediaTimingFunctionLinear
        case .easeIn:
            return kCAMediaTimingFunctionEaseIn
        case .easeOut:
            return kCAMediaTimingFunctionEaseOut
        case .easeInOut:
            return kCAMediaTimingFunctionEaseInEaseOut
        case .`default`:
            return kCAMediaTimingFunctionDefault
        }
    }
}

public protocol ValueType {
    associatedtype Input
    associatedtype Output
    func translate(input: Input) -> Output
    static var key: String { get }
}

public struct KeyPathValue {
    
    public struct cornerRadius: ValueType {
        public static let key: String = "cornerRadius"
        public func translate(input: CGFloat) -> NSNumber {
            return NSNumber(value: Float(input))
        }
    }
    
    public struct transform: ValueType {
        public static let key: String = "transform"
        public func translate(input: CGAffineTransform) -> NSValue {
            return NSValue(cgAffineTransform: input)
        }
    }
    
    public struct frame: ValueType {
        public static let key: String = "frame"
        
        public func translate(input: CGFloat) -> NSNumber {
            return NSNumber(value: Float(input))
        }
        
        public struct origin: ValueType {
            public static let key: String = frame.key + ".origin"
            
            public func translate(input: CGPoint) -> NSValue {
                return NSValue(cgPoint: input)
            }
            
            public struct x: ValueType {
                public static let key: String = origin.key + ".x"
                public func translate(input: CGFloat) -> NSNumber {
                    return NSNumber(value: Float(input))
                }
            }
            
            public struct y: ValueType {
                public static let key: String = origin.key + ".y"
                public func translate(input: CGFloat) -> NSNumber {
                    return NSNumber(value: Float(input))
                }
            }
        }
    }
}

//public struct CoreAnimationOptions: OptionSet {
//    public let rawValue: CoreAnimationTimingType
//    public init(rawValue: CoreAnimationTimingType) {
//       self.rawValue = rawValue
//    }
//    
//    static let linear = CoreAnimationOptions(rawValue: .linear)
//    static let easeIn = CoreAnimationOptions(rawValue: .easeIn)
//    static let easeOut = CoreAnimationOptions(rawValue: .easeOut)
//    static let easeInOut = CoreAnimationOptions(rawValue: .easeInOut)
//    static let `default` = CoreAnimationOptions(rawValue: .default)
//}
