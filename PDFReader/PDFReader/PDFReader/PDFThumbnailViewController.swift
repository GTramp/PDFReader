//
//  PDFThumbnailViewController.swift
//  PDFReader
//
//  Created by tramp on 2019/4/9.
//  Copyright © 2019 tramp. All rights reserved.
//

import UIKit
import PDFKit

protocol PDFThumbnailViewControllerDelegate: NSObjectProtocol {
    
    /// did selelcted at indexpath
    ///
    /// - Parameters:
    ///   - controller: PDFThumbnailViewController
    ///   - indexPath: IndexPath
    func thumbnailViewController(_ controller: PDFThumbnailViewController, didSelectedAt indexPath: IndexPath)
}

class PDFThumbnailViewController: UIViewController {
    
    // MARK: - 公开属性
    
    /// 代理对象
    internal weak var delegate: PDFThumbnailViewControllerDelegate?
    
    // MARK: - 私有属性
    
    /// 布局
    private lazy var flowlayout: UICollectionViewFlowLayout = {
        let _flowlayout = UICollectionViewFlowLayout.init()
        _flowlayout.scrollDirection = .vertical
        _flowlayout.minimumLineSpacing = 2.0
        _flowlayout.minimumInteritemSpacing = 2.0
        return _flowlayout
    }()
    
    /// collection view
    private lazy var collectionView: UICollectionView = {
        let _collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowlayout)
        _collectionView.backgroundColor = UIColor.init(hex: "#DCDCDC")
        _collectionView.register(PDFThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: PDFThumbnailCollectionViewCell.reuseIdentifier)
        _collectionView.dataSource = self
        _collectionView.delegate = self
        _collectionView.contentInset = UIEdgeInsets.init(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        return _collectionView
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
    
    /// viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 更新布局
        let width = ((collectionView.bounds.width - 2.0 * 2) - collectionView.contentInset.left - collectionView.contentInset.right) / 3.0
        let height = width * 4.0 / 3.0
        flowlayout.itemSize = CGSize.init(width: width, height: height)
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
    
    /// popViewController
    ///
    /// - Parameter animated: Bool
    internal func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
}

// MARK: - UICollectionViewDelegate
extension PDFThumbnailViewController: UICollectionViewDelegate {
    
   internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.thumbnailViewController(self, didSelectedAt: indexPath)
    }
}

// MARK: - UICollectionViewDataSource
extension PDFThumbnailViewController: UICollectionViewDataSource {
    
   internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return document?.pageCount ?? 0
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PDFThumbnailCollectionViewCell.reuseIdentifier, for: indexPath) as! PDFThumbnailCollectionViewCell
        cell.updateUi(page: document?.page(at: indexPath.item), index: indexPath.item + 1)
        return cell
    }
    
}

// MARK: - PDFThumbnailCollectionViewCell

/// PDFThumbnailCollectionViewCell
fileprivate class PDFThumbnailCollectionViewCell: UICollectionViewCell {
    // MARK: - 公开属性
    /// 复用ID
    internal static let reuseIdentifier: String = "PDFThumbnailCollectionViewCell"

    
    // MARK: - 私有属性
    /// 缩略图
    private lazy var thumbnailImgView: UIImageView = {
        let _imgView = UIImageView.init()
        _imgView.contentMode = .scaleAspectFit
        return _imgView
    }()
    
    /// 页码
    private lazy var countLabel: UILabel = {
        let _label = UILabel.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 20.0, height: 16.0))
        _label.backgroundColor = Theme.shared.color(of: .heavy).alpha(0.8)
        _label.font = Theme.shared.font(of: 10.0)
        _label.textColor = Theme.shared.color(of: .highlight)
        _label.layer.cornerRadius = 8.0
        _label.layer.masksToBounds = true
        _label.textAlignment = .center
        return _label
    }()

    // MARK: - 生命周期
    
    /// 构建
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 初始化
        initialize()
    }
    
    /// 构建
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 自定义
extension PDFThumbnailCollectionViewCell {
    
    /// 初始化
    private func initialize() {
        
        // 布局
        contentView.addSubview(thumbnailImgView)
        thumbnailImgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(countLabel)
        countLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-6.0)
            $0.right.equalToSuperview().offset(-6.0)
            $0.width.equalTo(24.0)
            $0.height.equalTo(16.0)
        }
    }
    
    /// 更新Ui
    ///
    /// - Parameters:
    ///   - page: PDFPage
    ///   - index: Int
    internal func updateUi(page: PDFPage?, index: Int) {
        thumbnailImgView.image = page?.thumbnail(of: CGSize.init(width: bounds.width * UIScreen.main.scale, height: bounds.height * UIScreen.main.scale), for: .mediaBox)
        countLabel.text = "\(index)"
    }
}
