//
//  BadCircle.swift
//  Pop a Dots
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
    
    override init(myFrame: CGRect = Utils.getScreenResolution()) {
        super.init(myFrame: myFrame)
        
        self.fillColor = SKColor.blackColor()
    }
    
    init(radius: CGFloat, pos: CGPoint, xVel: CGFloat, yVel: CGFloat) {
        super.init(radius: radius, pos: pos, color: SKColor.blackColor(), xVel: xVel, yVel: yVel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateOriginal(currentTime: CFTimeInterval) {
        super.update(currentTime)
    }
    
    func updateWiggle(currentTime: CFTimeInterval) {
        print("Wigge bad circle update")
    }
    
    func updateVoids(currentTime: CFTimeInterval) {
        print("Voids bad circle update")
    }
    
    override func update(currentTime: CFTimeInterval) {
        if !self.active {
            return
        }
        
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
