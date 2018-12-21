//
//  UltravisualLayout.swift
//  Ultravisual
//
//  Created by Andy Ron on 2018/11/6.
//  Copyright © 2018 Andy Ron. All rights reserved.
//

import UIKit

struct UltravisualLayoutConstants {
    struct Cell {
        /// 标准高度
        static let standardHeight: CGFloat = 100
        /// 变化后高度
        static let featuredHeight: CGFloat = 280
    }
}
class UltravisualLayout: UICollectionViewLayout {
    
    let dragOffset: CGFloat = 180.0
    
    var cache: [UICollectionViewLayoutAttributes] = []
    
    var featuredItemIndex: Int {
        return max(0, Int(collectionView!.contentOffset.y / dragOffset))
    }
    
    var nextItemPercentageOffset: CGFloat {
        return (collectionView!.contentOffset.y / dragOffset) - CGFloat(featuredItemIndex)
    }
    
    var width: CGFloat {
        return collectionView!.bounds.width
    }
    
    var height: CGFloat {
        return collectionView!.bounds.height
    }
    
    var numberOfItems: Int {
        return collectionView!.numberOfItems(inSection: 0)
    }
}

extension UltravisualLayout {
    
    override var collectionViewContentSize: CGSize {
        let contentHight = (CGFloat(numberOfItems) * dragOffset) + (height - dragOffset)
        return CGSize(width: width, height: contentHight)
    }
    
    override func prepare() {
        cache.removeAll(keepingCapacity: false)
        
        let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
        let featureHeight = UltravisualLayoutConstants.Cell.featuredHeight
        
        var frame = CGRect.zero
        var y: CGFloat = 0
        
        for item in 0..<numberOfItems {
            // 创建当前Cell的索引路径，然后为其创建默认属性
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 准备细胞向上或向下移动。 由于大多数细胞不具备特征 - 标准细胞比单一特征细胞多得多 - 它默认为标准高度。
            attributes.zIndex = item
            var height = standardHeight
            
            // 确定当前单元格的状态 - 特征，下一个或标准。 就后者而言，你什么都不做。
            if indexPath.item == featuredItemIndex {
                // 如果单元格当前处于特征单元格位置，则计算yOffset并使用该值来导出单元格的新y值。 之后，将单元格的高度设置为特征高度。
                let yoffset = standardHeight * nextItemPercentageOffset
                y = collectionView!.contentOffset.y - yoffset
                height = featureHeight
            } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
                // 如果单元格在下一行，则首先计算最大y可能（在这种情况下，大于特征单元格）并将其与计算高度相结合，最终得到正确的y值，即280.0 - 特色细胞的高度。
                let maxY = y + standardHeight
                height = standardHeight + max((featureHeight - standardHeight) * nextItemPercentageOffset, 0)
                y = maxY - height
            }
            
            // 最后，为每个单元格设置一些公共元素，包括创建框架，设置计算的属性以及更新缓存值。 最后一步是更新y，使其位于最后一个计算单元格的底部，以便您可以有效地向下移动单元格列表。
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            cache.append(attributes)
            y = frame.maxY
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}


