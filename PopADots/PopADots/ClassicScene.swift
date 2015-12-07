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
    var score: UInt64 = 0
    var scoreLabel: MKOutlinedLabelNode?
    var scoreShadowLabel: SKLabelNode?
    
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
        globalGameState = GameState.ClassicMode
        
        startNewGame()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let myTouch: UITouch = touches.first!
        let touchLocation = myTouch.locationInNode(self)
        
        if (gameOver && gameOverScreenCreated) {
            switch(gameOverScreen!.getUserChoice(touchLocation)) {
            case 0:
                // we don't want it to go to default
                break
            case 1:
                print("restart game")
                
                self.resetGame()
                self.startNewGame()
            case 2:
                print("go to main menu")
                
                let transition: SKTransition = SKTransition.fadeWithDuration(1)
                let menu: MainMenuScene = MainMenuScene(size: self.frame.size)
                let newBG: RainbowEffect = RainbowEffect(frame: self.frame)
                
                menu.backgroundColor = self.backgroundColor
                newBG.r = self.bg!.r
                newBG.g = self.bg!.g
                newBG.b = self.bg!.b
                newBG.color = self.bg!.color
                
                menu.bg = newBG
                
                self.view?.presentScene(menu, transition: transition)
            default:
                print("god damn it swift, there are no other possible choices")
            }
            
            return
        }
        
        for var i = 0; i < self.circles!.count; ++i {
            if self.circles?[i].checkTouch(touchLocation) == true {                
                self.circles?[i].removeFromParent()
                self.circles?.removeAtIndex(i)
                
                self.runAction(Utils.getPopSound())
                
                self.score++
                
                return
            }
        }
        
        for var i = 0; i < self.badCircles!.count; ++i {
            if self.badCircles?[i].checkTouch(touchLocation) == true {
                self.gameOver = true
                self.runAction(Utils.getBadPopSound())
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        /* Called before each frame is rendered */
        
        self.scoreLabel!.outlinedText = "\(self.score) pts"
        //self.scoreLabel!.outlinedText = "Score: \(self.score)"
        //self.scoreShadowLabel!.text = "Score: \(self.score)"
        
        if gameOver {
            if gameOverScreenCreated {
                return
            }
            else {
                // create game over screen
                self.gameOverScreen!.position.x = 0
                self.gameOverScreen!.position.y = 0
                self.gameOverScreen!.zPosition = 50
                
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
    
    func startNewGame() {
        self.bg?.zPosition = -2
        self.addChild(self.bg!)
        
        self.gameOverScreen = GameOverScreen(myFrame: self.frame)
        
        /*
        self.scoreShadowLabel = SKLabelNode(fontNamed: "Orbitron Black")
        self.scoreShadowLabel!.fontSize = Utils.getScaledFontSize(19) // or 20.5
        self.scoreShadowLabel?.text = "Score: 0"
        self.scoreShadowLabel!.fontColor = UIColor.blackColor()
        self.scoreShadowLabel!.position.y = Utils.getScreenResolution().height - self.scoreShadowLabel!.fontSize
        //self.scoreShadowLabel!.position.x += (self.scoreShadowLabel!.frame.width / 2) + 2
        self.scoreShadowLabel!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left;
        self.addChild(self.scoreShadowLabel!)
        */
        
        self.scoreLabel = MKOutlinedLabelNode(fontNamed: "Orbitron Medium", fontSize: Utils.getScaledFontSize(19))
        //self.scoreLabel!.fontSize = Utils.getScaledFontSize(19)
        self.scoreLabel!.outlinedText = "0 pts" // has to be less than 8 chars so it wont crash
        self.scoreLabel!.position.y = Utils.getScreenResolution().height - self.scoreLabel!.fontSize
        self.scoreLabel!.fontColor = UIColor.whiteColor()
        self.scoreLabel!.borderColor = UIColor.blackColor()
        self.scoreLabel!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left;
        //self.scoreShadowLabel!.addChild(self.scoreLabel!)
        self.addChild(self.scoreLabel!)
        
        checkGameState()
    }
    
    func resetGame() {
        self.removeAllChildren()
        
        self.numCircles = 0
        self.numBadCircles = 0
        
        self.score = 0
        
        self.circles!.removeAll()
        self.badCircles!.removeAll()
        
        self.gameOver = false
        self.gameOverScreenCreated = false
    }
}
