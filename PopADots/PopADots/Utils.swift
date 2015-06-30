//
//  Utils.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/11/15.
//  Copyright © 2015 Sirkles LLC. All rights reserved.
//

import Foundation
import CoreGraphics
import SpriteKit
import UIKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks")
        
        let sceneData = try! NSData(contentsOfFile: path!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
        
        archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
        let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
        archiver.finishDecoding()
        return scene
    }
}

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
        return (getScreenResolution().width / 1280)
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
    
    static func getColor(color: Int = -1) -> UIColor {
        var myColor: UIColor = UIColor.blackColor()
        
        if color == -1 {
            return getColor(Int(arc4random_uniform(16)) + 1)
        }
        
        switch color {
        case 1:
            // Deep Pink
            myColor = UIColor(red: 255.0/255.0, green: 20.0/255.0, blue: 147.0/255.0, alpha: 255.0/255.0)
        case 2:
            // Cyan
            myColor = UIColor(red: 0.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 255.0/255.0)
        case 3:
            // Gold
            myColor = UIColor(red: 255.0/255.0, green: 215.0/255.0, blue: 0.0/255.0, alpha: 255.0/255.0)
        case 4:
            // Lawn Green
            myColor = UIColor(red: 124.0/255.0, green: 252.0/255.0, blue: 0.0/255.0, alpha: 255.0/255.0)
        case 5:
            // Purple
            myColor = UIColor(red: 160.0/255.0, green: 32.0/255.0, blue: 240.0/255.0, alpha: 255.0/255.0)
        case 6:
            // Red
            myColor = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 255.0/255.0)
        case 7:
            // Dark Orange
            myColor = UIColor(red: 255.0/255.0, green: 140.0/255.0, blue: 0.0/255.0, alpha: 255.0/255.0)
        case 8:
            // Jet fuel can't melt steel blue
            myColor = UIColor(red: 70.0/255.0, green: 130.0/255.0, blue: 180.0/255.0, alpha: 255.0/255.0)
        case 9:
            // Light Salmon
            myColor = UIColor(red: 255.0/255.0, green: 160.0/255.0, blue: 122.0/255.0, alpha: 255.0/255.0)
        case 10:
            // Medium Purple
            myColor = UIColor(red: 147.0/255.0, green: 112.0/255.0, blue: 219.0/255.0, alpha: 255.0/255.0)
        case 11:
            // Slate Gray
            myColor = UIColor(red: 112.0/255.0, green: 128.0/255.0, blue: 144.0/255.0, alpha: 255.0/255.0)
        case 12:
            // Uhhh.. Khakis.
            myColor = UIColor(red: 240.0/255.0, green: 230.0/255.0, blue: 140.0/255.0, alpha: 255.0/255.0)
        case 13:
            // Maroon
            myColor = UIColor(red: 176.0/255.0, green: 48.0/255.0, blue: 96.0/255.0, alpha: 255.0/255.0)
        case 14:
            // Olive
            myColor = UIColor(red: 176.0/255.0, green: 48.0/255.0, blue: 96.0/255.0, alpha: 255.0/255.0)
        case 15:
            // Forest Green
            myColor = UIColor(red: 34.0/255.0, green: 139.0/255.0, blue: 34.0/255.0, alpha: 255.0/255.0)
        case 16:
            // Tomato (yuck xP)
            myColor = UIColor(red: 255.0/255.0, green: 99.0/255.0, blue: 71.0/255.0, alpha: 255.0/255.0)
        case 17:
            // Spring Green
            myColor = UIColor(red: 0.0/255.0, green: 255.0/255.0, blue: 127.0/255.0, alpha: 255.0/255.0)
        default:
            myColor = UIColor.blackColor()
        }
        
        return myColor
    }
    
    static func getScaledFontSize(size: CGFloat) -> CGFloat {
        let dim: CGFloat = (self.getScreenResolution().width / size)
        
        return 1.3 * dim
    }
}
