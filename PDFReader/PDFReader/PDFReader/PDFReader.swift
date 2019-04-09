//
//  PDFReader.swift
//  PDFReader
//
//  Created by tramp on 2019/4/8.
//  Copyright © 2019 tramp. All rights reserved.
//

import UIKit
import SnapKit
import PDFKit

class PDFReader: UINavigationController {

    /// 构建
    ///
    /// - Parameter fileUrl: URL
    convenience init(fileUrl: URL) {
        self.init(rootViewController: PDFViewController.init(fileUrl: fileUrl))
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
fileprivate class PDFViewController: UIViewController {
    
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
         _button.addTarget(self, action: #selector(thumbnailActionHandler(_:)), for: .touchUpInside)
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
         _button.addTarget(self, action: #selector(outlineActionHandler(_:)), for: .touchUpInside)
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
         _button.addTarget(self, action: #selector(moreActionHandler(_:)), for: .touchUpInside)
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
         _button.addTarget(self, action: #selector(shareActionHandler(_:)), for: .touchUpInside)
        return UIBarButtonItem.init(customView: _button)
    }()
    
    /// toolbar
    private lazy var toolbar: UIToolbar = {
        let _tooblbar = UIToolbar.init()
        _tooblbar.items = [UIBarButtonItem.init(customView: countLabel),UIBarButtonItem.flexible(), shareItem, UIBarButtonItem.fixed(width: 10.0), moreItem]
        _tooblbar.setShadowImage(UIImage.init(), forToolbarPosition: .any)
        _tooblbar.setBackgroundImage(UIImage.init(), forToolbarPosition: .any, barMetrics: .default)
        return _tooblbar
    }()
    
    /// 页码
    private lazy var countLabel: UILabel = {
        let _label = UILabel.init()
        _label.font = Theme.shared.font(of: 15.0)
        _label.textColor = Theme.shared.color(of: .highlight)
        _label.backgroundColor = Theme.shared.color(of: .heavy).alpha(0.8)
        _label.bounds = CGRect.init(x: 0.0, y: 0.0, width: 72.0, height: 36.0)
        _label.layer.cornerRadius = 18.0
        _label.layer.masksToBounds = true
        _label.text = "0/0"
        _label.textAlignment = .center
        _label.adjustsFontSizeToFitWidth = true
        return _label
    }()
    
    /// 隐藏home 指示器
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    // PDFView
    private lazy var pdfView: PDFView = {
        let _pdfView = PDFView.init()
        _pdfView.autoScales = true
        _pdfView.displayMode = .singlePageContinuous
        _pdfView.displayDirection = .vertical
        _pdfView.interpolationQuality = .high
        return _pdfView
    }()
    
    
    // MARK: - 生命周期
    
    /// 构建
    ///
    /// - Parameter fileUrl: URL
    convenience init(fileUrl:URL) {
        self.init()
        guard let document = PDFDocument.init(url: fileUrl) else { return }
        if document.isLocked {
            // 提示用解锁
            unlock(document: document, message: nil) {[unowned self] (success, document) in
                guard success else {
                    self.dismiss(animated: true, completion: nil)
                    return
                }
                self.pdfView.document = document
            }
        } else {
            pdfView.document = document
        }
    }
    
    /// viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化
        initialize()
        // 滚动到初始位置
        scrollToInitial()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 添加通知
        NotificationCenter.default.addObserver(self, selector: #selector(pageChangedNotifyHandler(_:)), name: .PDFViewPageChanged, object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 移除KVO
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 析构函数
    deinit {
       print("The PDFViewController has been destoryed ...")
    }
}

// MARK: - 自定义
extension PDFViewController {
    /// 初始化
    private func initialize() {
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItems = [thumbnailItem,UIBarButtonItem.fixed(width: 10.0),outlineItem, UIBarButtonItem.fixed(width: 10.0),rotateItem]
        navigationItem.leftBarButtonItem = closeItem
        navigationItem.title = "预览"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = Theme.shared.color(of: .heavy)
        
        // 布局
       view.addSubview(pdfView)
        pdfView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(toolbar)
        view.bringSubviewToFront(toolbar)
        toolbar.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.bottom.equalToSuperview()
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
        var index: Int = 0
        // 记录当前位置
        if let page = pdfView.currentPage {
            index = pdfView.document?.index(for: page) ?? 0
        }
        // 更新排列方向
        switch pdfView.displayDirection {
        case .vertical:
            pdfView.displayDirection = .horizontal
        case .horizontal:
            pdfView.displayDirection = .vertical
        default: break
        }
        // 滚动到当前位置
        if let document = self.pdfView.document,  let page = document.page(at: index) {
            let bounds = page.bounds(for: self.pdfView.displayBox)
            self.pdfView.go(to: CGRect(x: 0, y: bounds.height, width: 1.0, height: 1.0), on: page)
        }
        // 更新页码
        updatePage()
    }
    
    /// 更新页码
    private func updatePage(){
        guard let document = pdfView.document, let page = pdfView.currentPage else { return }
        countLabel.text = "\(document.index(for: page) + 1)/\(document.pageCount)"
    }
    
    /// 缩略图操作
    ///
    /// - Parameter sender: UIButton
    @objc private func thumbnailActionHandler(_ sender: UIButton) {
        let controller = PDFThumbnailViewController.init()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    ///  提纲操作
    ///
    /// - Parameter sender: UIButton
    @objc private func outlineActionHandler(_ sender: UIButton) {
        let controller = PDFOutlineViewController.init()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    /// 更多操作
    ///
    /// - Parameter sender: UIButton
    @objc private func moreActionHandler(_ sender: UIButton) {
        
    }
    
    /// 分享操作
    ///
    /// - Parameter sender: UIButton
    @objc private func shareActionHandler(_ sender: UIButton) {
        
    }
    
    /// 滚动到初始位置
    @objc private func scrollToInitial() {
        DispatchQueue.main.async {
            if let document = self.pdfView.document,  let firstPage = document.page(at: 0) {
                let firstPageBounds = firstPage.bounds(for: self.pdfView.displayBox)
                self.pdfView.go(to: CGRect(x: 0, y: firstPageBounds.height, width: 1.0, height: 1.0), on: firstPage)
            }
            // 更新页码
            self.updatePage()
        }
    }
    
    /// 页面跳转
    ///
    /// - Parameter notification: Notification
    @objc private func pageChangedNotifyHandler(_ notification: Notification) {
        // 更新页码
        updatePage()
    }
    
    /// 解锁加密文件
    ///
    /// - Parameters:
    ///   - document: PDFDocument
    ///   - message: 提示信息
    ///   - completion: 完成回调
    @objc private func unlock(document: PDFDocument, message: String? = nil ,completion: @escaping((Bool, PDFDocument)->Void)) {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: "加密文件", message: message, preferredStyle: .alert)
            alert.view.tintColor = Theme.shared.color(of: .major)
            alert.addTextField { (textFileld) in
                textFileld.tintColor = Theme.shared.color(of: .major)
                textFileld.placeholder = "请输入解锁密码"
            }
            alert.addAction(UIAlertAction.init(title: "取消", style: .default, handler: { (_) in
                completion(false, document)
            }))
            alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { [unowned self](_) in
                guard let password = alert.textFields?.first?.text , password.isEmpty == false else { return }
                if document.unlock(withPassword: password) {
                    completion(true, document)
                } else {
                    self.unlock(document: document, message: "密码错误", completion: completion)
                }
            }))
            // 展示
            self.present(alert, animated: true, completion: nil)
        }
    }
}

