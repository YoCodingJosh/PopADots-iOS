//
//  FlashyScore.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 7/30/15.
//  Copyright © 2015-2016 Sirkles LLC. All rights reserved.
//

import Foundation
import SpriteKit

// When a circle is tapped, this score will be like flashy
// and colourful and says how many points were earned.

class FlashyScore: SKShapeNode
{
    var scoreLabel: SKLabelNode?
    
    var flashing: Bool = false
    var fadingOut: Bool = false
    var done: Bool = false
    
    init(score: String) {
        super.init()
        
        self.scoreLabel = SKLabelNode(fontNamed: "Orbitron Black")
        self.scoreLabel!.text = score
        self.scoreLabel!.color = UIColor.black
        self.scoreLabel!.fontSize = 55
        self.scoreLabel!.position = CGPoint(x: 0, y: 0)
        self.scoreLabel!.zPosition = self.zPosition
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        self.flashing = true
        //self.runAction(SKAction.moveByX(0, y: 50.0, duration: 1.0))
    }
    
    func update(_ currentTime: TimeInterval) {
        
    }
}
