//
//  MenuCircle.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/17/15.
//  Copyright © 2015-2016 Sirkles LLC. All rights reserved.
//

import Foundation
import SpriteKit

class MenuCircle: TouchCircle {
    var text:String = "Label"
    var labelNode: SKLabelNode?
    var labelShadowNode: SKLabelNode?
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    init(radius: CGFloat, pos: CGPoint, color: SKColor, label: String = "Label") {
        super.init(radius: radius, pos: pos, color: color, xVel: 0, yVel: 0)
        
        self.text = label
    }
    
    func initialize() {
        self.name = self.text + " Menu Circle"
        
        self.labelNode = SKLabelNode(fontNamed: "Orbitron Medium")
        self.labelNode?.text = self.text
        self.labelNode?.fontSize = Utils.getScaledFontSize(23)
        self.labelNode?.color = SKColor.white
        self.labelNode?.position = CGPoint(x: 0, y: 0)
        self.labelNode?.zPosition = 10
        
        // Just in case...
        self.labelShadowNode = SKLabelNode(fontNamed: "Orbitron Medium")
        self.labelShadowNode?.text = self.text
        self.labelShadowNode?.fontSize = Utils.getScaledFontSize(23)
        self.labelShadowNode?.color = SKColor.black
        self.labelShadowNode?.position = CGPoint(x: 0, y: 0)
        self.labelShadowNode?.zPosition = 9
        
        self.active = false
        self.touchable = true
        
        self.addChild(self.labelNode!)
        //self.addChild(self.labelShadowNode!)
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        // do nothing
    }
}
