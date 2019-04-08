//
//  PHPhotoLibrary+Extensions.swift
//  Groot
//
//  Created by tramp on 2019/4/6.
//  Copyright © 2019 SINA. All rights reserved.
//

import Foundation
import Photos

// MARK: - 自定义
extension PHPhotoLibrary {
    
    /// 保存图片到相册
    ///
    /// - Parameters:
    ///   - image: UIImage
    ///   - completion: 完成回调
    internal func saveImage(_ image: UIImage, completion: ((PHAsset?, Error?, PHAuthorizationStatus)->Void)?) {
        switch PHPhotoLibrary.authorizationStatus() {
        // 保存图片
        case .authorized:
            var localIdentifier: String?
            self.performChanges({
                localIdentifier = PHAssetChangeRequest.creationRequestForAsset(from: image).placeholderForCreatedAsset?.localIdentifier
            }) { (sucess, error) in
                guard let localIdentifier = localIdentifier, let asset = PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifier], options: nil).firstObject else {
                    DispatchQueue.main.async {
                         completion?(nil, error, PHPhotoLibrary.authorizationStatus())
                    }
                    return
                }
                // 回调
                DispatchQueue.main.async {
                     completion?(asset, error, PHPhotoLibrary.authorizationStatus())
                }
            }
        // 获取授权
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization {[unowned self] (status) in
                guard status == .authorized else { return }
                DispatchQueue.main.async {
                    self.saveImage(image, completion: completion)
                }
            }
        default:
            completion?(nil, nil, PHPhotoLibrary.authorizationStatus())
        }
    }
    
    /// 获取相册信息
    ///
    /// - Parameters:
    ///   - mediaType: PHAssetMediaType
    ///   - completion: 完成回调
    internal func fetchAlbums(with mediaType: PHAssetMediaType, completion: @escaping(([PHAlbum], PHAuthorizationStatus) -> Void)) {
        // 获取授权状态
        switch PHPhotoLibrary.authorizationStatus() {
            // 获取授权
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization {[unowned self] (status) in
                guard status == .authorized else {
                    DispatchQueue.main.async {
                        completion([], status)
                    }
                    return
                }
                // 获取相册信息
                DispatchQueue.main.async {
                    self.fetchAlbums(with: mediaType, completion: completion)
                }
            }
        case .authorized:
            // 获取相册信息
            // 构建参数
            let options = PHFetchOptions.init()
            options.predicate = NSPredicate.init(format: "mediaType == %ld", mediaType.rawValue)
            options.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: false)]
            // 获取相册
            let stream = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumMyPhotoStream, options: nil)
            let smart = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
            let user = PHCollectionList.fetchTopLevelUserCollections(with: nil)
            let synced = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumSyncedAlbum, options: nil)
            let shared = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumCloudShared, options: nil)
            
            var albums: [PHAlbum] = []
            [stream, smart, user, synced, shared].forEach { (result) in
                guard let result = result as? PHFetchResult<PHAssetCollection>, result.count > 0 else { return }
                // 获取相册
                result.enumerateObjects({ (collection, _, _) in
                    guard collection.estimatedAssetCount > 0 else { return }
                    guard collection.assetCollectionSubtype != .smartAlbumAllHidden else { return }
                    guard collection.assetCollectionSubtype.rawValue != 1000000201 else { return }  //『最近删除』相册
                    let result = PHAsset.fetchAssets(in: collection, options: options)
                    guard result.count > 0 else { return }
                    albums.append(PHAlbum.init(localizedTitle: collection.localizedTitle ?? "未知", result: result))
                })
            }
            
            // 回调
            completion(albums, .authorized)
            
        default:
            completion([], PHPhotoLibrary.authorizationStatus())
        }
    }
}

// MARK: - PHAlbum
struct PHAlbum {
    // MARK: - 存储型属性
    
    internal let localizedTitle: String
    internal let result: PHFetchResult<PHAsset>
    
    // MARK: - 计算型属性
    
    /// 封面
    internal var cover: PHAsset? { return result.firstObject }
    /// 资源数量
    internal var count: Int { return result.count }
    
}

// MARK: - 自定义
extension PHAlbum {
    /// 获取封面图片
    ///
    /// - Parameters:
    ///   - size: CGSize
    ///   - placeholderImage: placeholder: 占位图
    ///   - completion: 完成回调
    internal func cover(with size: CGSize, placeholderImage: UIImage?, completion: @escaping((UIImage?)->Void)) {
        // 设置展位图
        if placeholderImage != nil {
            completion(placeholderImage)
        }
        // 获取封面
        guard let asset = result.firstObject else{
            completion(placeholderImage ?? nil)
            return
        }
        // 构建参数
        let options = PHImageRequestOptions.init()
        options.isNetworkAccessAllowed = true
        options.version = .current
        options.deliveryMode = .opportunistic
        options.resizeMode = .exact
        // 获取
        PHCachingImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options) { (image, _) in
            completion(image)
        }
    }
    
    /// 获取图片数据
    ///
    /// - Returns:  [PHAsset]
    internal func fetchAssets() -> [PHAsset] {
        var assets: [PHAsset] = []
        result.enumerateObjects { (asset, _, _) in
            assets.append(asset)
        }
        return assets
    }
    
    /// 根据时间分类
    ///
    /// - Returns: [PHSection]
    internal func classify() -> [PHSection] {
        // 获取日期
        var sections: [PHSection] = []
        result.enumerateObjects { (asset, _, _) in
            if let creationDate = asset.creationDate {
                let creation = DateFormatter.shared.string(from: creationDate, "yyyy年MM月dd日")
                if let index = sections.firstIndex(where: {$0.creation == creation}) {
                    sections[index].assets.append(asset)
                } else {
                    sections.append(PHSection.init(creation: creation, assets: [asset]))
                }
            } else {
                if let index = sections.firstIndex(where: {$0.creation == "未知"}) {
                    sections[index].assets.append(asset)
                } else {
                    sections.append(PHSection.init(creation: "未知", assets: [asset]))
                }
            }
        }
        
        return sections
    }
}

// MARK: - PHSection
struct PHSection {
    internal let creation: String
    internal var assets: [PHAsset] = []
}
