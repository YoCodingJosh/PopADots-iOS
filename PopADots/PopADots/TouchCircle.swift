//
//  TouchCircle.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/12/15.
//  Copyright © 2015-2016 Sirkles LLC. All rights reserved.
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
    
    var myFrame: CGRect = Utils.getScreenResolution()
    
    init(myFrame: CGRect = Utils.getScreenResolution()) {
        self.velocity = Utils.scaleVelocity(false)
        super.init()
        
        self.backgroundCircle = Circle(radius: self.radius + (self.radius / 20), pos: CGPoint(x: 0, y: 0), color: UIColor.black)
        
        self.backgroundCircle?.position = CGPoint(x: 0, y: 0)
        
        self.backgroundCircle?.zPosition = -1
        
        self.addChild(self.backgroundCircle!)
        
        self.myFrame = myFrame
    }
    
    init(radius: CGFloat, pos: CGPoint, color: SKColor, xVel: CGFloat, yVel: CGFloat, myFrame: CGRect = Utils.getScreenResolution()) {
        self.velocity = (xVel, yVel)
        super.init(radius: radius, pos: pos, color: color)
        
        self.backgroundCircle = Circle(radius: self.radius + (self.radius / 20), pos: CGPoint(x: 0, y: 0), color: UIColor.black)
        
        self.backgroundCircle?.position = CGPoint(x: 0, y: 0)
        
        self.backgroundCircle?.zPosition = -1
        
        self.addChild(self.backgroundCircle!)
        
        self.myFrame = myFrame
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
        self.backgroundCircle = Circle(radius: self.radius + (self.radius / 20), pos: CGPoint(x: 0, y: 0), color: UIColor.black)
        
        self.backgroundCircle?.position = CGPoint(x: 0, y: 0)
        
        self.backgroundCircle?.zPosition = -1
        
        self.addChild(self.backgroundCircle!)
    }
    
    func update(_ currentTime: CFTimeInterval) {
        if (!self.active) {
            return
        }
        
        if (self.position.x + velocity.xVel + radius >= self.myFrame.width) {
            self.velocity.xVel *= -1
            self.position.x = self.myFrame.width - self.radius
        }
        else if (self.position.x + velocity.xVel - radius <= 0) {
            self.velocity.xVel *= -1
            self.position.x = radius
        }
        
        if (self.position.y + velocity.yVel + radius >= self.myFrame.height) {
            self.velocity.yVel *= -1
            self.position.y = self.myFrame.height - self.radius
        }
        else if (self.position.y + velocity.yVel - radius <= 0) {
            self.velocity.yVel *= -1
            self.position.y = radius
        }
        
        // delta time is pretty confusing in SK.. :(
        self.position.x += velocity.xVel
        self.position.y += velocity.yVel
    }
    
    func checkTouch(_ touch: CGPoint) -> Bool {
        if (!self.touchable) {
            return false
        }
        
        let xDiff = (touch.x - self.position.x);
        let yDiff = (touch.y - self.position.y);
        
        return (xDiff * xDiff) + (yDiff * yDiff) < (self.radius * self.radius);
    }
    
    func resizeCircle(_ newRadius: CGFloat, scale: Bool = false) {
        self.radius = scale ? Utils.scaleRadius(newRadius) : newRadius
        super.setCirclePath()
        
        self.backgroundCircle?.radius = self.radius + (self.radius / 20)
        self.backgroundCircle?.setCirclePath()
    }
    
    /*
     * Note: this does not convert this instance into a BadCircle instance IN PLACE.
     *  That requires some magic that is waaaayyy out of scope of this function.
     */
    func convertToBad(_ state: BadCircleState = BadCircleState.original) -> BadCircle {
        let bad: BadCircle = BadCircle(radius: self.radius, pos: self.position, xVel: self.velocity.xVel, yVel: self.velocity.yVel)
        
        bad.state = state
        
        return bad
    }
    
    func checkCollision(_ circle: TouchCircle) -> Bool {
        let distX = circle.position.x - self.position.x
        let distY = circle.position.y - self.position.y
        let radii = circle.radius + self.radius
        
        return (distX * distX) + (distY * distY) < (radii * radii)
    }
}
