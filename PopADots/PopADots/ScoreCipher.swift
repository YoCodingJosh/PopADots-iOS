//
//  ScoreCipher.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 11/5/16.
//  Copyright © 2016 Sirkles LLC. All rights reserved.
//

// Cypher Algorithm:
// output = (((userScore * 6 / 2) + 100) * 7) + (1, if score is even, otherwise 0)
//
// userScore is the score that the user got. [0, Infinity)
// 6 is the non-prime multiplier constant, preferably even.
// 2 is the LCM of the non-prime multiplier constant.
// 100 is a constant, can be any value.
// 7 is the prime multiplier constant, must not be 2 (especially if the non-prime multiplier constant is even).
//
// We conditionally add 1 if the score is even.

// It would be very fun to implement a simple RSA public key encrypter on top of this.

import Foundation

// This code will be directly ported from the Python version verbatim...
// EXCEPT we're...
// * removing the conditional add 1
// * upping the prime multiplier constant to 73

class ScoreCipher {
    static func setScore(score: Int64, mode: GameState) -> Void {
        let newScore: Int64 = Int64(((score * 6 / 2) + 100) * 73 + 1)
        let hexNewScore: String = String(newScore, radix: 16)
        
        // Construct the file name.
        var fileName = "POP-"
        
        switch (mode) {
        case GameState.Arcade:
            fileName += "ARCADE"
            break
        case GameState.Classic:
            fileName += "CLASSIC"
            break
        case GameState.Insane:
            fileName += "INSANE"
            break
        case GameState.Voids:
            fileName += "VOIDS"
            break
        default:
            fileName += "WHATTHEFU"
            break
        }
        
        fileName += ".DAT"
        
        let file: FileHandle? = FileHandle(forWritingAtPath: fileName)
        
        if file != nil {
            // Set the data we want to write
            let data = (hexNewScore as String).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            // Write it to the file
            file?.write(data!)
            
            // Close the file
            file?.closeFile()
        }
        else {
            print("Ooops! Something went wrong!")
        }
    }
    
    static func getScore(mode: GameState) -> Int64 {
        var scoreString: String = ""
        
        // Construct the file name.
        var fileName = "POP-"
        
        switch (mode) {
        case GameState.Arcade:
            fileName += "ARCADE"
            break
        case GameState.Classic:
            fileName += "CLASSIC"
            break
        case GameState.Insane:
            fileName += "INSANE"
            break
        case GameState.Voids:
            fileName += "VOIDS"
            break
        default:
            fileName += "WHATTHEFU"
            break
        }
        
        fileName += ".DAT"
        
        let file: FileHandle? = FileHandle(forReadingAtPath: fileName)
        
        if file != nil {
            // Read all the data
            let data = file?.readDataToEndOfFile()
            
            // Close the file
            file?.closeFile()
            
            // Convert our data to string
            let str = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            scoreString = str!
        }
        else {
            print("Ooops! Something went wrong!")
        }
        
        let tempScore = Int64(scoreString, radix: 16)
        
        return Int64(exactly: (tempScore! / 73) - 100 * 2 / 6)!;
    }
}
