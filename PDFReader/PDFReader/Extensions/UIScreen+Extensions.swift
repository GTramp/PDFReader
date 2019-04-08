//
//  UIScreen+Extensions.swift
//  Captain
//
//  Created by tramp on 2019/2/16.
//  Copyright © 2019 tramp. All rights reserved.
//

import UIKit.UIScreen

extension UIScreen {
    // MARK: - 计算型属性
    /// iPhone 5/5S/5C/SE
   internal var isIPhone_5_5S_5C_SE: Bool { return bounds.size == CGSize.init(width: 320.0, height: 568) }
    /// iPhone 6/6S/7/8
   internal var isIPhone_6_6S_7_8: Bool { return bounds.size == CGSize.init(width: 375.0, height: 667.0) }
    /// iPhone plus 6/6S/7/8
   internal var isIPhonePlus_6_6S_7_8: Bool { return bounds.size == CGSize.init(width: 414.0, height: 736.0)}
    /// iPhone X/XS
   internal var isIPhone_X_XS: Bool { return bounds.size == CGSize.init(width: 375.0, height: 812.0) }
    /// iPhone XR/ XSMax
   internal var isIPhone_XR_XSMax:Bool { return bounds.size == CGSize.init(width: 414.0, height: 896.0) }
}
