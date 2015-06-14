//
//  Utils.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/11/15.
//  Copyright © 2015 Sirkles. All rights reserved.
//

import Foundation
import CoreGraphics
import SpriteKit
import UIKit

class Utils {
    static func randomFloat() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    static func getScreenResolution() -> CGRect {
        return UIScreen.mainScreen().bounds
    }
    
    static func getAspectRatio() -> CGFloat {
        return (getScreenResolution().width / getScreenResolution().height)
    }
    
    static func getTempScalar() -> CGFloat {
        return (getScreenResolution().width / 1280) // We'll probably need to change from 1280.
    }
    
    static func getScreenScalar() -> CGFloat {
        return (getAspectRatio() * getTempScalar())
    }
    
    static func scaleRadius(customSize: CGFloat = 0.0) -> CGFloat {
        var tmpRadius: CGFloat = 0.0
        
        if (customSize == 0) {
            tmpRadius = floor((randomFloat() * 90)) + 70
        }
        else {
            tmpRadius = customSize
        }
        
        let tmpNumber: CGFloat = tmpRadius / getAspectRatio()
        
        return tmpNumber * getScreenScalar()
    }
    
    static func scaleVelocity(parBlack: Bool) -> (xVel: CGFloat, yVel: CGFloat) {
        let signedXVel: Int = (arc4random_uniform(1) == 0 ? -1 : 1)
        let signedYVel: Int = (arc4random_uniform(1) == 1 ? 1 : -1)
        
        var tmpXVel: Int, tmpYVel: Int = 0
        
        if (!parBlack) {
            tmpYVel = Int(floor(randomFloat() * 16) + 1) * signedYVel
            tmpXVel = Int(floor(randomFloat() * 16) + 1) * signedXVel
        }
        else {
            tmpYVel = 16 * signedYVel
            tmpXVel = 16 * signedXVel
        }
        
        let tmpNumberX: CGFloat = CGFloat(tmpXVel) / getAspectRatio()
        let tmpNumberY: CGFloat = CGFloat(tmpYVel) / getAspectRatio()
        
        return (tmpNumberX * getScreenScalar(), tmpNumberY * getScreenScalar())
    }
    
    static func scaleXPos(customValue: CGFloat = 0.0) -> CGFloat {
        return ((customValue == 0) ? floor(randomFloat() * getScreenResolution().width + 1) : customValue)
    }
    
    static func scaleYPos(customValue: CGFloat = 0.0) -> CGFloat {
        return ((customValue == 0) ? floor(randomFloat() * getScreenResolution().height + 1) : customValue)
    }
}
