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
    var numCircles:UInt32 = 4
    var circles:Array<MenuCircle>? = Array<MenuCircle>()
    
    var gameState: GameState = GameState.MainMenu;
    
    override func didMoveToView(view: SKView) {
        self.scene?.backgroundColor = SKColor.whiteColor()
        
        self.generateCircles()
        
        print("Screen Resolution: \(Utils.getScreenResolution())")
        print("Aspect Ratio: \(Utils.getAspectRatio())")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        // We only want one touch (unless we want multi-touch)
        let myTouch: UITouch = touches.first!
        let touchLocation = myTouch.locationInNode(self)
        
        for var i = 0; i < self.circles!.count; ++i {
            if self.circles?[i].checkTouch(touchLocation) == true {
                self.menuAction(i)
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
    }
    
    func generateCircles() {
        for var i: UInt32 = 0; i < self.numCircles; ++i {
            let tempCircle: MenuCircle = createMenuButton(Int(i))
            
            self.circles?.append(tempCircle)
            self.addChild(tempCircle)
        }
        
        print("Number of MenuCircles: \(self.circles!.count)")
        print("Number of Nodes in Scene: \(self.children.count)")
    }
    
    func createMenuButton(button: Int) -> MenuCircle {
        var circle: MenuCircle?
        
        switch button {
        case 0:
            // Classic
            circle = MenuCircle(radius: Utils.scaleRadius(250), pos: CGPoint(x: Utils.getScreenResolution().width / 4, y: Utils.getScreenResolution().height / 4), color: Utils.getColor(button + 1), label: "Classic")
        case 1:
            // Arcade
            circle = MenuCircle(radius: Utils.scaleRadius(250), pos: CGPoint(x: (Utils.getScreenResolution().width / 6) + (Utils.getScreenResolution().width / 2), y: (Utils.getScreenResolution().height - Utils.getScreenResolution().height / 2 - Utils.getScreenResolution().height / 12)), color: Utils.getColor(button + 1), label: "Arcade")
        case 2:
            // Voids
            circle = MenuCircle(radius: Utils.scaleRadius(250), pos: CGPoint(x: Utils.getScreenResolution().width / 4, y: (Utils.getScreenResolution().height - Utils.getScreenResolution().height / 3 - Utils.getScreenResolution().height / 12)), color: Utils.getColor(button + 1), label: "Voids")
        case 3:
            // Insane
            circle = MenuCircle(radius: Utils.scaleRadius(250), pos: CGPoint(x: Utils.getScreenResolution().width - (Utils.getScreenResolution().width / 4), y: Utils.getScreenResolution().height - Utils.getScreenResolution().height / 3 - Utils.getScreenResolution().height / 12 + (Utils.getScreenResolution().height / 4 + Utils.getScreenResolution().height / 5)), color: Utils.getColor(button + 1), label: "Insane")
        default:
            fatalError("Button index is invalid!")
        }
        
        circle?.yScale = -1
        
        print("Button pos: \(circle!.position)")
        
        return circle!
    }
    
    func menuAction(button: Int) {
        switch button {
        case 0:
            // Classic Mode
            print("Classic Mode pressed!")
        case 1:
            // Arcade Mode
            print("Arcade Mode pressed!")
        case 2:
            // Voids Mode
            print("Voids Mode pressed!")
        case 3:
            // Insane Mode
            print("Insane Mode pressed!")
        default:
            fatalError("Button index is invalid.")
        }
    }
}
