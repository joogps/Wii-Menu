//
//  CGImage.swift
//  Wii Menu
//
//  Created by João Gabriel Pozzobon dos Santos on 22/04/21.
//

import CoreGraphics
import Cocoa
import CoreImage.CIFilterBuiltins

extension CGImage {
    static func stripes(colors: (NSColor, NSColor), width: CGFloat, ratio: CGFloat) -> CGImage {
        let filter = CIFilter.stripesGenerator()
        
        filter.color0 = CIColor(color: colors.0)!
        filter.color1 = CIColor(color: colors.1)!
        filter.width = Float(width-width*ratio)
        filter.center = CGPoint(x: width, y: 0)
        
        let size = CGSize(width: width+width*ratio, height: 1)
        let bounds = CGRect(origin: .zero, size: size)
        return CIContext().createCGImage(filter.outputImage!.clamped(to: bounds), from: bounds)!
    }
    
    static func random(bounds: CGRect) -> CGImage {
        let filter = CIFilter.randomGenerator()
        return CIContext().createCGImage(filter.outputImage!, from: bounds)!
    }
}
