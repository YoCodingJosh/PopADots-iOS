//
//  TouchCircle.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/12/15.
//  Copyright © 2015 Sirkles. All rights reserved.
//

import Foundation
import SpriteKit

class TouchCircle : Circle {
    /*
     * The velocity of the circle represented by a tuple of (CGFloat, CGFloat)
     */
    var velocity = (xVel: CGFloat(0.0), yVel: CGFloat(0.0))
    
    var active: Bool = false
    
    override init() {
        self.velocity = Utils.scaleVelocity(false)
        print("velocity is: \(self.velocity)\n")
        super.init()
    }
    
    init(radius: CGFloat, pos: CGPoint, color: SKColor, xVel: CGFloat, yVel: CGFloat) {
        self.velocity = (xVel, yVel)
        super.init(radius: radius, pos: pos, color: color)
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func update(currentTime: CFTimeInterval) {
        if (!self.active) {
            return
        }
        
        if (self.position.x + velocity.xVel + radius >= Utils.getScreenResolution().width) {
            self.velocity.xVel *= -1
            self.position.x = Utils.getScreenResolution().width - self.radius
        }
        else if (self.position.x + velocity.xVel - radius <= 0) {
            self.velocity.xVel *= -1
            self.position.x = radius
        }
        
        if (self.position.y + velocity.yVel + radius >= Utils.getScreenResolution().height) {
            self.velocity.yVel *= -1
            self.position.y = Utils.getScreenResolution().height - self.radius
        }
        else if (self.position.y + velocity.yVel - radius <= 0) {
            self.velocity.yVel *= -1
            self.position.y = radius
        }
        
        // delta time is pretty confusing in SK.. :(
        self.position.x += velocity.xVel
        self.position.y += velocity.yVel
    }
    
    func checkTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool{
        return false
    }
}
