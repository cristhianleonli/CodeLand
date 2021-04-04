import UIKit
import Foundation

extension UIImage {
    func tintedImage(imageColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        context?.setBlendMode(.normal)
        context?.fill(rect)
        
        context?.setBlendMode(.normal)
        if let cgImage = cgImage {
            context?.draw(cgImage, in: rect)
            
            context?.setBlendMode(.sourceAtop)
            imageColor.setFill()
            context?.fill(rect)
            
            context?.setBlendMode(.destinationIn)
            context?.draw(cgImage, in: rect)
            
            let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return tintedImage ?? self
        }
        return self
    }
}
