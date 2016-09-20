//
//  VoidsScene.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 7/24/15.
//  Copyright © 2015-2016 Sirkles LLC. All rights reserved.
//

import Foundation
import SpriteKit

class VoidsScene: SKScene {
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
        globalGameState = GameState.Voids
        
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
                
                //self.resetGame()
                self.startNewGame()
            case 2:
                print("go to main menu")
                
                let transition: SKTransition = SKTransition.fade(withDuration: 1)
                let menu: MainMenuScene = MainMenuScene(size: self.frame.size)
                let newBG: RainbowEffect = RainbowEffect(frame: self.frame)
                
                menu.bg = newBG // For some reason, I need to set this before transitioning. :\
                
                self.view?.presentScene(menu, transition: transition)
            default:
                fatalError("you should not be here")
            }
            
            return
        }
    }
    
    func generateCircles() {
        for child in self.children {
            if child is TouchCircle || child is BadCircle {
                child.removeFromParent()
            }
        }
        
        for i: UInt32 in 0 ..< self.numCircles {
            let tempCircle: TouchCircle = TouchCircle()
            tempCircle.active = true
            tempCircle.touchable = true
            
            tempCircle.zPosition = CGFloat(i)
            
            self.circles!.append(tempCircle)
            self.addChild(tempCircle)
        }
        
        for i: UInt32 in 0 ..< self.numBadCircles {
            let tempCircle: BadCircle = BadCircle()
            tempCircle.active = true
            tempCircle.touchable = true
            tempCircle.state = BadCircleState.original
            
            tempCircle.zPosition = CGFloat(i)
            
            self.badCircles!.append(tempCircle)
            self.addChild(tempCircle)
        }
    }

    
    func checkGameState() {
        if (self.circles?.count == 0) {
            if (numCircles > 1) {
                numCircles -= 1
            }
            else {
                numCircles = 5
            }
            
            numBadCircles = 1 + UInt32(self.score) / 15
            
            generateCircles()
        }
    }
    
    func startNewGame() {
        self.backgroundColor = UIColor.white
        
        self.gameOverScreen = GameOverScreen(myFrame: self.frame)
        
        self.scoreShadowLabel = SKLabelNode(fontNamed: "Orbitron Black")
        self.scoreShadowLabel!.fontSize = Utils.getScaledFontSize(19) // or 20.5
        self.scoreShadowLabel?.text = "Score: 0"
        self.scoreShadowLabel!.fontColor = UIColor.black
        self.scoreShadowLabel!.position.y = Utils.getScreenResolution().height - self.scoreShadowLabel!.fontSize
        //self.scoreShadowLabel!.position.x += (self.scoreShadowLabel!.frame.width / 2) + 2
        self.scoreShadowLabel!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left;
        self.addChild(self.scoreShadowLabel!)
        
        self.scoreLabel = SKLabelNode(fontNamed: "Orbitron Medium")
        self.scoreLabel!.fontSize = Utils.getScaledFontSize(19)
        self.scoreLabel?.text = "Score: 0"
        self.scoreLabel!.fontColor = UIColor.white
        self.scoreLabel!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left;
        self.scoreShadowLabel!.addChild(self.scoreLabel!)
        
        checkGameState()
    }
    
    override func update(_ currentTime: TimeInterval) {
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
        
        for i in 0 ..< self.circles!.count {
            self.circles?[i].update(currentTime)
        }
        
        for i in 0 ..< self.badCircles!.count {
            self.badCircles?[i].update(currentTime)
        }
        
        self.checkGameState()
    }
}
