//
//  GameScene.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/11/15.
//  Copyright © 2015-2016 Sirkles LLC. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    var numCircles = 4
    var circles:Array<TouchCircle> = Array<TouchCircle>()
    var bg: RainbowEffect?
    var numBackgroundCircles = 10
    var isTransitioning: Bool = false
    var isEnlarging: Bool = false
    var isCompressing: Bool = false
    var transitionCircle: TouchCircle?
    var nextScene: SKScene?
    var settingsButton: MenuCircle = MenuCircle(radius: Utils.scaleRadius(200), pos: CGPoint(x: Utils.getScreenResolution().width / 4, y: Utils.getScreenResolution().height - Utils.getScreenResolution().height - Utils.getScreenResolution().height / 3 + (Utils.getScreenResolution().height - Utils.getScreenResolution().height / 4 - Utils.getScreenResolution().height / 5) - 10), color: SKColor.gray, label: "Settings")
    
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
        globalGameState = GameState.MainMenu;
        
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
        
        self.settingsButton.zPosition = CGFloat(self.numBackgroundCircles + self.numCircles + 1)
        self.settingsButton.initialize()
        self.addChild(self.settingsButton)
        
        print("at main menu")
        
        //print("Screen Resolution (x,y,w,h): \(Utils.getScreenResolution())")
        //print("Aspect Ratio: \(Utils.getAspectRatio())")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        // We only want one touch (unless we want multi-touch)
        let myTouch: UITouch = touches.first!
        let touchLocation = myTouch.location(in: self)
        
        for i in numBackgroundCircles..<self.circles.count {
            if self.circles[i] is MenuCircle && self.circles[i].checkTouch(touchLocation) == true {
                self.menuAction(i - numBackgroundCircles)
            }
        }
        
        if self.settingsButton.checkTouch(touchLocation) == true {
            let currentController: UIViewController = (UIApplication.shared.keyWindow?.rootViewController!)!
            currentController.performSegue(withIdentifier: "TransitionToSettings", sender: nil)
        }
    }
   
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        self.bg!.update(currentTime)
        
        for i in 0..<self.circles.count {
            self.circles[i].update(currentTime)
        }
        
        if didStartViaShortcut {
            didStartViaShortcut = false;
            
            if startedGameplay == GameState.Classic {
                menuAction(0) // 0 is Classic
            }
            else if startedGameplay == GameState.Arcade {
                menuAction(1) // 1 is Arcade
            }
            else if startedGameplay == GameState.Voids {
                menuAction(2) // 2 is Voids
            }
            else if startedGameplay == GameState.Insane {
                menuAction(3) // 3 is Insane
            }
        }
        
        if self.isTransitioning {
            if nextScene is ArcadeScene {
                (nextScene as! ArcadeScene).bg?.update(currentTime)
            }
            else if nextScene is ClassicScene {
                (nextScene as! ClassicScene).bg?.update(currentTime)
            }
            
            if self.isEnlarging {
                self.transitionCircle!.resizeCircle(self.transitionCircle!.radius * 1.1)
                
                if self.transitionCircle!.radius >= Utils.getScreenResolution().height {
                    self.isEnlarging = false
                    self.isCompressing = true
                    
                    for child in self.children {
                        if child == self.transitionCircle || child == self.bg {
                            continue
                        }
                        
                        child.removeFromParent()
                    }
                }
            }
            
            if self.isCompressing {
                self.transitionCircle!.resizeCircle(self.transitionCircle!.radius / 1.25)
                
                if self.transitionCircle!.radius <= 10 {
                    self.isCompressing = false
                    self.isTransitioning = false
                    self.gotoScreen(nextScene)
                }
            }
        }
    }
    
    func generateCircles() {
        for i in 0..<self.numBackgroundCircles {
            let tempCircle: TouchCircle = TouchCircle()
            
            tempCircle.active = true
            tempCircle.touchable = false
            
            tempCircle.zPosition = CGFloat(i)
            
            self.circles.append(tempCircle)
            self.addChild(tempCircle)
        }
        
        for i in 0..<self.numCircles {
            let tempCircle: MenuCircle = createMenuButton(Int(i))
            
            tempCircle.zPosition = CGFloat(numBackgroundCircles + (i + 1))
            
            self.circles.append(tempCircle)
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
    
    func gotoScreen(_ screen: SKScene?) {
        self.view?.presentScene(screen!)
    }
    
    func menuAction(_ button: Int) {
        print("Triggering button: \(button)")
        switch button {
        case 0:
            // Classic Mode
            print("Classic Mode pressed!")
            
            globalGameState = GameState.TransitionToClassic
            
            let rad = self.circles[self.circles.count - 4].radius
            let pos = self.circles[self.circles.count - 4].position
            let col = self.circles[self.circles.count - 4].fillColor
            
            self.circles[self.circles.count - 4].removeFromParent()
            
            transitionCircle = TouchCircle(radius: rad, pos: pos, color: col, xVel: 0, yVel: 0)
            transitionCircle?.touchable = false
            transitionCircle?.zPosition = 420 // Make it high as possible. #420
            self.addChild(transitionCircle!)
            
            self.isTransitioning = true
            self.isEnlarging = true
            
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
            
            self.nextScene = classic
        case 1:
            // Arcade Mode
            print("Arcade Mode pressed!")
            
            globalGameState = GameState.TransitionToArcade
            
            let rad = self.circles[self.circles.count - 3].radius
            let pos = self.circles[self.circles.count - 3].position
            let col = self.circles[self.circles.count - 3].fillColor
            
            self.circles[self.circles.count - 3].removeFromParent()
            
            transitionCircle = TouchCircle(radius: rad, pos: pos, color: col, xVel: 0, yVel: 0)
            transitionCircle?.touchable = false
            transitionCircle?.zPosition = 420 // Make it high as possible. #420
            self.addChild(transitionCircle!)
            
            self.isTransitioning = true
            self.isEnlarging = true
            
            let arcade: ArcadeScene = ArcadeScene(size: self.frame.size)
            let newBG: RainbowEffect = RainbowEffect(frame: arcade.frame)
            
            newBG.r = self.bg!.r
            newBG.g = self.bg!.g
            newBG.b = self.bg!.b
            
            newBG.color? = (self.bg?.color)!
            
            arcade.bg = newBG
            
            arcade.bg!.r = self.bg!.r
            arcade.bg!.g = self.bg!.g
            arcade.bg!.b = self.bg!.b
            
            arcade.backgroundColor = arcade.bg!.color!
            
            self.nextScene = arcade
        case 2:
            // Voids Mode
            print("Voids Mode pressed!")
            globalGameState = GameState.TransitionToVoids
        case 3:
            // Insane Mode
            print("Insane Mode pressed!")
            globalGameState = GameState.TransitionToInsane
        default:
            fatalError("Button index \(button) is invalid.")
        }
    }
}
