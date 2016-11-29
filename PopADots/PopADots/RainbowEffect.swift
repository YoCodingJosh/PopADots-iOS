//
//  BackgroundEffect.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/21/15.
//  Copyright © 2015-2016 Sirkles LLC. All rights reserved.
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
        
        self.name = "Rainbow Background Effect"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (!black) {
            if (b == 0 && r == 0 && green) {
                if (g <= 254) {
                    g += 1
                }
                
                if (g == 255) {
                    green = false
                    purple = true
                }
            }
            else if (purple) {
                if (g > 0) {
                    if (b < 128) {
                        b += 1
                    }
                    else if (r < 128) {
                        r += 1
                    }
                    else {
                        g -= 1
                    }
                }
                else {
                    if (b >= 1) {
                        b -= 1
                    }
                    else if (r >= 1) {
                        r -= 1
                    }
                }
                
                if (b == 0 && g == 0 && r == 0) {
                    g = 0
                    purple = false
                }
            }
            else if (b < 255 && colorIncrement && !green && !purple) {
                b += 1
            }
            else if (b >= 254 && g <= 254) {
                g += 1
            }
            else if (g >= 254 && r <= 254) {
                r += 1
                
                if (r == 255) {
                    colorIncrement = false
                }
            }
            else {
                if (b > 0 && g != 0) {
                    b -= 1
                }
                else if (b == 0 && g > 0) {
                    g -= 1
                }
                else {
                    r -= 1
                    
                    if (r <= 0) {
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
    
    func blackTransition() {
        colorIncrement = true
        green = true
        purple = true
        
        if (b > 0) {
            b -= 1
        }
        
        if (g > 0) {
            g -= 1
        }
        
        if (r > 0) {
            r -= 1
        }
    }
}
