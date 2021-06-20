//
//  UIImage+Resize.swift
//  Pojo
//
//  Created by Kien on 20/06/2021.
//

import UIKit

/// Crop UIImage
/// https://www.advancedswift.com/crop-image/#center-crop-image
/// Resize UIImage Without Stretching
/// https://www.advancedswift.com/resize-uiimage-no-stretching-swift/
extension UIImage {
  func squareCrop() -> UIImage {
    // Determines the x,y coordinate of a centered
    // sideLength by sideLength square
    let length = min(size.width, size.height)
    let xOffset = (size.width - length) / 2.0
    let yOffset = (size.height - length) / 2.0
    
    // The cropRect is the rect of the image to keep,
    // in this case centered
    let cropRect = CGRect(x: xOffset, y: yOffset, width: length, height: length).integral
    // Center crop the image
    guard let croppedCGImage = cgImage?.cropping(to: cropRect) else {
      return self
    }
    return UIImage(cgImage: croppedCGImage, scale: imageRendererFormat.scale, orientation: imageOrientation)
  }
  
  func scale(_ targetSize: CGSize) -> UIImage {
    // Determine the scale factor that preserves aspect ratio
    let widthRatio = targetSize.width / size.width
    let heightRatio = targetSize.height / size.height
    
    let scaleFactor = max(widthRatio, heightRatio)
    
    // Compute the new image size that preserves aspect ratio
    let scaledSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
    
    // Draw and return the resized UIImage
    let renderer = UIGraphicsImageRenderer(size: scaledSize)
    let scaledImage = renderer.image { _ in
      self.draw(in: CGRect(origin: .zero, size: scaledSize))
    }
    return scaledImage
  }
}
