//
//  CoreAnimationTimingType.swift
//  CoreAnimator
//
//  Created by Yudai.Hirose on 2017/08/19.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import Foundation

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
