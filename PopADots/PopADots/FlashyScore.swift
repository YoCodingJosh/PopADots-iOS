//
//  FlashyScore.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 7/30/15.
//  Copyright © 2015 Sirkles LLC. All rights reserved.
//

import Foundation
import SpriteKit

// When a circle is tapped, this score will be like flashy
// and colourful and says how many points were earned.

class FlashyScore: SKNode
{
    var scoreLabel: SKLabelNode?
    
    init(score: String) {
        super.init()
        
        self.scoreLabel = SKLabelNode(fontNamed: "Orbitron Black")
        self.scoreLabel!.text = score;
        self.scoreLabel!.fontSize = 55;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(currentTime: NSTimeInterval) {
        
    }
}
