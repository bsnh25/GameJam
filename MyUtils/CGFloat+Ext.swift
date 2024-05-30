//
//  CGFloat+Ext.swift
//  GameJam
//
//  Created by Bayu Septyan Nur Hidayat on 30/05/2024.
//

import CoreGraphics

extension CGFloat {
    
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF)) //return 0, 1
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min //return min or max
    }
}
