//
//  AdStateMachine.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 9/19/16.
//  Copyright © 2016 Sirkles LLC. All rights reserved.
//

import Foundation
import Dispatch

import GoogleMobileAds

// This handles which ad to show and when to display it.
//
// A traditional FSM drives the actual application.
// Since that'll be impossible in SpriteKit, we'll just observe the state changes and act upon it.
class AdStateMachine {
    // Types of ads.
    enum AdType {
        case None,
        Banner,
        Interstitial
    }
    
    // States of the state machine.
    static var running: Bool = false
    static var paused: Bool = false
    
    var nextState: GameState
    var shouldPreload: Bool = false
    var previousState: GameState
    
    // Should only be created once, and only during game initialization!
    init() {
        // We initialize to None, because the game hasn't been initialized, so we can't tell what the next state is.
        nextState = GameState.None
        previousState = GameState.None
    }
    
    // One iteration (or "frame") of the state machine.
    // PS: Frame would be a misnomer, as we're executing this almost twice a frame.
    func thunk() {
        // Save a bit a performance by skipping if the state hasn't changed.
        if previousState == globalGameState {
            return
        }
        
        // If we reach here, then the state has changed.
        previousState = globalGameState
        
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
                AdStateMachine.adType = AdType.Banner
            }
        }
        
        // Should we generate the ad object?
        if AdStateMachine.adType != AdType.None && shouldPreload {
            
        }
    }
    
    // Dispatch the FSM loop to GCD (Grand Central Dispatch) for concurrency.
    static func start() {
        if running {
            print("State machine already running!");
            
            return;
        }
        
        print("Starting up Ad State Machine...")
        
        let instance: AdStateMachine = AdStateMachine()
        running = true
        
        // This allows the code to run asynchronously.
        DispatchQueue.global().async {
            while(running) {
                if !paused {
                    instance.thunk()
                    
                    // Sleep for a pinch, so we don't use a ton of CPU.
                    // Note: usleep uses microseconds as opposed to milliseconds.
                    usleep(10000)
                } else {
                    // Since we're paused, we sleep for a bit longer.
                    usleep(20000)
                }
            }
            
            // Clear the ad data.
            AdStateMachine.showAd = false
            AdStateMachine.adId = ""
            AdStateMachine.adType = AdType.None
            
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
    
    // Class variables that contain advertisment information.
    static var showAd: Bool = false
    static var adId: String = ""
    static var adType: AdType = AdType.None
}
