//
//  MenuCircle.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/17/15.
//  Copyright © 2015 Sirkles. All rights reserved.
//

import Foundation
import SpriteKit

class MenuCircle: TouchCircle {
    var text:String = "Label"
    var labelNode: SKLabelNode?
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    init(radius: CGFloat, pos: CGPoint, color: SKColor, label: String = "Label") {
        super.init(radius: radius, pos: pos, color: color, xVel: 0, yVel: 0)
        
        self.text = label
        
        self.labelNode = SKLabelNode(fontNamed: "Orbitron Medium")
        self.labelNode?.text = self.text
        self.labelNode?.fontSize = Utils.getScaledFontSize(23)
        self.labelNode?.color = SKColor.whiteColor()
        self.labelNode?.position = pos
        self.labelNode?.yScale = -1
        
        self.active = false
        
        self.addChild(self.labelNode!)
    }
    
    func setLabel(labelText: String) {
        self.text = labelText
        self.labelNode?.text = self.text
    }
    
    override func update(currentTime: CFTimeInterval) {
        // do nothing
    }
}
