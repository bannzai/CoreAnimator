//
//  CoreAnimationFillMode.swift
//  CoreAnimator
//
//  Created by Yudai.Hirose on 2017/08/19.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import UIKit

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
