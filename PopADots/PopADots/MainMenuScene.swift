//
//  GameScene.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/11/15.
//  Copyright (c) 2015-2016 Sirkles LLC. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    var numCircles = 4
    var circles:Array<TouchCircle>? = Array<TouchCircle>()
    var bg: RainbowEffect?
    var numBackgroundCircles = 10
    
    override init() {
        super.init()
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        print("loading main menu")
        globalGameState = GameState.mainMenu;
        
        if self.bg == nil {
            print("instantiating new bg for menu")
            self.bg = RainbowEffect(frame: self.frame)
            self.scene?.backgroundColor = SKColor.white
        }
        self.bg!.zPosition = -2
        
        self.addChild(self.bg!)
        
        self.numCircles = 4
        self.circles = Array<MenuCircle>()
        
        self.generateCircles()
        
        print("at main menu")
        
        //print("Screen Resolution (x,y,w,h): \(Utils.getScreenResolution())")
        //print("Aspect Ratio: \(Utils.getAspectRatio())")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        // We only want one touch (unless we want multi-touch)
        let myTouch: UITouch = touches.first!
        let touchLocation = myTouch.location(in: self)
        
        for i in numBackgroundCircles..<self.circles!.count {
            if self.circles![i] is MenuCircle && self.circles![i].checkTouch(touchLocation) == true {
                self.menuAction(i - numBackgroundCircles)
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
   
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        self.bg!.update(currentTime)
        
        for i in 0..<self.circles!.count {
            self.circles![i].update(currentTime)
        }
    }
    
    func generateCircles() {
        for i in 0..<self.numBackgroundCircles {
            let tempCircle: TouchCircle = TouchCircle()
            
            tempCircle.active = true
            tempCircle.touchable = false
            
            tempCircle.zPosition = CGFloat(i)
            
            self.circles!.append(tempCircle)
            self.addChild(tempCircle)
        }
        
        for i in 0..<self.numCircles {
            let tempCircle: MenuCircle = createMenuButton(Int(i))
            
            tempCircle.zPosition = CGFloat(numBackgroundCircles + (i + 1))
            
            self.circles!.append(tempCircle)
            self.addChild(tempCircle)
        }
    }
    
    func createMenuButton(_ button: Int) -> MenuCircle {
        var circle: MenuCircle?
        
        switch button {
        case 0:
            // Classic
            circle = MenuCircle(radius: Utils.scaleRadius(250), pos: CGPoint(x: Utils.getScreenResolution().width / 4, y: Utils.getScreenResolution().height - Utils.getScreenResolution().height / 4), color: Utils.getColor(button + 1), label: "Classic")
        case 1:
            // Arcade
            circle = MenuCircle(radius: Utils.scaleRadius(250), pos: CGPoint(x: (Utils.getScreenResolution().width / 6) + (Utils.getScreenResolution().width / 2), y: Utils.getScreenResolution().height - (Utils.getScreenResolution().height - Utils.getScreenResolution().height / 2 - Utils.getScreenResolution().height / 12)), color: Utils.getColor(button + 1), label: "Arcade")
        case 2:
            // Voids
            circle = MenuCircle(radius: Utils.scaleRadius(250), pos: CGPoint(x: Utils.getScreenResolution().width / 4, y: Utils.getScreenResolution().height - (Utils.getScreenResolution().height - Utils.getScreenResolution().height / 3 - Utils.getScreenResolution().height / 12)), color: Utils.getColor(button + 1), label: "Voids")
        case 3:
            // Insane
            circle = MenuCircle(radius: Utils.scaleRadius(250), pos: CGPoint(x: Utils.getScreenResolution().width - (Utils.getScreenResolution().width / 4), y: Utils.getScreenResolution().height - Utils.getScreenResolution().height - Utils.getScreenResolution().height / 3 + (Utils.getScreenResolution().height - Utils.getScreenResolution().height / 4 - Utils.getScreenResolution().height / 5)), color: Utils.getColor(button + 1), label: "Insane")
        default:
            fatalError("Button index is invalid!")
        }
        
        circle?.initialize()
        
        return circle!
    }
    
    func menuAction(_ button: Int) {
        print("Triggering button: \(button)")
        switch button {
        case 0:
            // Classic Mode
            print("Classic Mode pressed!")
            let transition: SKTransition = SKTransition.fade(withDuration: 1)
            let classic: ClassicScene = ClassicScene(size: self.frame.size)
            let newBG: RainbowEffect = RainbowEffect(frame: classic.frame)
            
            newBG.r = self.bg!.r
            newBG.g = self.bg!.g
            newBG.b = self.bg!.b
            
            newBG.color? = (self.bg?.color)!
            
            classic.bg = newBG
            
            classic.bg!.r = self.bg!.r
            classic.bg!.g = self.bg!.g
            classic.bg!.b = self.bg!.b
            
            classic.backgroundColor = classic.bg!.color!
            
            self.view?.presentScene(classic, transition: transition)
        case 1:
            // Arcade Mode
            print("Arcade Mode pressed!")
            let transition: SKTransition = SKTransition.fade(withDuration: 1)
            let arcade: ArcadeScene = ArcadeScene(size: self.frame.size)
            
            self.view?.presentScene(arcade, transition: transition)
        case 2:
            // Voids Mode
            print("Voids Mode pressed!")
        case 3:
            // Insane Mode
            print("Insane Mode pressed!")
        default:
            fatalError("Button index \(button) is invalid.")
        }
    }
}
