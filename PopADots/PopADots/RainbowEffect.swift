//
//  BackgroundEffect.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/21/15.
//  Copyright © 2015 Sirkles. All rights reserved.
//

import Foundation
import SpriteKit

class RainbowEffect: BackgroundEffect {
    var color: UIColor? = nil
    
    var b: Int = 255
    var g: Int = 255
    var r: Int = 254
    
    var colorIncrement: Bool = true
    var green: Bool = true
    var purple: Bool = false
    var black: Bool = false
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        
        self.color = UIColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update(currentTime: NSTimeInterval) {
        if (!black) {
            if (b == 0 && r == 0 && green) {
                if (g <= 254) {
                    ++g
                }
                
                if (g == 255) {
                    green = false
                    purple = true
                }
            }
            else if (purple) {
                if (g > 0) {
                    if (b < 128) {
                        ++b
                    }
                    else if (r < 128) {
                        ++r
                    }
                    else {
                        --g
                    }
                }
                else {
                    if (b >= 1) {
                        --b
                    }
                    else if (r >= 1) {
                        --r
                    }
                }
                
                if (b == 0 && g == 0 && r == 0) {
                    g = 0
                    purple = false
                }
            }
            else if (b < 255 && colorIncrement && !green && !purple) {
                b++
            }
            else if (b >= 254 && g <= 254) {
                g++
            }
            else if (g >= 254 && r <= 254) {
                ++r
                
                if (r == 255) {
                    colorIncrement = false
                }
            }
            else {
                if (b > 0 && g != 0) {
                    b--
                }
                else if (b == 0 && g > 0) {
                    g--
                }
                else {
                    --r
                    
                    if (r == 0) {
                        green = true
                        purple = true
                        colorIncrement = true
                    }
                }
            }
        }
        else {
            blackTransition()
        }
        
        self.color = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 255.0/255.0)
        
        self.fillColor = self.color!
    }
    
    func blackTransition() { // lolol rachal dolezal
        colorIncrement = true
        green = true
        purple = true
        
        if (b > 0) {
            --b
        }
        
        if (g > 0) {
            --g
        }
        
        if (r > 0) {
            --r
        }
    }
}
