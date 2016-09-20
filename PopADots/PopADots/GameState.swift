//
//  GameState.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 9/19/16.
//  Copyright © 2016 Sirkles. All rights reserved.
//

import Foundation

enum GameState {
    // No active screen. This is only used during initialization.
    // Global game state should not be set to this again.
    case None,
    
    // The main menu.
    MainMenu,
    Classic,
    Arcade,
    Voids,
    Insane,
    GameOver,
    Options
}

var globalGameState: GameState = GameState.None
