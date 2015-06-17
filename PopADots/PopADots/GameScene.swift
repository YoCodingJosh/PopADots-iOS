//
//  GameScene.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/11/15.
//  Copyright (c) 2015 Sirkles. All rights reserved.
//

import SpriteKit

enum GameState {
    case MainMenu, ClassicMode, ArcadeMode, VoidsMode
}

class GameScene: SKScene {
    var numCircles:UInt32 = 10
    var circles:Array<TouchCircle>? = Array<TouchCircle>()
    
    var gameState: GameState = GameState.MainMenu;
    
    override func didMoveToView(view: SKView) {
        self.scene?.backgroundColor = SKColor.whiteColor()
        
        self.generateCircles()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        // We only want one touch (unless we want multi-touch)
        let myTouch: UITouch = touches.first!
        let touchLocation = myTouch.locationInNode(self)
        
        for var i = 0; i < self.circles!.count; ++i {
            if self.circles?[i].checkTouch(touchLocation) == true {
                self.circles?[i].removeFromParent()
                self.circles?.removeAtIndex(i)
            }
        }
        
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
        
        if self.circles!.count == 0 {
            generateCircles()
        }
    }
    
    func generateCircles() {
        for var i:UInt32 = 0; i < self.numCircles; ++i {
            let tempCircle: TouchCircle = TouchCircle()
            tempCircle.active = true
            tempCircle.touchable = true
            
            self.circles?.append(tempCircle)
            self.addChild(tempCircle)
        }
    }
}
