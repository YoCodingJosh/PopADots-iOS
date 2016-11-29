//
//  GameOverScreen.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 7/6/15.
//  Copyright © 2015-2016 Sirkles LLC. All rights reserved.
//

import Foundation
import CoreGraphics
import SpriteKit

struct GameData {
    // score
    var score: Int64 = 0
    
    // time in game
    // TODO:
    
    // circles popped
    var numCirclesPopped: Int64 = 0
    
    // game mode
    var gameState: GameState
    
    // etc. for analytics and score posting.
}

// Note that this isn't a SKScene, but a normal SKShapeNode.
// SpriteKit somehow doesn't support overlapping scene graphs,
// so this is a way to skirt around that. :)
class GameOverScreen: SKShapeNode {
    var myFrame: CGRect = Utils.getScreenResolution()
    var myData: GameData? = GameData(score: 0, numCirclesPopped: 0, gameState: GameState.None)
    var background: BackgroundEffect?
    
    var restartCircle: MenuCircle = MenuCircle(radius: Utils.scaleRadius(225), pos: CGPoint(x: Utils.getScreenResolution().width / 4, y: Utils.getScreenResolution().height / 6), color: Utils.getColor(1), label: "Restart")
    
    var menuCircle: MenuCircle = MenuCircle(radius: Utils.scaleRadius(225), pos: CGPoint(x: Utils.getScreenResolution().width - (Utils.getScreenResolution().width / 4), y: Utils.getScreenResolution().height / 6), color: Utils.getColor(8), label: "Menu")
    
    var highScoreLabel: SKLabelNode?
    var userScoreLabel: SKLabelNode?
    
    init(myFrame: CGRect) {
        super.init()
        
        self.myFrame = myFrame
        
        // Construct the frame of this node.
        let myPath: CGMutablePath = CGMutablePath();
        myPath.addRect(self.myFrame);
        myPath.closeSubpath();
        
        self.path = myPath
        
        self.strokeColor = SKColor.clear
        
        self.background = BackgroundEffect(frame: self.frame)
        self.background!.fillColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 212/255.0)
        self.background!.zPosition = -2
        
        self.addChild(background!)
        self.addChild(restartCircle)
        self.addChild(menuCircle)
        
    }
    
    func initialize(data: GameData? = nil) {
        restartCircle.position = convert(restartCircle.position, from: self.parent!)
        menuCircle.position = convert(menuCircle.position, from: self.parent!)
        
        restartCircle.initialize()
        menuCircle.initialize()
        
        restartCircle.labelNode?.fontSize = Utils.getScaledFontSize(19)
        menuCircle.labelNode?.fontSize = Utils.getScaledFontSize(19)
        
        globalGameState = GameState.GameOver
        
        self.myData = data!
        
        let highScore = ScoreCipher.getScore(mode: self.myData!.gameState)
        var isNewHighScore: Bool = false
        
        if (self.myData!.score > highScore) {
            ScoreCipher.setScore(score: self.myData!.score, mode: self.myData!.gameState)
            isNewHighScore = true
        }
        
        self.userScoreLabel = SKLabelNode(fontNamed: "Orbitron Medium")
        self.userScoreLabel?.text = (isNewHighScore ? "New Score: " : "Your Score: ") + String(describing: self.myData!.score)
        self.userScoreLabel?.fontColor = SKColor.black
        self.userScoreLabel?.fontSize = Utils.getScaledFontSize(23)
        self.userScoreLabel?.position = CGPoint(x: Utils.getScreenResolution().width / 2, y: (Utils.getScreenResolution().height / 4) - ((Utils.getScreenResolution().height / 6) - (Utils.getScreenResolution().height / 4)))
        
        
        self.highScoreLabel = SKLabelNode(fontNamed: "Orbitron Medium")
        self.highScoreLabel?.text = (isNewHighScore ? "Old Score: " : "High Score: ") + String(describing: highScore)
        self.highScoreLabel?.fontColor = SKColor.black
        self.highScoreLabel?.fontSize = Utils.getScaledFontSize(23)
        self.highScoreLabel?.position = CGPoint(x: Utils.getScreenResolution().width / 2, y: (Utils.getScreenResolution().height / 4) - ((Utils.getScreenResolution().height / 6) - (Utils.getScreenResolution().height / 3)))
        
        var congratsLabel: SKLabelNode? = nil
        
        if (isNewHighScore) {
            congratsLabel = SKLabelNode(fontNamed: "Orbitron Medium")
            congratsLabel?.text = "You got a new high score!"
            congratsLabel?.fontSize = Utils.getScaledFontSize(20)
            congratsLabel?.fontColor = SKColor.black
            congratsLabel?.position = CGPoint(x: Utils.getScreenResolution().width / 2, y: Utils.getScreenResolution().height / 2)
            
            
            self.addChild(congratsLabel!)
        }
        
        self.addChild(userScoreLabel!)
        self.addChild(highScoreLabel!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // returns:
    //  0 if the user hasn't touched a button
    //  1 if the user wants to retry
    //  2 if the user wants to go back to the menu
    func getUserChoice(_ touch: CGPoint) -> Int {
        if (restartCircle.checkTouch(touch)) {
            return 1
        }
        
        if (menuCircle.checkTouch(touch)) {
            return 2
        }
        
        return 0
    }
}
