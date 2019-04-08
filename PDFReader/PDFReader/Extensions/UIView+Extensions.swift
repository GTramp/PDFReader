//
//  UIView+Extensions.swift
//  Groot
//
//  Created by tramp on 2019/3/19.
//  Copyright © 2019 SINA. All rights reserved.
//

import UIKit.UIView
import SnapKit

extension UIView {
    
    /// 缩放动画
    ///
    /// - Parameters:
    ///   - from: fromValue
    ///   - to: toValue
    ///   - duration: TimeInterval
    ///   - delegate: CAAnimationDelegate
    /// - Returns: 动画Key
    @discardableResult
    internal func scaleAnimation(from: CGFloat, to : CGFloat, duration: TimeInterval = 0.25, delegate: CAAnimationDelegate? = nil) -> String {
        let key = "transform.scale"
        let animation = CABasicAnimation(keyPath: key)
        animation.duration = duration
        animation.toValue = to
        animation.fromValue = from
        animation.isRemovedOnCompletion = true
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        animation.delegate = delegate
        layer.add(animation, forKey: key)
        return key
    }
    
}

// MARK: - Separator
extension UIView {
    /// 分割线
    class Separator: UIView {
        // MARK: - 公开属性
        internal var edge: UIRectEdge!
        // MARK: - 生命周期
        convenience init(edge: UIRectEdge) {
            self.init()
            self.edge = edge
        }
    }
    
    /// 获取分割线
    ///
    /// - Parameter edge: UIRectEdge
    /// - Returns: UIView.Border
    internal func separators(for edge: UIRectEdge) -> [Separator]? {
        let subs = subviews.filter{$0 is Separator}
        guard let borders = subs as? [Separator] else { return nil }
        return borders
    }
    
    /// 设置分割线
    ///
    /// - Parameters:
    ///   - edge: UIRectEdge
    ///   - color: UIColor
    ///   - width: CGFloat
    ///   - insets: UIEdgeInsets
    internal func separator(edge: UIRectEdge, color: UIColor, width: CGFloat, insets: UIEdgeInsets = .zero) {
        //  构建
        let separator = Separator.init(edge: edge)
        separator.backgroundColor = color
        addSubview(separator)
        
        switch edge {
        case .top:
            
            separator.snp.makeConstraints{
                $0.top.equalToSuperview()
                $0.left.equalToSuperview().offset(insets.left)
                $0.right.equalToSuperview().offset(-insets.right)
                $0.height.equalTo(width)
            }
        case .left:
            
            separator.snp.makeConstraints{
                $0.left.equalToSuperview()
                $0.top.equalToSuperview().offset(insets.top)
                $0.bottom.equalToSuperview().offset(-insets.bottom)
                $0.width.equalTo(width)
            }
        case .bottom:
            
            separator.snp.makeConstraints{
                $0.bottom.equalToSuperview()
                $0.left.equalToSuperview().offset(insets.left)
                $0.right.equalToSuperview().offset(-insets.right)
                $0.height.equalTo(width)
            }
        case .right:
            
            separator.snp.makeConstraints{
                $0.right.equalToSuperview()
                $0.top.equalToSuperview().offset(insets.top)
                $0.bottom.equalToSuperview().offset(-insets.bottom)
                $0.width.equalTo(width)
            }
        case .all:
            
            self.separator(edge: .left, color: color, width: width, insets: insets)
            self.separator(edge: .right, color: color, width: width, insets: insets)
            self.separator(edge: .top, color: color, width: width, insets: insets)
            self.separator(edge: .bottom, color: color, width: width, insets: insets)
            
        default:
            break
        }
    }
    
}
