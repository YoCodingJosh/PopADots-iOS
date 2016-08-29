//
//  BadCircle.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/30/15.
//  Copyright © 2015-2016 Sirkles LLC. All rights reserved.
//

import Foundation
import SpriteKit

enum BadCircleState {
    case original, wiggle, voids
}

class BadCircle: TouchCircle {
    var state: BadCircleState = .original
    
    override init(myFrame: CGRect = Utils.getScreenResolution()) {
        super.init(myFrame: myFrame)
        
        self.fillColor = SKColor.black
    }
    
    init(radius: CGFloat, pos: CGPoint, xVel: CGFloat, yVel: CGFloat) {
        super.init(radius: radius, pos: pos, color: SKColor.black, xVel: xVel, yVel: yVel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateOriginal(_ currentTime: CFTimeInterval) {
        super.update(currentTime)
    }
    
    func updateWiggle(_ currentTime: CFTimeInterval) {
        print("Wigge bad circle update")
    }
    
    func updateVoids(_ currentTime: CFTimeInterval) {
        print("Voids bad circle update")
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        if !self.active {
            return
        }
        
        switch (state) {
        case .original:
            updateOriginal(currentTime)
        case .wiggle:
            updateWiggle(currentTime)
        case .voids:
            updateVoids(currentTime)
        }
    }
}
