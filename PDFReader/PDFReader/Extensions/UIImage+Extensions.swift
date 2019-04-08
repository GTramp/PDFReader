//
//  UIImage+Extensions.swift
//  Groot
//
//  Created by tramp on 2019/3/20.
//  Copyright © 2019 SINA. All rights reserved.
//

import UIKit.UIImage

extension UIImage {
    
    ///  通过颜色生成图片
    ///
    /// - Parameter color: UIColor
    /// - Returns: UIImage
    internal class func `init`(color: UIColor) -> UIImage {
        let rect = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 10.0, height: 10.0))
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        // 获取上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return UIImage.init()
        }
        // 绘制
        context.setFillColor(color.cgColor)
        context.fill(rect)
        // 从上下文中获取图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage.init()
        // 关闭上下文
        UIGraphicsEndImageContext()
        // 返回
        return newImage.stretchableImage(withLeftCapWidth: Int(rect.size.width * 0.5), topCapHeight: Int(rect.size.height * 0.5))
    }
    
}

extension UIImage {
    
    /// 等比例缩放
    ///
    /// - Parameter scale: 缩放系数
    /// - Returns: UIImage
    internal func scale(with scale: CGFloat) -> UIImage {
        return self.scale(with: CGSize.init(width: size.width * scale, height: size.height * scale))
    }
    
    /// 重设图片大小
    ///
    /// - Parameter size: 目标大小
    /// - Returns: 缩放后的 UIImage
    internal func scale(with size: CGSize) -> UIImage {
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        // 绘制
        draw(in: CGRect.init(origin: CGPoint.zero, size: size))
        // 获取图片
        let newImage =  UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        // 返回
        return newImage ?? self
    }
    
    /// 修改图片 tint color
    ///
    /// - Parameter color: 目标颜色
    /// - Returns: UIImage
    internal func tint(with color: UIColor) -> UIImage {
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        // 获取上下文
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        // 绘制图片
        let rect = CGRect(origin: .zero, size: CGSize(width: size.width, height: size.height))
        context.clip(to: rect, mask: cgImage!)
        context.setFillColor(color.cgColor)
        context.fill(rect)
        // 获取图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext() ?? self
        // 关闭上下文
        UIGraphicsEndImageContext()
        // 返回
        return newImage
    }
    
    /// 修改渲染模式
    ///
    /// - Parameter mode: UIImage.RenderingMode
    /// - Returns: UIImage
    internal func rendering(with mode: UIImage.RenderingMode) -> UIImage {
        return withRenderingMode(mode)
    }
    
    /// 设置图片拉伸参数
    ///
    /// - Parameters:
    ///   - leftCapWidth: Int
    ///   - topCapHeight: Int
    /// - Returns: UIImage
    internal func stretchable(_ leftCapWidth: Int, _ topCapHeight: Int) -> UIImage {
        return stretchableImage(withLeftCapWidth: leftCapWidth, topCapHeight: topCapHeight)
    }
}
