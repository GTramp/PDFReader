//
//  URL+Extensions.swift
//  Groot
//
//  Created by tramp on 2019/3/20.
//  Copyright © 2019 SINA. All rights reserved.
//

import Foundation

extension URL {
    /// 查询URL 中的参数
    ///
    /// - Parameter key: 查询key
    /// - Returns: key 所对应的值
    internal func query(with key: String) -> String? {
        guard let components = URLComponents.init(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else { return nil }
        return queryItems.first(where: {$0.name == key})?.value
    }
}
