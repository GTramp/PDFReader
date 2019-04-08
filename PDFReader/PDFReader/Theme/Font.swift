//
//  Font.swift
//  Groot
//
//  Created by tramp on 2019/3/8.
//  Copyright © 2019 tramp. All rights reserved.
//

import Foundation

class Fonts: NSObject {
    /// 默认值
    internal static var `default`: String { return "PingFangSC-Regular"}
    
    // MARK: - 公开属性
    
    @objc internal var regular: String = Fonts.default
    @objc internal var semibold: String =  Fonts.default
    @objc internal var medium: String =  Fonts.default
    @objc internal var light: String =  Fonts.default
    @objc internal var thin: String =  Fonts.default
    
    ///  防止KVC 崩溃
    // override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

// MARK: - 自定义
extension Fonts {
    
    /// 构建
    ///
    /// - Parameter dict: 字典数据
    convenience init(with dict: [String: Any]) {
        self.init()
        /// 键值编码
        setValuesForKeys(dict)
    }
    
}

/// 字体枚举
internal enum Font: String {
    /// 常规体
    case regular
    /// 半粗体
    case semibold
    /// 中粗体
    case medium
    /// 轻体
    case light
    /// 细体
    case thin
    
    /// 字体值
    internal var value: String {
        switch self{
        case .regular: return Theme.shared.fonts.regular
        case .semibold: return Theme.shared.fonts.semibold
        case .medium: return Theme.shared.fonts.medium
        case .light: return Theme.shared.fonts.light
        case .thin: return Theme.shared.fonts.thin
        }
    }
    
}
