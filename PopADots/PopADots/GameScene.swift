//
//  GameScene.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/11/15.
//  Copyright (c) 2015 Sirkles. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var circles:Array<TouchCircle>? = Array<TouchCircle>()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        /*
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        */
        
        self.scene?.backgroundColor = SKColor.whiteColor()
        
        let tempCircle: TouchCircle = TouchCircle()
        tempCircle.active = true
        
        self.circles?.append(tempCircle)
        self.addChild(tempCircle)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        /*
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
        */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        for var i = 0; i < self.circles!.count; ++i {
            self.circles?[i].update(currentTime)
        }
    }
}
