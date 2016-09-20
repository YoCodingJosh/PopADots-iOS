//
//  AdStateMachine.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 9/19/16.
//  Copyright © 2016 Sirkles. All rights reserved.
//

import Foundation
import Dispatch

// This handles which ad to show and when.
class AdStateMachine {
    static var running: Bool = false
    static var paused: Bool = false
    var nextState: GameState
    
    init() {
        // We initialize to None, because the game hasn't been initialized, so we can't tell what the next state is.
        nextState = GameState.None
    }
    
    func thunk() {
        // If the state is None, then the game has not been initialized yet.
        if globalGameState == GameState.None {
            // We expect that the next state will be the main menu, so we don't show an ad yet.
            nextState = GameState.MainMenu
            globalShowAd = false
            
            return
        }
    }
    
    // Dispatch the FSM loop to GCD for concurrency.
    static func start() {
        print("Starting up Ad State Machine...")
        let instance: AdStateMachine = AdStateMachine()
        running = true
        
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
            
            print("Ad State Machine has been stopped.")
        }
    }
    
    // Pause the FSM processing, but maintain the dispatch process.
    static func pause() {
        print("Pausing Ad State Machine...")
        paused = true
    }
    
    // Resume the FSM processing.
    static func resume() {
        print("Resuming Ad State Machine...")
        paused = false
    }
    
    // Stop running the FSM loop.
    static func stop() {
        print("Stopping Ad State Machine... (will finish processing its current frame)")
        running = false
    }
}

var globalShowAd: Bool = false;
