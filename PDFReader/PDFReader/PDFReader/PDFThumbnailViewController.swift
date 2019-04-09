//
//  PDFThumbnailViewController.swift
//  PDFReader
//
//  Created by tramp on 2019/4/9.
//  Copyright © 2019 tramp. All rights reserved.
//

import UIKit

class PDFThumbnailViewController: UIViewController {
    
    // MARK: - 私有属性
    
    /// 布局
    private lazy var flowlayout: UICollectionViewFlowLayout = {
        let _flowlayout = UICollectionViewFlowLayout.init()
        _flowlayout.scrollDirection = .vertical
        return _flowlayout
    }()
    
    /// collection view
    private lazy var collectionView: UICollectionView = {
        let _collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowlayout)
        _collectionView.backgroundColor = Theme.shared.color(of: .background)
        return _collectionView
    }()

    // MARK: - 生命周期
    
    /// viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化
        initialize()
    }
    
    /// viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 更新内边距
        collectionView.contentInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: view.safeAreaInsets.bottom)
    }
}

// MARK: - 自定义
extension PDFThumbnailViewController {
    /// 初始化
    private func initialize() {
        view.backgroundColor = Theme.shared.color(of: .background)
        navigationItem.title = "缩略图"
        navigationController?.navigationBar.isTranslucent = false
        
        // 布局
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
