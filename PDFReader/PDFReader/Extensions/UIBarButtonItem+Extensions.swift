//
//  UIBarButtonItem+Extensions.swift
//  Captain
//
//  Created by tramp on 2019/2/14.
//  Copyright © 2019 tramp. All rights reserved.
//

import UIKit.UIBarButtonItem

extension UIBarButtonItem {
    
    /// 获取自定义button
    internal var button: UIButton? { return customView as? UIButton }
    
    /// 构造 fixedSpace Item
    ///
    /// - Parameter width: CGFloat
    /// - Returns: UIBarButtonItem
    internal class func fixed(width: CGFloat) -> UIBarButtonItem {
        let item = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        item.width = width
        return item
    }
    
    /// 构造 flexibleSpace item
    ///
    /// - Returns: UIBarButtonItem
    internal class func flexible() -> UIBarButtonItem {
        return UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    }
}
