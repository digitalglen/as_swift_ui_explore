import CoreGraphics

public extension CGFloat {
    var rounded: CGFloat {
        var value = self * CGFloat(1000)
        value.round()
        return Double(value / 1000)
    }
}

public extension CGPoint {
    func adding(_ other: CGPoint) -> CGPoint {
        return offsetBy(x: other.x, y: other.y)
    }
    func subtracting(_ other: CGPoint) -> CGPoint {
        return offsetBy(x: -other.x, y: -other.y)
    }
    func twoDecimalPoints() -> CGPoint {
        return CGPoint(x: CGFloat(Int(x * 100)), y: CGFloat(Int(y * 100)))
    }
    func offsetBy(x: CGFloat = 0, y: CGFloat = 0) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
    var rounded: CGPoint {
        var x = self.x * CGFloat(1000)
        var y = self.y * CGFloat(1000)
        x.round()
        y.round()
        return CGPoint(x: Double(x / 1000),
                       y: Double(y / 1000))
    }
    var asInts: CGPoint {CGPoint( x: Int(x), y: Int(y) )}
    var shortDescription: String {"(\(asInts))"}
}

public extension CGRect {
    static func union(ofRects rects: [CGRect]) -> CGRect {
        var all = rects.first ?? CGRect.zero
        for rect in rects.dropFirst() {
            all = all.union(rect)
        }
        return all
    }
    
    var asInts: CGRect {CGRect( x: Int(origin.x), y: Int(origin.y), width: Int(width), height: Int(height) )}
    var shortDescription: String {"(\(asInts))"}
    
    var isTallerThanWide: Bool {width < height}
}

public extension CGSize {
    enum ScaleKind {case fitWidth, fitHeight}
    
    var printAsIntegers: String {
        "(\(Int(width)), \(Int(height)))"
    }
    
    var aspectRatio: CGFloat {self.width / self.height}
    func fitWithAspectRatio(destSize dest: CGSize) -> CGSize {
        if dest.aspectRatio > aspectRatio { // fit to height
            return CGSize(width: dest.height * aspectRatio, height: dest.height)
        } else { // fit to width
            return CGSize(width: dest.width, height: dest.width / aspectRatio)
        }
    }
    func fillWithAspectRatio(destSize dest: CGSize) -> CGSize {
        if dest.aspectRatio < aspectRatio { // fill to height
            return CGSize(width: dest.height * aspectRatio, height: dest.height)
        } else { // fill to width
            return CGSize(width: dest.width, height: dest.width / aspectRatio)
        }
    }
    
    func scaled(_ scale: CGFloat) -> CGSize {
        CGSize(width: width * scale, height: height * scale)
    }
    func scaledToInt(_ scale: CGFloat) -> CGSize {
//        let width = Int(width * scale + 0.4)
//        let height = Int(height * scale + 0.4)
        CGSize(width: Int(width * scale + 0.1), height: Int(height * scale + 0.1))
    }

    func scalingWithAspectRatio(to destSize: CGSize) -> CGSize {
        if aspectRatio == 1  { // image is square
            let side = min(destSize.width, destSize.height)
            return CGSize(width: side, height: side)
        }

        let isTallerThanWide = aspectRatio < 1
        let isWiderThanTall = aspectRatio > 1
        let isTooTallToFit = self.height > destSize.height
        let isTooWideToFit = self.width > destSize.width
        let scalingToPortrait = destSize.width < destSize.height
        let scaleKind: ScaleKind
        if isTallerThanWide {
            if isTooTallToFit {
                scaleKind = .fitHeight
            } else if isTooWideToFit {
                scaleKind = .fitWidth
            } else {
                scaleKind = scalingToPortrait ? .fitHeight : .fitWidth
            }
        } else if isWiderThanTall {
            if isTooWideToFit {
                scaleKind = .fitWidth
            } else if isTooTallToFit {
                scaleKind = .fitHeight
            } else if scalingToPortrait {
                scaleKind = .fitWidth
            } else {
                let proposedHeight = destSize.width / aspectRatio
                if proposedHeight > destSize.height {
                    scaleKind = .fitHeight
                } else {
                    scaleKind = .fitWidth
                }
            }
        } else {
            scaleKind = .fitWidth
        }
        switch scaleKind {
        case .fitWidth:     return CGSize(width: destSize.width, height: destSize.width / aspectRatio)
        case .fitHeight:    return CGSize(width: destSize.height * aspectRatio, height: destSize.height)
        }
    }
}
