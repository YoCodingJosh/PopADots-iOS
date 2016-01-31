//
//  GameOverScreen.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 7/6/15.
//  Copyright © 2015 Sirkles LLC. All rights reserved.
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
    var background: BackgroundEffect? // I'm too fucking lazy to figure out a better way. :P
    
    var restartCircle: MenuCircle = MenuCircle(radius: Utils.scaleRadius(225), pos: CGPointMake(Utils.getScreenResolution().width / 4, Utils.getScreenResolution().height / 6), color: Utils.getColor(1), label: "Restart")
    
    var menuCircle: MenuCircle = MenuCircle(radius: Utils.scaleRadius(225), pos: CGPointMake(Utils.getScreenResolution().width - (Utils.getScreenResolution().width / 4), Utils.getScreenResolution().height / 6), color: Utils.getColor(8), label: "Menu") // used to be 4
    
    init(myFrame: CGRect, myData: GameData? = nil) {
        super.init()
        
        self.myFrame = myFrame
        
        let myPath: CGMutablePathRef = CGPathCreateMutable();
        CGPathAddRect(myPath, nil, self.myFrame);
        CGPathCloseSubpath(myPath);
        
        self.path = myPath
        
        self.strokeColor = SKColor.clearColor()
        
        self.background = BackgroundEffect(frame: self.frame)
        self.background!.fillColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 150/255.0)
        self.background!.zPosition = -2
        
        self.myData = myData
        
        self.addChild(background!)
        self.addChild(restartCircle)
        self.addChild(menuCircle)
    }
    
    func initialize() {
        restartCircle.position = convertPoint(restartCircle.position, fromNode: self.parent!)
        menuCircle.position = convertPoint(menuCircle.position, fromNode: self.parent!)
        
        restartCircle.initialize()
        menuCircle.initialize()
        
        restartCircle.labelNode?.fontSize = Utils.getScaledFontSize(19)
        menuCircle.labelNode?.fontSize = Utils.getScaledFontSize(19)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // returns:
    //  0 if the user hasn't touched a button
    //  1 if the user wants to retry
    //  2 if the user wants to go back to the menu
    func getUserChoice(touch: CGPoint) -> Int {
        if (restartCircle.checkTouch(touch)) {
            return 1
        }
        
        if (menuCircle.checkTouch(touch)) {
            return 2
        }
        
        return 0
    }
}
