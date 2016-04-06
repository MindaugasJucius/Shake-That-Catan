//
//  Extensions.swift
//  Shake That Catan
//
//  Created by Mindaugas Jucius on 24/02/16.
//  Copyright © 2016 mindawg. All rights reserved.
//

import Foundation
import UIKit

public extension Int {
    /// SwiftRandom extension
    public static func random(lower: Int = 1, _ upper: Int = 6) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}

extension UIColor {

    class func colorWithHex(hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let r = CGFloat((hex & 0xff0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00ff00) >>  8) / 255.0
        let b = CGFloat((hex & 0x0000ff) >>  0) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    class func flatColors() -> [UIColor] {
        return [turquoiseColor(), greenSeaColor(), emeraldColor(), nephritisColor(), peterRiverColor(), belizeHoleColor(), amethystColor(), wisteriaColor(), wetAsphaltColor(), midnightBlueColor(), sunFlowerColor(), flatOrangeColor(), carrotColor(), pumkinColor(), alizarinColor(), pomegranateColor(), cloudsColor(), silverColor(), asbestosColor(), concerteColor()];
    }
    
    // green sea
    class func turquoiseColor()    -> UIColor { return UIColor.colorWithHex(0x1abc9c) }
    class func greenSeaColor()     -> UIColor { return UIColor.colorWithHex(0x16a085) }
    // green
    class func emeraldColor()      -> UIColor { return UIColor.colorWithHex(0x2ecc71) }
    class func nephritisColor()    -> UIColor { return UIColor.colorWithHex(0x27ae60) }
    // blue
    class func peterRiverColor()   -> UIColor { return UIColor.colorWithHex(0x3498db) }
    class func belizeHoleColor()   -> UIColor { return UIColor.colorWithHex(0x2980b9) }
    // purple
    class func amethystColor()     -> UIColor { return UIColor.colorWithHex(0x9b59b6) }
    class func wisteriaColor()     -> UIColor { return UIColor.colorWithHex(0x8e44ad) }
    // dark blue
    class func wetAsphaltColor()   -> UIColor { return UIColor.colorWithHex(0x34495e) }
    class func midnightBlueColor() -> UIColor { return UIColor.colorWithHex(0x2c3e50) }
    // yellow
    class func sunFlowerColor()    -> UIColor { return UIColor.colorWithHex(0xf1c40f) }
    class func flatOrangeColor()   -> UIColor { return UIColor.colorWithHex(0xf39c12) }
    // orange
    class func carrotColor()       -> UIColor { return UIColor.colorWithHex(0xe67e22) }
    class func pumkinColor()       -> UIColor { return UIColor.colorWithHex(0xd35400) }
    // red
    class func alizarinColor()     -> UIColor { return UIColor.colorWithHex(0xe74c3c) }
    class func pomegranateColor()  -> UIColor { return UIColor.colorWithHex(0xc0392b) }
    // white
    class func cloudsColor()       -> UIColor { return UIColor.colorWithHex(0xecf0f1) }
    class func silverColor()       -> UIColor { return UIColor.colorWithHex(0xbdc3c7) }
    // gray
    class func asbestosColor()     -> UIColor { return UIColor.colorWithHex(0x7f8c8d) }
    class func concerteColor()     -> UIColor { return UIColor.colorWithHex(0x95a5a6) }
    
    func isLight() -> Bool
    {
        let components = CGColorGetComponents(self.CGColor)
        let firstComp = components[0]
        let secondComp = components[1]
        let thirdComp = components[2]
        
        let brightness = ((firstComp * 299) + (secondComp * 587) + (thirdComp * 114)) / 1000
        
        if brightness < 0.7
        {
            return false
        }
        else
        {
            return true
        }
    }
    
}

public extension CollectionType {
    public typealias ItemType = Self.Generator.Element
    public typealias Grouper = (ItemType, ItemType) -> Bool
    
    public func groupBy(grouper: Grouper) -> [[ItemType]] {
        var result : Array<Array<ItemType>> = []
        
        var previousItem: ItemType?
        var group = [ItemType]()
        
        for item in self {
            defer {previousItem = item}
            guard let previous = previousItem else {
                group.append(item)
                continue
            }
            if grouper(previous, item) {
                // Item in the same group
                group.append(item)
            } else {
                // New group
                result.append(group)
                group = [ItemType]()
                group.append(item)
            }
        }
        
        result.append(group)
        
        return result
    }
    
}

extension CollectionType where Self.Generator.Element: Comparable {
    public func uniquelyGroupBy(grouper: (Self.Generator.Element, Self.Generator.Element) -> Bool) -> [[Self.Generator.Element]] {
        let sorted = self.sort()
        return sorted.groupBy(grouper)
    }
}
