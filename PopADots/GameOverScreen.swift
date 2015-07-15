//
//  GameOverScreen.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 7/6/15.
//  Copyright © 2015 Sirkles. All rights reserved.
//

import Foundation
import CoreGraphics
import SpriteKit

struct GameData {
    // score
    // time in game
    // circles popped
    // game mode
    // etc. for analytics and score posting.
}

// Note that this isn't a SKScene, but a normal SKShapeNode.
// SpriteKit somehow doesn't support overlapping scene graphs,
// so this is a way to skirt around that. :)
class GameOverScreen: SKShapeNode {
    var myFrame: CGRect = Utils.getScreenResolution()
    var myData: GameData?
    var background: BackgroundEffect? // I'm too fucking lazy to figure out a better way. :P
    
    var restartCircle: MenuCircle = MenuCircle(radius: Utils.scaleRadius(225), pos: CGPointMake(Utils.getScreenResolution().width / 4, Utils.getScreenResolution().height / 6), color: Utils.getColor(1), label: "Restart")
    
    var menuCircle: MenuCircle = MenuCircle(radius: Utils.scaleRadius(225), pos: CGPointMake(Utils.getScreenResolution().width - (Utils.getScreenResolution().width / 6), Utils.getScreenResolution().height - (Utils.getScreenResolution().height / 4)), color: Utils.getColor(4), label: "Menu")
    
    init(myFrame: CGRect, myData: GameData? = nil) {
        super.init()
        
        self.myFrame = myFrame
        
        let myPath: CGMutablePathRef = CGPathCreateMutable();
        CGPathAddRect(myPath, nil, self.myFrame);
        CGPathCloseSubpath(myPath);
        
        self.path = myPath
        
        self.strokeColor = SKColor.clearColor()
        
        //self.fillColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 150/255.0)
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
        
        restartCircle.labelNode?.fontSize = Utils.getScaledFontSize(19)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // returns:
    //  0 if the user hasn't done anything yet
    //  1 if the user wants to retry
    //  2 if the user wants to go back to the menu
    func getUserInput() -> Int {
        //TODO: Implement. lmao
        return 0
    }
}
