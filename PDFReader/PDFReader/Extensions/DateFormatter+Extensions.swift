//
//  DateFormatter+Extensions.swift
//  Aurora
//
//  Created by tramp on 2019/3/10.
//  Copyright © 2019 tramp. All rights reserved.
//

import Foundation

extension DateFormatter {
    // MARK: - 公开属性
    
    /// 单例属性
    internal static let shared: DateFormatter = {
        let _formatter = DateFormatter.init()
        // 设置时区
        // _formatter.timeZone = TimeZone.init(abbreviation: "UTC")
        // 设置区域
        _formatter.locale = Locale.init(identifier: "en_US_POSIX")
        return _formatter
    }()
    
}

// MARK: - 自定义
extension DateFormatter {
    
    /// 日期字符串转日期
    ///
    /// - Parameters:
    ///   - string: 日期字符串
    ///   - format: 日期格式
    /// - Returns: 日期
    internal func date(from string: String, _ format: DateFormat) -> Date? {
        dateFormat = format
        return date(from: string)
    }
    
    /// 日期转日期字符串
    ///
    /// - Parameters:
    ///   - date: 日期
    ///   - format: 日期格式
    /// - Returns: 字符串
    internal func string(from date: Date, _ format: DateFormat) -> String {
        dateFormat = format
        return self.string(from: date)
    }
    
    /// 日期字符串格式转换
    ///
    /// - Parameters:
    ///   - string: 需要转换的日期字符串
    ///   - originFormat: 原始日期格式
    ///   - format: 需要转换的日期格式
    /// - Returns: 日期
    internal func string(from string: String, _ originFormat: DateFormat,  _ format: DateFormat) -> String? {
        guard let date = date(from: string, originFormat) else { return nil }
        return self.string(from: date, format)
    }
}

// MARK: - DateFormat
typealias DateFormat = String
extension DateFormat {
    /// EEE, d MMM yyyy HH:mm:ss z
    internal static var server: DateFormat {return "EEE, d MMM yyyy HH:mm:ss z" }
    /// yyyy-MM-dd HH:mm:ss
    internal static var custom: DateFormat { return "yyyy-MM-dd HH:mm:ss"}
}
