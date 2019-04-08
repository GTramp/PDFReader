//
//  UserDefaults+Extensions.swift
//  Groot
//
//  Created by tramp on 2019/3/25.
//  Copyright © 2019 SINA. All rights reserved.
//

import Foundation

extension UserDefaults {
    internal struct Key {}
}

extension UserDefaults.Key {
    /// 流量开关
    internal static let AllowFlow: String = "AllowFlow"
}
