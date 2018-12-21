//
//  UIImageExtension.swift
//  Ultravisual
//
//  Created by Andy Ron on 2018/11/6.
//  Copyright © 2018 Andy Ron. All rights reserved.
//

import UIKit

extension UIImage {
    var decompressedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(at: CGPoint.zero)
        guard let decompressedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        UIGraphicsEndImageContext()
        return decompressedImage
    }
}
