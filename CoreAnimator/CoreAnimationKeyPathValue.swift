//
//  CoreAnimationKeyPathValue.swift
//  CoreAnimator
//
//  Created by Yudai.Hirose on 2017/08/19.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import Foundation


public protocol ValueType {
    associatedtype Input
    associatedtype Output
    func translate(input: Input) -> Output
    static var key: String { get }
}

public struct KeyPathValueType {
    
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
        
        public func translate(input: CGRect) -> NSValue {
            return NSValue(cgRect: input)
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
