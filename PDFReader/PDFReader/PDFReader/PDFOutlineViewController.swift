//
//  PDFOutlineViewController.swift
//  PDFReader
//
//  Created by tramp on 2019/4/9.
//  Copyright © 2019 tramp. All rights reserved.
//

import UIKit

class PDFOutlineViewController: UIViewController {

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
    }
}
