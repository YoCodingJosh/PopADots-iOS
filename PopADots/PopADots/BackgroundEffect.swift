//
//  BackgroundEffect.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/21/15.
//  Copyright © 2015-2016 Sirkles LLC. All rights reserved.
//

import Foundation
import SpriteKit

// I'm not sure a SKShapeNode is the best way to do this... :\
class BackgroundEffect: SKShapeNode {
    required init(frame: CGRect) {
        super.init()
        
        let myPath: CGMutablePath = CGMutablePath();
        myPath.addRect(frame);
        myPath.closeSubpath();
        
        self.path = myPath
        
        self.strokeColor = SKColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func update(_ currentTime: TimeInterval) {
        // do nothing, just a placeholder to enforce design pattern
    }
}
