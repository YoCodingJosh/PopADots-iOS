//
//  TouchCircle.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/12/15.
//  Copyright © 2015 Sirkles LLC. All rights reserved.
//

import Foundation
import SpriteKit

class TouchCircle : Circle {
    /*
     * The velocity of the circle represented by a tuple of (CGFloat, CGFloat)
     */
    var velocity = (xVel: CGFloat(0.0), yVel: CGFloat(0.0))
    
    var backgroundCircle: Circle?
    
    var active: Bool = false
    var touchable: Bool = false
    
    override init() {
        self.velocity = Utils.scaleVelocity(false)
        super.init()
        
        self.backgroundCircle = Circle(radius: self.radius + (self.radius / 20), pos: CGPointMake(0, 0), color: UIColor.blackColor())
        
        self.backgroundCircle?.position = CGPointMake(0, 0)
        
        self.backgroundCircle?.zPosition = -1
        
        self.addChild(self.backgroundCircle!)
    }
    
    init(radius: CGFloat, pos: CGPoint, color: SKColor, xVel: CGFloat, yVel: CGFloat) {
        self.velocity = (xVel, yVel)
        super.init(radius: radius, pos: pos, color: color)
        
        self.backgroundCircle = Circle(radius: self.radius + (self.radius / 20), pos: CGPointMake(0, 0), color: UIColor.blackColor())
        
        self.backgroundCircle?.position = CGPointMake(0, 0)
        
        self.backgroundCircle?.zPosition = -1
        
        self.addChild(self.backgroundCircle!)
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
        self.backgroundCircle = Circle(radius: self.radius + (self.radius / 20), pos: CGPointMake(0, 0), color: UIColor.blackColor())
        
        self.backgroundCircle?.position = CGPointMake(0, 0)
        
        self.backgroundCircle?.zPosition = -1
        
        self.addChild(self.backgroundCircle!)
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
    
    func checkTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        if (!self.touchable) {
            return false
        }
        
        print("not implemented :P")
        
        return false
    }
    
    func checkTouch(touch: CGPoint) -> Bool {
        if (!self.touchable) {
            return false
        }
        
        return ((touch.x - self.position.x) * (touch.x - self.position.x)) + ((touch.y - self.position.y) * (touch.y - self.position.y)) < ((self.radius * self.radius));
    }
}
