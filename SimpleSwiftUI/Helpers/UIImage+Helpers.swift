//
//  UIImage+Helpers.swift

import UIKit

public extension UIImage {
    func template() -> UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
}

public extension UIButton {
    func convertToTemplate() {
        setImage(image(for: .normal)!.template(), for: .normal)
    }
}

public extension UIImage {
    enum ScalingOrientation: String {
        case center, top, topRight, right, bottomRight, bottom, bottomLeft, left, topLeft
        static var standard: ScalingOrientation {center}
    }
    static func systemImage(named name: String, size: CGFloat, weight: UIImage.SymbolWeight = .regular, scale: UIImage.SymbolScale = .medium) -> UIImage? {
        let config = UIImage.SymbolConfiguration(pointSize: size, weight: weight, scale: scale)
         return UIImage(systemName: name, withConfiguration: config)
    }
    static func imageWithImage(_ image: UIImage, scaledToSize newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0.0)
        let rect = CGRect(origin: .zero, size: newSize)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    static func crop(_ image: UIImage, toSize cropSize: CGSize, atPoint: CGPoint? = nil) -> UIImage? {
        let bounds = CGRect(origin: .zero, size: image.size)
        let origin = CGPoint(x: bounds.midX - cropSize.width/2, y: bounds.midY - cropSize.height/2)
        let cropRect = CGRect(origin: origin, size: cropSize)
        let croppedImage = image.cropping(toRect: cropRect)
        return croppedImage
    }
    
    static func imageWithImage(_ image: UIImage, scaledAndCroppedToSize newSize: CGSize, orientation: ScalingOrientation) -> UIImage? {
        // 1. Scale up the dest size to match the image's size
        let bounds = CGRect(origin: .zero, size: image.size)
        let cropSize = newSize.fitWithAspectRatio(destSize: image.size)
        let cropWidth = cropSize.width
        let cropHeight = cropSize.height
        var origin: CGPoint
        switch orientation {
        case .center:       origin = CGPoint(x: bounds.midX - cropWidth/2, y: bounds.midY - cropHeight/2)
        case .top:          origin = CGPoint(x: bounds.midX - cropWidth/2, y: 0)
        case .topRight:     origin = CGPoint(x: bounds.maxX - cropWidth, y: 0)
        case .right:        origin = CGPoint(x: bounds.maxX - cropWidth, y: bounds.midY - cropHeight/2)
        case .bottomRight:  origin = CGPoint(x: bounds.maxX - cropWidth, y: bounds.maxY - cropHeight)
        case .bottom:       origin = CGPoint(x: bounds.midX - cropWidth/2, y: bounds.maxY - cropHeight)
        case .bottomLeft:   origin = CGPoint(x: 0, y: bounds.maxY - cropHeight)
        case .left:         origin = CGPoint(x: 0, y: bounds.midY - cropHeight/2)
        case .topLeft:      origin = CGPoint(x: 0, y: 0)
        }
        let cropRect = CGRect(origin: origin, size: cropSize)
        let croppedImage = image.cropping(toRect: cropRect)
        // 2. Crop the image at full size
        // 3. Scale the cropped image down to final size
        let scaledSize = croppedImage.size.scalingWithAspectRatio(to: newSize)
        let imageScaled = imageWithImage(croppedImage, scaledToSize: scaledSize)
        return imageScaled
    }
    
    static func fromView(_ view: UIView, frame: CGRect? = nil) -> UIImage {
        let frame = frame ?? view.frame
        let renderer = UIGraphicsImageRenderer(size: frame.size)
        view.transform = view.transform.translatedBy(x: -frame.origin.x, y: -frame.origin.y)
        let renderedImage = renderer.image { context in
            view.layer.render(in: context.cgContext)
        }
        view.transform = view.transform.translatedBy(x: frame.origin.x, y: frame.origin.y)
        return renderedImage
    }
    
    func cropping(toRect rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        let renderedImage = renderer.image { context in
            context.cgContext.translateBy(x: -rect.minX, y: -rect.minY)
            let uncroppedBounds = CGRect(origin: .zero, size: self.size)
            self.draw(in: uncroppedBounds)
        }
        return renderedImage
    }
    
    func addingBorder(color: UIColor, thickness: CGFloat) -> UIImage {
        let rect = CGRect(origin: .zero, size: self.size).insetBy(dx: -thickness, dy: -thickness)
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        let renderedImage = renderer.image { context in
            context.cgContext.translateBy(x: thickness, y: thickness)
            context.cgContext.setFillColor(color.cgColor)
            context.cgContext.fill(rect)
            let bounds = CGRect(origin: .zero, size: self.size)
            self.draw(in: bounds)
        }
        return renderedImage
    }
    
    func invertedImage(bounds: CGRect? = nil) -> UIImage? {
        let bounds = bounds ?? CGRect(origin: .zero, size: self.size)
        let imageInverted: UIImage?
        let size = bounds.size
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.concatenate( CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
            context.draw(cgImage, in: CGRect(origin: .zero, size: size))
            imageInverted = UIGraphicsGetImageFromCurrentImageContext()
        } else {
            imageInverted = nil
        }
        UIGraphicsEndImageContext()
        return imageInverted
    }
    static let defaultHistogramColorCount = 1024
    func histogram(numberOfColors: Int = defaultHistogramColorCount) -> [Int]? {
        let histogramData: [Int]?
        if let filter = CIFilter(name: "CIAreaHistogram", parameters: [
            kCIInputImageKey: self,
            kCIInputScaleKey: 1,
        ]) {
            histogramData = filter.value(forKey: "outputData") as? [Int]
        } else {
            histogramData = nil
        }
        return histogramData
    }
    
    var desaturated: UIImage? {
        desaturate(toLevel: 0)
    }

    func desaturate(toLevel level: CGFloat) -> UIImage? {
        guard let cgImage = self.cgImage else {return nil}
        guard let filter = CIFilter(name: "CIColorControls") else {return nil}
        let ciImage = CIImage(cgImage: cgImage)
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(level, forKey: kCIInputSaturationKey)
        guard let result = filter.outputImage else {
            return nil
        }
        if let desaturatedCGImage = result.cgImage {
            let image = UIImage(cgImage: desaturatedCGImage)
            return image
        } else {
            let rect = CGRect(origin: .zero, size: self.size)
            if let desaturatedCGImage = CIContext().createCGImage(result, from: rect) {
                let image = UIImage(cgImage: desaturatedCGImage)
                return image
            }
        }
        return nil
    }
}
