//
//  UIButton+Extensions.swift
//  Aurora
//
//  Created by tramp on 2019/3/8.
//  Copyright © 2019 tramp. All rights reserved.
//

import UIKit.UIButton



extension UIButton {
    /// 扩大范围 key
    private static var enlargeInsetKey: String = "enlargeInsetKey"
    
    /// 扩大点击范围
    ///
    /// - Parameter insets: UIEdgeInsets
    internal func enlarge(with insets: UIEdgeInsets) {
        let value = NSValue.init(uiEdgeInsets: insets)
        objc_setAssociatedObject(self, &UIButton.enlargeInsetKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /// 获取扩大范围
    ///
    /// - Returns: UIEdgeInsets
    private func enlargeInsets() -> UIEdgeInsets {
        guard let value = objc_getAssociatedObject(self, &UIButton.enlargeInsetKey) as? NSValue else { return .zero}
        return value.uiEdgeInsetsValue
    }
    
    /// hitTest
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let insets = enlargeInsets()
        if insets == .zero {
            return super.hitTest(point, with: event)
        }
        return  bounds.inset(by: insets).contains(point) ? self : nil
    }
}

