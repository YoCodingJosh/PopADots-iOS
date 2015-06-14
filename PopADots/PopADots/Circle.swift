//
//  Circle.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/11/15.
//  Copyright © 2015 Sirkles. All rights reserved.
//

import Foundation
import SpriteKit
import CoreGraphics

class Circle : SKShapeNode {
    /*
     * The internal radius used for physics and whatnot.
     * Never used internally to Circle, but used in it's derivatives.
     */
    var radius: CGFloat = 0
    
    /*
     * Random circle initializer.
     */
    override init() {
        super.init()
        
        self.radius = Utils.scaleRadius();
        self.fillColor = SKColor.greenColor() // Needs to be random.
        self.position.x = Utils.scaleXPos()
        self.position.y = Utils.scaleYPos()
        
        let myPath: CGMutablePathRef = CGPathCreateMutable();
        
        CGPathAddArc(myPath, nil, CGFloat(0.0), CGFloat(0.0), self.radius, CGFloat(0.0), CGFloat(M_PI * 2), true)
    
        self.path = myPath
    }
    
    init(radius: CGFloat, pos: CGPoint, color: SKColor) {
        super.init()
        
        self.radius = radius
        self.fillColor = color
        self.position = pos
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
}
