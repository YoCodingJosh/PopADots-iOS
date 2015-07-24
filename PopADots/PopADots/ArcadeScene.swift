//
//  ArcadeScene.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 7/19/15.
//  Copyright © 2015 Sirkles LLC. All rights reserved.
//

import Foundation
import SpriteKit

class ArcadeScene: SKScene {
    var numCircles: UInt32 = 5
    var numBadCircles: UInt32 = 0
    var circles: Array<TouchCircle>? = Array<TouchCircle>()
    var badCircles: Array<BadCircle>? = Array<BadCircle>()
    var gameOver: Bool = false
    var gameOverScreenCreated: Bool = false
    var gameOverScreen: GameOverScreen?
    var score: UInt64 = 0
    var scoreLabel: SKLabelNode?
    var scoreShadowLabel: SKLabelNode?
    var newGame: Bool = true

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
        globalGameState = GameState.ArcadeMode
        
        startNewGame()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let myTouch: UITouch = touches.first!
        let touchLocation = myTouch.locationInNode(self)
        
        self.scoreLabel!.text = "Score: \(self.score)"
        self.scoreShadowLabel!.text = "Score: \(self.score)"
        
        if (gameOver && gameOverScreenCreated) {
            switch(gameOverScreen!.getUserChoice(touchLocation)) {
            case 0:
                // we don't it to go to default
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
                
                menu.bg = newBG // For some reason, I need to set this before transitioning. :\
                
                self.view?.presentScene(menu, transition: transition)
            default:
                fatalError("you should not be here")
            }
        }
        
        for var i = 0; i < self.circles!.count; ++i {
            if self.circles?[i].checkTouch(touchLocation) == true {
                self.circles?[i].removeFromParent()
                
                let bad: BadCircle = (self.circles?[i].convertToBad())!
                bad.velocity = (0, 0)
                bad.touchable = true
                
                self.badCircles!.append(bad)
                self.addChild(bad)
                
                self.circles?.removeAtIndex(i)
                
                self.score++
                
                return; // Don't want to trigger game over.
            }
        }
        
        for var i = 0; i < self.badCircles!.count; ++i {
            if self.badCircles![i].checkTouch(touchLocation) == true {
                self.gameOver = true
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
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
        
        for var i = 0; i < self.circles!.count; ++i {
            self.circles?[i].update(currentTime)
        }
        
        for var i = 0; i < self.badCircles!.count; ++i {
            self.badCircles?[i].update(currentTime)
        }

        checkGameState()
    }
    
    func resetGame() {
        self.removeAllChildren()
        
        self.numCircles = 5
        self.numBadCircles = 0
        
        self.score = 0
        
        self.circles!.removeAll()
        self.badCircles!.removeAll()
        
        self.gameOver = false
        self.gameOverScreenCreated = false
    }
    
    func startNewGame() {
        self.newGame = true
        self.backgroundColor = UIColor.whiteColor()
        
        self.gameOverScreen = GameOverScreen(myFrame: self.frame)
        
        self.scoreShadowLabel = SKLabelNode(fontNamed: "Orbitron Black")
        self.scoreShadowLabel!.fontSize = Utils.getScaledFontSize(19)
        self.scoreShadowLabel?.text = "Score: 0"
        self.scoreShadowLabel!.fontColor = UIColor.blackColor()
        self.scoreShadowLabel!.position.y = Utils.getScreenResolution().height - self.scoreShadowLabel!.fontSize
        self.scoreShadowLabel!.position.x += (self.scoreShadowLabel!.frame.width / 2)
        self.addChild(self.scoreShadowLabel!)
        
        self.scoreLabel = SKLabelNode(fontNamed: "Orbitron Medium")
        self.scoreLabel!.fontSize = Utils.getScaledFontSize(19)
        self.scoreLabel?.text = "Score: 0"
        self.scoreLabel!.fontColor = UIColor.whiteColor()
        self.scoreShadowLabel!.addChild(self.scoreLabel!)
        
        checkGameState()
    }
    
    func checkGameState() {
        if (self.circles?.count == 0) {
            if (numCircles > 1) {
                --numCircles
            }
            else {
                numCircles = 5
            }
            
            numBadCircles = 1 + UInt32(self.score) / 15
            
            generateCircles()
        }
    }
    
    func generateCircles() {
        /*
        for var i = 0; i < self.badCircles!.count; ++i {
            self.badCircles?[i].removeFromParent()
            self.badCircles!.removeAtIndex(i)
        }
        */
        
        for child in self.children {
            if child is TouchCircle || child is BadCircle {
                child.removeFromParent()
            }
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
