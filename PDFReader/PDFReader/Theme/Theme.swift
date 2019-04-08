//
//  Theme.swift
//  Groot
//
//  Created by tramp on 2019/3/19.
//  Copyright © 2019 SINA. All rights reserved.
//

import UIKit

class Theme {
    // MARK: - 公开属性
    
    /// 单例属性
    internal static let shared = Theme.init()
    /// 主题文件名
    internal var filename: String = "theme.default.plist"
    /// 字体
    internal let fonts: Fonts
    // 颜色
    internal let colors: Colors
    
    // MARK: - 生命周期
    
    /// 构建
    private init() {
        // 获取主题文件
        guard let fileUrl = Bundle.main.url(forResource: filename, withExtension: nil)else { fatalError("未找到主题文件")}
        // 解析数据
        guard let dict = NSDictionary.init(contentsOf: fileUrl) as? [String: [String: Any]], let fonts_dict = dict["fonts"], let colors_dict = dict["colors"] else { fatalError("主题文件解析失败")  }
        // 设置字体
        fonts = Fonts.init(with: fonts_dict)
        // 设置颜色
        colors = Colors.init(with: colors_dict)
    }
}

// MARK: - 自定义
extension Theme {
    
    /// 获取字体
    ///
    /// - Parameters:
    ///   - font: 字体样式
    ///   - size: 字体大小
    /// - Returns: UIFont
    internal func font(_ font: Font = .regular, of size: CGFloat) -> UIFont {
        return UIFont.init(name: font.value, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    /// 获取颜色
    ///
    /// - Parameter color: 颜色枚举
    /// - Returns: UIColor
    internal func color(of color: Color) -> UIColor {
        return UIColor.init(hex: color.value)
    }
    
    /// 设置主题
    internal func appearance() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.shared.color(of: .heavy).alpha(0.85)]
         UINavigationBar.appearance().tintColor = Theme.shared.color(of: .major)
         UITextView.appearance().tintColor = Theme.shared.color(of: .major)
         UITextField.appearance().tintColor = Theme.shared.color(of: .major)
//        UIView.appearance().tintColor = Theme.shared.color(of: .major)
    }
}

