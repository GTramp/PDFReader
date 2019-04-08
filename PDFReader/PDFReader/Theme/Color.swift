//
//  Color.swift
//  Groot
//
//  Created by tramp on 2019/3/8.
//  Copyright © 2019 tramp. All rights reserved.
//

import Foundation

class Colors: NSObject {
    /// 默认值
    private static let `default`: String = "#F22A2A"
    
    // MARK: - 公开属性
    @objc internal var major: String = Colors.default
    @objc internal var heavy: String =  Colors.default
    @objc internal var medium: String = Colors.default
    @objc internal var light: String = Colors.default
    @objc internal var highlight: String = Colors.default
    @objc internal var destructive: String = Colors.default
    @objc internal var background: String = Colors.default
    @objc internal var border: String = Colors.default
    @objc internal var separator: String = Colors.default
    @objc internal var placeholder: String = Colors.default
    @objc internal var dark: String = Colors.default
    @objc internal var green: String = Colors.default
    @objc internal var orange: String = Colors.default
    @objc internal var blue: String = Colors.default

    /// 防止 KVC 崩溃
    // override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

// MARK: - 自定义
extension Colors {
    
    /// 构建
    ///
    /// - Parameter dict: 颜色字典
    convenience init(with dict: [String: Any]) {
        self.init()
        // 键值编码
        setValuesForKeys(dict)
    }
}

/// 颜色枚举
internal enum Color {
    case major
    case heavy
    case medium
    case light
    case highlight
    case destructive
    case background
    case border
    case separator
    case placeholder
    case dark
    case green
    case orange
    case  blue
    
    /// 颜色值
    internal var value: String {
        switch self {
        case .major: return Theme.shared.colors.major
        case .heavy: return Theme.shared.colors.heavy
        case .medium: return Theme.shared.colors.medium
        case .light: return Theme.shared.colors.light
        case .highlight: return Theme.shared.colors.highlight
        case .destructive: return Theme.shared.colors.destructive
        case .background: return Theme.shared.colors.background
        case .border: return Theme.shared.colors.border
        case .separator: return Theme.shared.colors.separator
        case .placeholder: return Theme.shared.colors.placeholder
        case .dark: return Theme.shared.colors.dark
        case .green: return Theme.shared.colors.green
        case .orange: return Theme.shared.colors.orange
        case .blue: return Theme.shared.colors.blue
        }
    }
}
