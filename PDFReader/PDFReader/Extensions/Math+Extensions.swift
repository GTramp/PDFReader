//
//  Math+Extensions.swift
//  Groot
//
//  Created by tramp on 2019/3/20.
//  Copyright © 2019 SINA. All rights reserved.
//

import Foundation

// MARK: - TimeInterval
extension TimeInterval {
    /// 默认动画周期
    internal static var animate: TimeInterval { return  0.25 }
}

// MARK: - Int
extension Int {
    
    /// 存储容量
    internal var readable: String {
        let names = ["Bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
        if Double(self) > 0 {
            var i = floor(log2(Double(self)) / 10);
            if i > 8 {
                i = 8
            }
            let s = Double(self) / pow(1024, i);
            return String.init(format: "%.2f\(names[Int(i)])", s)
        }
        return "0 Bytes"
    }
    
}
