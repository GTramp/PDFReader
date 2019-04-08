//
//  Bundle+Extensions.swift
//  Captain
//
//  Created by tramp on 2019/2/13.
//  Copyright © 2019 tramp. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// 命名空间 CFBundleName
    internal var namespace: String { return (infoDictionary?["CFBundleName"] as? String) ?? "" }
    /// 版本号 CFBundleShortVersionString
    internal var version: String { return (infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""}
    /// 构建版本 CFBundleVersion
    internal var build: String { return (infoDictionary?["CFBundleVersion"] as? String) ?? "" }
    /// Bundle ID CFBundleIdentifier
    internal var identifier: String { return (infoDictionary?["CFBundleIdentifier"] as? String) ?? "" }
    
}
