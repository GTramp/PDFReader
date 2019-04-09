//
//  PDFOutlineViewController.swift
//  PDFReader
//
//  Created by tramp on 2019/4/9.
//  Copyright © 2019 tramp. All rights reserved.
//

import UIKit
import PDFKit

protocol PDFOutlineViewControllerDelegate: NSObjectProtocol {
    
    /// didSelectedAt
    ///
    /// - Parameters:
    ///   - controller: PDFOutlineViewController
    ///   - indexPath: IndexPath
    func outlineViewController(_ controller: PDFOutlineViewController, didSelectedAt indexPath: IndexPath)
}

class PDFOutlineViewController: UIViewController {
    
    // MARK: - 公开属性
    
    /// PDFOutlineViewControllerDelegate
    internal weak var delegate: PDFOutlineViewControllerDelegate?
    
    // MARK: - 私有属性
    
    /// 列表视图
    private lazy var tableView: UITableView = {
        let _tableView = UITableView.init(frame: .zero, style: .grouped)
        _tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.sectionFooterHeight = 0.0
        return _tableView
    }()
    
    /// PDFDocument
    private var document: PDFDocument?

    // MARK: - 生命周期
    
    /// 构建
    ///
    /// - Parameter document: PDFDocument
    convenience init(document: PDFDocument?) {
        self.init()
        self.document = document
    }
    
    /// viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化
        initialize()
    }
    
}

// MARK: - 自定义
extension PDFOutlineViewController {
    /// 初始化
    private func initialize() {
        view.backgroundColor = Theme.shared.color(of: .background)
        navigationItem.title = "目录"
        
        // 布局
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// pop controller
    internal func pop(animated: Bool){
        navigationController?.popViewController(animated: animated)
    }
}

// MARK: - UITableViewDelegate
extension PDFOutlineViewController: UITableViewDelegate {
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return document?.outlineRoot?.child(at: section)?.label
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.outlineViewController(self, didSelectedAt: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension PDFOutlineViewController: UITableViewDataSource {
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return document?.outlineRoot?.numberOfChildren ?? 0
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return document?.outlineRoot?.child(at: section)?.numberOfChildren ?? 0
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = document?.outlineRoot?.child(at: indexPath.section)?.child(at: indexPath.row)?.label
        if let count = document?.outlineRoot?.child(at: indexPath.section)?.child(at: indexPath.row)?.numberOfChildren, count > 0 {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
}

