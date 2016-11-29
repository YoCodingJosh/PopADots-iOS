//
//  Utils.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/11/15.
//  Copyright © 2015-2016 Sirkles LLC. All rights reserved.
//

import Foundation
import CoreGraphics
import SpriteKit
import UIKit
import SystemConfiguration

// Cache the sound actions to prevent a delay when popping circles.
var lowPopSoundAction = SKAction.playSoundFileNamed("lowpop.wav", waitForCompletion: false)
var highPopSoundAction = SKAction.playSoundFileNamed("highpop.wav", waitForCompletion: false)
var highPop2SoundAction = SKAction.playSoundFileNamed("highpop2.wav", waitForCompletion: false)
var badPopSoundAction = SKAction.playSoundFileNamed("badpop.wav", waitForCompletion: false)

extension SKNode {
    class func unarchiveFromFile(_ file : NSString) -> SKNode? {
        
        let path = Bundle.main.path(forResource: file as String, ofType: "sks")
        
        let sceneData = try! Data(contentsOf: URL(fileURLWithPath: path!), options: NSData.ReadingOptions.mappedIfSafe)
        let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
        
        archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
        let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! MainMenuScene
        archiver.finishDecoding()
        return scene
    }
}

extension Int
{
    static func random(_ range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.lowerBound < 0   // allow negative ranges
        {
            offset = Swift.abs(range.lowerBound)
        }
        
        let mini = UInt32(range.lowerBound + offset)
        let maxi = UInt32(range.upperBound   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}

class Utils {
    static func randomFloat() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    static func getScreenResolution() -> CGRect {
        return UIScreen.main.bounds
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
    
    static func scaleRadius(_ customSize: CGFloat = 0.0) -> CGFloat {
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
    
    static func scaleVelocity(_ parBlack: Bool) -> (xVel: CGFloat, yVel: CGFloat) {
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
    
    static func scaleXPos(_ customValue: CGFloat = 0.0) -> CGFloat {
        return ((customValue == 0) ? floor(randomFloat() * getScreenResolution().width + 1) : customValue)
    }
    
    static func scaleYPos(_ customValue: CGFloat = 0.0) -> CGFloat {
        return ((customValue == 0) ? floor(randomFloat() * getScreenResolution().height + 1) : customValue)
    }
    
    static func getColor(_ color: Int = -1) -> UIColor {
        var myColor: UIColor = UIColor.black
        
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
            myColor = UIColor.black
        }
        
        return myColor
    }
    
    static func getScaledFontSize(_ size: CGFloat) -> CGFloat {
        let dim: CGFloat = (self.getScreenResolution().width / size)
        
        return 1.3 * dim
    }
    
    static func connectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    static func lerp(_ value1: CGFloat, value2: CGFloat, amount: CGFloat) -> CGFloat {
        return ((1 - value1) * value2) + (value1 * amount);
    }
    
    static func lerp(_ color1: UIColor, color2: UIColor, amount: CGFloat) -> UIColor {
        let val1: CIColor = CIColor(color: color1)
        let val2: CIColor = CIColor(color: color2)
        
        return UIColor(red: lerp(val1.red, value2: val2.red, amount: amount), green: lerp(val1.green, value2: val2.green, amount: amount), blue: lerp(val1.blue, value2: val2.blue, amount: amount), alpha: lerp(val1.alpha, value2: val2.alpha, amount: amount))
    }
    
    static func getPopSound(_ val: Int = -1) -> SKAction {
        if (val > 2 || val < -1) {
            fatalError("Bounds checking failed for Utils::getPopSound()")
        }
        
        if (val == -1) {
            return getPopSound(Int.random(Range<Int>(0...2)))
        }
        
        switch (val) {
        case 0:
            return lowPopSoundAction
        case 1:
            return highPopSoundAction
        case 2:
            return highPop2SoundAction
        default:
            return getPopSound(Int.random(Range<Int>(0...2)))
        }
    }
    
    static func getBadPopSound() -> SKAction {
        return badPopSoundAction
    }
    
    static func clearUbiquitousStorage() {
        print("Clearing Ubiquitous Storage...")
        
        let store: NSUbiquitousKeyValueStore = NSUbiquitousKeyValueStore()
        
        let storeDict: Dictionary = store.dictionaryRepresentation
        
        let array: Array = Array(storeDict.keys)
        
        for key in array {
            store.removeObject(forKey: key)
        }
        
        print("Cleared Ubiquitous Storage!")
    }
}
