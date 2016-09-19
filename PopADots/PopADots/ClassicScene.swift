//
//  ClassicScene.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/16/15.
//  Copyright © 2015-2016 Sirkles LLC. All rights reserved.
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
    var score: Int64 = 0
    var scoreLabel: MKOutlinedLabelNode?
    var scoreShadowLabel: SKLabelNode?
    var numCirclesPopped: Int64 = 0
    
    override init() {
        super.init()
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        globalGameState = GameState.classicMode
        
        startNewGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let myTouch: UITouch = touches.first!
        let touchLocation = myTouch.location(in: self)
        
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
                
                let menu: MainMenuScene = MainMenuScene(size: self.frame.size)
                let newBG: RainbowEffect = RainbowEffect(frame: self.frame)
                
                menu.backgroundColor = self.backgroundColor
                newBG.r = self.bg!.r
                newBG.g = self.bg!.g
                newBG.b = self.bg!.b
                newBG.color = self.bg!.color
                
                menu.bg = newBG
                
                self.removeAllChildren()
                
                self.view?.presentScene(menu)
            default:
                print("god damn it swift, there are no other possible choices")
            }
            
            return
        }
        
        for i in 0..<self.circles!.count {
            if self.circles?[i].checkTouch(touchLocation) == true {                
                self.circles?[i].removeFromParent()
                self.circles?.remove(at: i)
                
                self.run(Utils.getPopSound())
                
                self.score += 1
                self.numCirclesPopped += 1;
                
                return
            }
        }
        
        for i in 0..<self.badCircles!.count {
            if self.badCircles?[i].checkTouch(touchLocation) == true {
                self.gameOver = true
                self.run(Utils.getBadPopSound())
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
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
                
                // Send the data for this session to the game over screen.
                self.gameOverScreen!.myData?.numCirclesPopped = self.numCirclesPopped
                self.gameOverScreen!.myData?.score = self.score
                self.gameOverScreen!.myData?.gameState = GameState.classicMode
                
                self.gameOverScreen!.initialize()
                
                gameOverScreenCreated = true
            }
        }
        
        self.scoreLabel!.outlinedText = "\(self.score)"
        
        self.bg?.update(currentTime)
        
        for i in 0..<self.circles!.count {
            self.circles?[i].update(currentTime)
        }
        
        for i in 0..<self.badCircles!.count {
            self.badCircles?[i].update(currentTime)
        }
        
        self.checkGameState()
    }
    
    func checkGameState() {
        if self.circles!.count == 0 {
            numCircles += 1
            
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
        /*
        // Crashes! Array access out of bounds. Why?! wtf
        for var i in 0..<self.badCircles!.count {
            self.badCircles![i].removeFromParent()
            self.badCircles!.removeAtIndex(i)
        }
        */
        
        // A bit more inefficent, as it takes two passes rather than one.
        // At least it doesn't crash! :^)
        self.removeChildren(in: self.badCircles!)
        self.badCircles!.removeAll();
        
        for i in 0..<self.numCircles {
            let tempCircle: TouchCircle = TouchCircle()
            tempCircle.active = true
            tempCircle.touchable = true
            
            tempCircle.zPosition = CGFloat(i)
            
            self.circles!.append(tempCircle)
            self.addChild(tempCircle)
        }
        
        for  i in 0..<self.numBadCircles {
            let tempCircle: BadCircle = BadCircle()
            tempCircle.active = true
            tempCircle.touchable = true
            tempCircle.state = BadCircleState.original
            
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
        
        self.scoreLabel = MKOutlinedLabelNode(fontNamed: "Orbitron-Medium", fontSize: Utils.getScaledFontSize(19))
        //self.scoreLabel!.fontSize = Utils.getScaledFontSize(19)
        self.scoreLabel!.outlinedText = "0" // has to be less than 8 chars so it wont crash
        self.scoreLabel!.position.y = Utils.getScreenResolution().height - self.scoreLabel!.fontSize
        self.scoreLabel!.fontColor = UIColor.white
        self.scoreLabel!.borderColor = UIColor.black
        self.scoreLabel!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left;
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
