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

public protocol KeyPath {
    var key: String { get }
    var value: Any { get }
}

public enum KeyPathType {
    case cornerRadius(CGFloat)
    case transform(CGAffineTransform)
    case frame(CGRect)

    public enum Frame {
        case origin(CGPoint)
        
        public enum Origin {
            case x(CGFloat)
            case y(CGFloat)
        }
    }
}

extension KeyPathType: KeyPath {
    public var key: String {
        switch self {
        case .cornerRadius:
            return "cornerRadius"
        case .transform:
            return "transform"
        case .frame:
            return "frame"
        }
    }
    
    public var value: Any {
        switch self {
        case .cornerRadius(let cornerRadius):
            return NSNumber(value: Float(cornerRadius))
        case .transform(let value):
            return NSValue(cgAffineTransform: input)
        case .frame(let rect):
            return NSValue(cgRect: rect)
        }
    }
}

extension KeyPathType.Frame: KeyPath {
    var prefix: String {
        return "frame"
    }
    
    public var key: String {
        switch self {
        case .origin:
            return "\(prefix).origin"
        }
    }
    
    public var value: Any {
        switch self {
        case .origin(let point):
            return NSValue(cgPoint: point)
        }
    }
}

extension KeyPathType.Frame.Origin: KeyPath {
    var prefix: String {
        return "frame.origin"
    }
    
    public var key: String {
        switch self {
        case .x:
            return "x"
        case .y:
            return "y"
        }
    }
    
    public var value: Any {
        switch self {
        case .x(let x):
            return NSNumber(value: Float(x))
        case .y(let y):
            return NSNumber(value: Float(y))
        }
    }
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
