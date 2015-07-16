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
    var numCircles: UInt32 = 0
    var numBadCircles: UInt32 = 0
    var circles: Array<TouchCircle>? = Array<TouchCircle>()
    var badCircles: Array<BadCircle>? = Array<BadCircle>()
    var bg: RainbowEffect?
    var gameOver: Bool = false
    var gameOverScreenCreated: Bool = false
    var gameOverScreen: GameOverScreen?
    
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
        self.addChild(self.bg!)
        
        self.gameOverScreen = GameOverScreen(myFrame: self.frame)
        
        checkGameState()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let myTouch: UITouch = touches.first!
        let touchLocation = myTouch.locationInNode(self)
        
        if (gameOver && gameOverScreenCreated) {
            switch(gameOverScreen!.getUserChoice(touchLocation)) {
            case 0:
                // we don't it to go to default
                break
            case 1:
                print("restart game")
            case 2:
                print("go to main menu")
            default:
                print("god damn it swift, there are no other possible choices")
            }
        }
        
        for var i = 0; i < self.circles!.count; ++i {
            if self.circles?[i].checkTouch(touchLocation) == true {
                self.circles?[i].removeFromParent()
                self.circles?.removeAtIndex(i)
            }
        }
        
        for var i = 0; i < self.badCircles!.count; ++i {
            if self.badCircles?[i].checkTouch(touchLocation) == true {
                self.gameOver = true
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        /* Called before each frame is rendered */
        
        if gameOver {
            if gameOverScreenCreated {
                return
            }
            else {
                // create game over screen
                self.gameOverScreen!.position.x = 0
                self.gameOverScreen!.position.y = 0
                self.gameOverScreen!.zPosition = 10
                
                self.addChild(self.gameOverScreen!)
                
                self.gameOverScreen!.initialize()
                
                gameOverScreenCreated = true
            }
        }
        
        self.bg?.update(currentTime)
        
        for var i = 0; i < self.circles!.count; ++i {
            self.circles?[i].update(currentTime)
        }
        
        for var i = 0; i < self.badCircles!.count; ++i {
            self.badCircles?[i].update(currentTime)
        }
        
        self.checkGameState()
    }
    
    func checkGameState() {
        if self.circles!.count == 0 {
            ++numCircles
            
            if (numCircles == 1) {
                numBadCircles = 0
            }
            else if (numCircles <= 4) {
                numBadCircles = 1
            }
            else {
                numBadCircles = (numCircles) / 5 + 1;
            }
            
            generateCircles()
        }
    }
    
    func generateCircles() {
        for var i = 0; i < self.badCircles!.count; ++i {
            self.badCircles?[i].removeFromParent()
            self.badCircles!.removeAtIndex(i)
        }
        
        for var i: UInt32 = 0; i < self.numCircles; ++i {
            let tempCircle: TouchCircle = TouchCircle()
            tempCircle.active = true
            tempCircle.touchable = true
            
            tempCircle.zPosition = CGFloat(i)
            
            self.circles!.append(tempCircle)
            self.addChild(tempCircle)
        }
        
        for var i: UInt32 = 0; i < self.numBadCircles; ++i {
            let tempCircle: BadCircle = BadCircle()
            tempCircle.active = true
            tempCircle.touchable = true
            tempCircle.state = BadCircleState.Original
            
            tempCircle.zPosition = CGFloat(i)
            
            self.badCircles!.append(tempCircle)
            self.addChild(tempCircle)
        }
    }
}
