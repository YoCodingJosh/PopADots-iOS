//
//  MKOutlinedLabelNode.swift
//
//  Created by Mario Klaver on 13-8-2015.
//  Copyright (c) 2015 Endpoint ICT. All rights reserved.
//

import UIKit
import SpriteKit

class MKOutlinedLabelNode: SKLabelNode {
    
    var borderColor: UIColor = UIColor.black
    
    var outlinedText: String! {
        didSet { drawText() }
    }
    
    private var border: SKShapeNode?
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    override init() {
        super.init()
    }
    
    init(fontNamed fontName: String!, fontSize: CGFloat) {
        super.init(fontNamed: fontName)
        self.fontSize = fontSize
    }
    
    func drawText() {
        if let borderNode = border {
            borderNode.removeFromParent()
            border = nil
        }
        
        if let text = outlinedText {
            self.text = text
            if let path = createBorderPathForText() {
                let border = SKShapeNode()
                
                border.strokeColor = borderColor
                border.lineWidth = 4;
                border.path = path
                //border.position = positionBorder(border)
                addChild(border)
                
                self.border = border
            }
        }
    }
    
    private func getTextAsCharArray() -> [UniChar] {
        var chars = [UniChar]()
        
        for codeUnit in text!.utf16 {
            chars.append(codeUnit)
        }
        return chars
    }
    
    private func createBorderPathForText() -> CGPath? {
        let chars = getTextAsCharArray()
        let borderFont = CTFontCreateWithName(self.fontName as CFString?, self.fontSize, nil) // Suboptimal
        
        var glyphs = Array<CGGlyph>(repeating: 0, count: chars.count)
        let gotGlyphs = CTFontGetGlyphsForCharacters(borderFont, chars, &glyphs, chars.count)
        
        if gotGlyphs {
            var advances = Array<CGSize>(repeating: CGSize(), count: chars.count)
            CTFontGetAdvancesForGlyphs(borderFont, CTFontOrientation.horizontal, glyphs, &advances, chars.count);
            
            let letters = CGMutablePath()
            var xPosition = 0 as CGFloat
            for index in 0...(chars.count - 1) {
                let letter = CTFontCreatePathForGlyph(borderFont, glyphs[index], nil)
                var t = CGAffineTransform(translationX: xPosition , y: 0)
                letters.addPath(t as! CGPath, transform: letter!)
                xPosition = xPosition + advances[index].width
            }
            
            return letters
        } else {
            return nil
        }
    }
    
    private func positionBorder(_ border: SKShapeNode) -> CGPoint {
        let sizeText = self.calculateAccumulatedFrame()
        let sizeBorder = border.calculateAccumulatedFrame()
        let offsetX = (sizeBorder.width - sizeText.width) / 2
        
        return CGPoint(x: -(sizeBorder.width / 2) + offsetX, y: 1)
    }
}
