//
//  UIApplication+Extensions.swift
//  Aurora
//
//  Created by tramp on 2019/3/11.
//  Copyright © 2019 tramp. All rights reserved.
//

import UIKit

extension UIApplication {
    
    /// 苹果商店ID
    internal var applestoreID: String { return "422038334" }
    /// 顶层 控制器
    internal  var top: UIViewController? { return findTopController() }
}


extension UIApplication {
    
    
    /// 获取顶层控制器
    ///
    /// - Returns: UIViewController
    private func findTopController() -> UIViewController? {
        var result = findToContrller(for: UIApplication.shared.keyWindow?.rootViewController)
        while result?.presentedViewController != nil {
            result = findToContrller(for: result?.presentedViewController)
        }
        return result
    }
    
    /// 找到顶层控制器
    ///
    /// - Parameter controller: UIViewController
    /// - Returns: UIViewController
    private func findToContrller(for controller: UIViewController?) -> UIViewController? {
        if let controller = controller as? UINavigationController {
            return findToContrller(for: controller.topViewController)
        } else if let controller = controller as? UITabBarController {
            return findToContrller(for: controller.selectedViewController)
        } else {
            return controller
        }
    }
}
