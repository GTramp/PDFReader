//
//  PDFReader.swift
//  PDFReader
//
//  Created by tramp on 2019/4/8.
//  Copyright © 2019 tramp. All rights reserved.
//

import UIKit
import SnapKit

class PDFReader: UINavigationController {

    /// 构建
    ///
    /// - Parameter url: URL
    convenience init(url: URL) {
        self.init(rootViewController: PDFViewController.init(url: url))
    }
    
    /// 构建
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
   /// 构建
   private override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    /// 构建
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - PDFViewController

/// PDFViewController
class PDFViewController: UIViewController {
    
    // MARK: - 私有属性
    
    /// 关闭按钮
    private lazy var closeItem: UIBarButtonItem = {
        let _button = UIButton.init(type: .custom)
        _button.setImage(UIImage.init(named: "pdf_close")?.tint(with: Theme.shared.color(of: .heavy)), for: .normal)
        _button.addTarget(self, action: #selector(closeActionHandler(_:)), for: .touchUpInside)
        return UIBarButtonItem.init(customView: _button)
    }()
    
    /// 缩略图按钮
    private lazy var thumbnailItem: UIBarButtonItem = {
        let _button = UIButton.init(type: .custom)
        _button.setImage(UIImage.init(named: "pdf_thumbnail")?.tint(with: Theme.shared.color(of: .heavy)), for: .normal)
        // _button.addTarget(self, action: #selector(closeActionHandler(_:)), for: .touchUpInside)
        return UIBarButtonItem.init(customView: _button)
    }()
    
    /// 旋转按钮
    private lazy var rotateItem: UIBarButtonItem = {
        let _button = UIButton.init(type: .custom)
        _button.setImage(UIImage.init(named: "pdf_horizontal")?.tint(with: Theme.shared.color(of: .heavy)), for: .normal)
        _button.setImage(UIImage.init(named: "pdf_vertical")?.tint(with: Theme.shared.color(of: .heavy)), for: .selected)
        _button.addTarget(self, action: #selector(rotateActionHandler(_:)), for: .touchUpInside)
        return UIBarButtonItem.init(customView: _button)
    }()
    
    /// 大纲视图
    private lazy var outlineItem: UIBarButtonItem = {
        let _button = UIButton.init(type: .custom)
        _button.setImage(UIImage.init(named: "pdf_outline")?.tint(with: Theme.shared.color(of: .heavy)), for: .normal)
        // _button.addTarget(self, action: #selector(closeActionHandler(_:)), for: .touchUpInside)
        return UIBarButtonItem.init(customView: _button)
    }()
    
    /// 更多按钮
    private lazy var moreItem: UIBarButtonItem = {
        let _button = UIButton.init(type: .custom)
        _button.setImage(UIImage.init(named: "pdf_more")?.tint(with: Theme.shared.color(of: .highlight)), for: .normal)
        _button.bounds = CGRect.init(x: 0.0, y: 0.0, width: 36.0, height: 36.0)
        _button.layer.cornerRadius = 18.0
        _button.backgroundColor = Theme.shared.color(of: .heavy).alpha(0.8)
        _button.layer.masksToBounds = true
        // _button.addTarget(self, action: #selector(closeActionHandler(_:)), for: .touchUpInside)
        return UIBarButtonItem.init(customView: _button)
    }()
    
    /// 分享按钮
    private lazy var shareItem: UIBarButtonItem = {
        let _button = UIButton.init(type: .custom)
        _button.setImage(UIImage.init(named: "pdf_share")?.tint(with: Theme.shared.color(of: .highlight)), for: .normal)
        _button.bounds = CGRect.init(x: 0.0, y: 0.0, width: 36.0, height: 36.0)
        _button.backgroundColor = Theme.shared.color(of: .heavy).alpha(0.8)
        _button.layer.cornerRadius = 18.0
        _button.layer.masksToBounds = true
        // _button.addTarget(self, action: #selector(closeActionHandler(_:)), for: .touchUpInside)
        return UIBarButtonItem.init(customView: _button)
    }()
    
    /// toolbar
    private lazy var toolbar: UIToolbar = {
        let _tooblbar = UIToolbar.init()
        _tooblbar.items = [UIBarButtonItem.flexible(), shareItem, UIBarButtonItem.fixed(width: 10.0), moreItem]
        _tooblbar.setShadowImage(UIImage.init(), forToolbarPosition: .any)
        _tooblbar.setBackgroundImage(UIImage.init(), forToolbarPosition: .any, barMetrics: .default)
        return _tooblbar
    }()
    
    // MARK: - 生命周期
    
    /// 构建
    ///
    /// - Parameter url: URL
    convenience init(url:URL) {
        self.init()
    }
    
    /// viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化
        initialize()
    }
}

// MARK: - 自定义
extension PDFViewController {
    /// 初始化
    private func initialize() {
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = closeItem
        navigationItem.leftBarButtonItems = [thumbnailItem,outlineItem,rotateItem]
        navigationItem.title = "预览"
        
        // 布局
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(64.0)
        }
    }
    
    /// 关闭操作
    ///
    /// - Parameter sender: UIButton
    @objc private func closeActionHandler(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /// 旋转操作
    ///
    /// - Parameter sender: UIButton
    @objc private func rotateActionHandler(_ sender: UIButton) {
        sender.isSelected.toggle()
        
    }
    
    ///  提纲操作
    ///
    /// - Parameter sender: UIButton
    @objc private func outlineActionHandler(_ sender: UIButton) {
        
    }
}
