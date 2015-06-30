//
//  ClassicScene.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/16/15.
//  Copyright © 2015 Sirkles LLC. All rights reserved.
//

import Foundation
import SpriteKit

class ClassicScene: SKScene {
    var numCircles: UInt32 = 10
    var circles: Array<TouchCircle>? = Array<TouchCircle>()
    var bg: RainbowEffect?
    
    override init() {
        super.init()
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToView(view: SKView) {
        self.bg?.zPosition = -2
        //self.addChild(self.bg!)
        
        self.generateCircles()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let myTouch: UITouch = touches.first!
        let touchLocation = myTouch.locationInNode(self)
        
        for var i = 0; i < self.circles!.count; ++i {
            if self.circles?[i].checkTouch(touchLocation) == true {
                self.circles?[i].removeFromParent()
                self.circles?.removeAtIndex(i)
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        /* Called before each frame is rendered */
        
        self.bg?.update(currentTime)
        
        for var i = 0; i < self.circles!.count; ++i {
            self.circles?[i].update(currentTime)
        }
        
        if self.circles!.count == 0 {
            generateCircles()
        }
    }
    
    func generateCircles() {
        for var i: UInt32 = 0; i < self.numCircles; ++i {
            let tempCircle: TouchCircle = TouchCircle()
            tempCircle.active = true
            tempCircle.touchable = true
            
            tempCircle.zPosition = CGFloat(i)
            
            self.circles!.append(tempCircle)
            self.addChild(tempCircle)
        }
    }
}
