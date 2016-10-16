//
//  GameState.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 9/19/16.
//  Copyright © 2016 Sirkles LLC. All rights reserved.
//

enum GameState {
    // No active screen. This is only used during initialization.
    // Global game state should not be set to this again.
    case None,
    
    // The main menu.
    MainMenu,
    
    // Classic gameplay mode.
    Classic,
    
    // Arcade gameplay mode.
    Arcade,
    
    // Voids gameplay mode.
    Voids,
    
    // Insane gameplay mode.
    Insane,
    
    // Game Over screen that is displayed when the player has died.
    GameOver,
    
    // The options menu screen.
    Options,
    
    // Transition to Classic gameplay mode.
    TransitionToClassic,
    
    // Transition to Arcade gameplay mode.
    TransitionToArcade,
    
    // Transition to Voids gameplay mode.
    TransitionToVoids,
    
    // Transition to Insane gameplay mode.
    TransitionToInsane
}

var globalGameState: GameState = GameState.None

/// In case the user the started a gameplay mode using the 3D Touch shortcut from iOS 9+.
var startedGameplay: GameState = GameState.None
var didStartViaShortcut: Bool = false
