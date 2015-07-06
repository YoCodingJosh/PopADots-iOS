//
//  GameOverScreen.swift
//  PopADots
//
//  Created by Josh Kennedy on 7/6/15.
//  Copyright © 2015 Sirkles. All rights reserved.
//

import Foundation
import CoreGraphics
import SpriteKit

// Note that this isn't a SKScene, but a normal SKNode.
// SpriteKit somhow doesn't support overlapping scene graphs,
// so this is a way to skirt around that. :)
class GameOverScreen: SKNode {
    init(rect: CGRect) {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
