//
//  BadCircle.swift
//  PopADots
//
//  Created by Josh Kennedy on 6/30/15.
//  Copyright © 2015 Sirkles LLC. All rights reserved.
//

import Foundation
import SpriteKit

enum BadCircleState {
    case Original, Wiggle, Voids
}

class BadCircle: TouchCircle {
    var state: BadCircleState = .Original
    
    override init() {
        super.init()
        
        self.fillColor = SKColor.blackColor()
    }
    
    init(radius: CGFloat, pos: CGPoint, xVel: CGFloat, yVel: CGFloat) {
        super.init(radius: radius, pos: pos, color: SKColor.blackColor(), xVel: xVel, yVel: yVel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateOriginal(currentTime: CFTimeInterval) {
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
        
        self.position.x += velocity.xVel
        self.position.y += velocity.yVel
    }
    
    func updateWiggle(currentTime: CFTimeInterval) {
        print("Wigge bad circle update")
    }
    
    func updateVoids(currentTime: CFTimeInterval) {
        print("Voids bad circle update")
    }
    
    override func update(currentTime: CFTimeInterval) {
        switch (state) {
        case .Original:
            updateOriginal(currentTime)
        case .Wiggle:
            updateWiggle(currentTime)
        case .Voids:
            updateVoids(currentTime)
        }
    }
}
