//
//  AdStateMachine.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 9/19/16.
//  Copyright © 2016 Sirkles LLC. All rights reserved.
//

import Foundation
import Dispatch

// This handles which ad to show and when to display it.
class AdStateMachine {
    static var running: Bool = false
    static var paused: Bool = false
    
    var nextState: GameState
    var shouldPreload: Bool = false
    
    init() {
        // We initialize to None, because the game hasn't been initialized, so we can't tell what the next state is.
        nextState = GameState.None
    }
    
    // One iteration of the state machine.
    func thunk() {
        // If the state is None, then the game has not been initialized yet.
        if globalGameState == GameState.None {
            // We expect that the next state will be the main menu, so we don't show an ad yet.
            nextState = GameState.MainMenu
            AdStateMachine.showAd = false
            
            shouldPreload = true
        }
        
        // Should we preload ad information?
        if shouldPreload {
            if nextState == GameState.MainMenu {
                // If the next state is the main menu, then we should preload the ad.
                AdStateMachine.showAd = true
                AdStateMachine.adId = "ca-app-pub-7424757056499341/8187100114"
            }
        }
    }
    
    // Dispatch the FSM loop to GCD (Grand Central Dispatch) for concurrency.
    static func start() {
        print("Starting up Ad State Machine...")
        
        let instance: AdStateMachine = AdStateMachine()
        running = true
        
        // This allows the code to run asynchronously.
        DispatchQueue.global().async {
            while(running) {
                if !paused {
                    instance.thunk()
                    
                    // Sleep for a pinch, so we don't use a ton of CPU.
                    usleep(50)
                } else {
                    // Since we're paused, we sleep for a bit longer.
                    usleep(250)
                }
            }
            
            // Clear the ad data.
            showAd = false
            adId = ""
            
            print("Ad State Machine has been stopped.")
        }
    }
    
    // Pause the FSM processing, but maintain the dispatch process.
    // This **should** get called when the application enters the background.
    static func pause() {
        print("Pausing Ad State Machine...")
        paused = true
    }
    
    // Resume the FSM processing.
    // This **should** get called when the application enters the foreground.
    static func resume() {
        print("Resuming Ad State Machine...")
        paused = false
    }
    
    // Stop running the FSM loop.
    // This will be called when the application terminates.
    static func stop() {
        print("Stopping Ad State Machine... (will finish processing its current frame)")
        running = false
    }
    
    static var showAd: Bool = false
    static var adId: String = ""
}
