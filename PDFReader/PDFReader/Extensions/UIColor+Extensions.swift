//
//  UIColor+Extensions.swift
//  Groot
//
//  Created by tramp on 2019/3/19.
//  Copyright © 2019 SINA. All rights reserved.
//

import UIKit.UIColor

extension UIColor {
    
    /// 构建颜色
    ///
    /// - Parameters:
    ///   - hex: 16 进制
    ///   - alpha: 颜色y透明度
    convenience init(hex: String, alpha: CGFloat = 10) {
        var hex = hex
        // 剔除 #
        if hex.contains("#") { hex = hex.replacingOccurrences(of: "#", with: "")}
        // 构建 Scanner
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        // 扫描
        scanner.scanHexInt64(&rgbValue)
        // 构建参数
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        // 构建 UIColor
        self.init( red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: alpha)
    }
    
    /// UIColor 转 hex 字符串
    ///
    /// - Parameter hash: 是否携带 “#”
    /// - Returns: hex 字符串
    internal func toHex(hash: Bool = true) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        // 获取 色值
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        // 构建 hex string
        var hex = String( format: "%02X%02X%02X",Int(r * 0xff), Int(g * 0xff), Int(b * 0xff))
        // 添加 hash (#)
        if hash == true { hex = "#\(hex)" }
        // 返回
        return hex
    }
    
    /// 随机色
    internal class var random: UIColor {
        return UIColor.init(red: ((CGFloat((arc4random() % 256)) / 255.0)), green: ((CGFloat((arc4random() % 256)) / 255.0)), blue: ((CGFloat((arc4random() % 256)) / 255.0)), alpha: 1.0)
    }
    
    /// 修改颜色透明度
    ///
    /// - Parameter alpha: 透明度
    internal func alpha(_ alpha: CGFloat) -> UIColor {
        return withAlphaComponent(alpha)
    }
}
