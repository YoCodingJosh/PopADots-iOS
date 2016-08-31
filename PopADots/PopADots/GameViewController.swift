//
//  GameViewController.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/11/15.
//  Copyright (c) 2015-2016 Sirkles LLC. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

import iAd

class GameViewController: UIViewController, GKGameCenterControllerDelegate
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initGameCenter()
        
        //if let scene: MainMenuScene = MainMenuScene() {
        //if let scene = GameScene(fileNamed:"GameScene") {
        
        let scene: MainMenuScene = MainMenuScene();
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        scene.size = skView.bounds.size;
            
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
            
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .resizeFill
        
        skView.presentScene(scene)
    }
    
    // Initialize Game Center
    func initGameCenter() {
        // Check if user is already authenticated in game center
        if GKLocalPlayer().isAuthenticated == false {
            // Show the Login Prompt for Game Center
            GKLocalPlayer().authenticateHandler = { (viewController, error) -> Void in
                if viewController != nil {
                    //self.scene!.gamePaused = true
                    self.present(viewController!, animated: true, completion: nil)
                    // Add an observer which calls ‘gameCenterStateChanged’ to handle a changed game center state
                    _ = NotificationCenter.default
                    //notificationCenter.addObserver(self, selector: #selector(GameViewController.gameCenterStateChanged), name: "GKPlayerAuthenticationDidChangeNotificationName" as NSNotification.Name, object: nil)
                }
            }
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        print("done with game center for now...")
    }
    
    func gameCenterStateChanged() {
        // do something?
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    func viewControllerForPresentingModalView() -> UIViewController {
        return self
    }
}
