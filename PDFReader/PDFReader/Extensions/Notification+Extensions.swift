//
//  Notification+Extensions.swift
//  Groot
//
//  Created by tramp on 2019/3/21.
//  Copyright © 2019 SINA. All rights reserved.
//

import Foundation

// MARK: - 自定义通知
extension Notification.Name {
    /// 切换控制器
    internal static let ChangeRootControllerNotification = Notification.Name.init("change_root_controller")
    /// 异常捕获通知
    internal static let UncaughtExceptionNotification = Notification.Name.init("application_UncaughtException")
}

