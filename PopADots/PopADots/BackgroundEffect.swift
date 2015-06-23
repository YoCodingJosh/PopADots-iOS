//
//  BackgroundEffect.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/21/15.
//  Copyright © 2015 Sirkles. All rights reserved.
//

import Foundation
import SpriteKit

// I'm not sure a SKShapeNode is the best way to do this... :\
class BackgroundEffect: SKShapeNode {
    required init(frame: CGRect) {
        super.init()
        
        let myPath: CGMutablePathRef = CGPathCreateMutable();
        CGPathAddRect(myPath, nil, frame);
        CGPathCloseSubpath(myPath);
        
        self.path = myPath
        
        self.strokeColor = SKColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func update(currentTime: NSTimeInterval) {
        // do nothing, just a placeholder to enforce design pattern
    }
}
