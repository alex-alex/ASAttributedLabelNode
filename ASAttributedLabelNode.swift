//
//  ASAttributedLabelNode.swift
//
//  Created by Alex Studnicka on 15/08/14.
//  Copyright (c) 2014 Alex Studnicka. All rights reserved.
//

import UIKit
import SpriteKit

class ASAttributedLabelNode: SKSpriteNode {
	
	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
	
	init(size: CGSize) {
		super.init(texture: nil, color: UIColor.clearColor(), size: size)
	}
	
	var attributedString: NSAttributedString! {
		didSet {
			draw()
		}
	}
	
	func draw() {
		if let attrStr = attributedString {
			let scaleFactor = UIScreen.mainScreen().scale
			let colorSpace = CGColorSpaceCreateDeviceRGB()
			let bitmapInfo = CGImageAlphaInfo.PremultipliedLast.rawValue
			let oContext = CGBitmapContextCreate(nil, Int(self.size.width * scaleFactor), Int(self.size.height * scaleFactor), 8, Int(self.size.width * scaleFactor) * 4, colorSpace, bitmapInfo)
			if let context = oContext {
				CGContextScaleCTM(context, scaleFactor, scaleFactor)
				CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, self.size.height));
				UIGraphicsPushContext(context)
				
				let strHeight = attrStr.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, context: nil).height
				let yOffset = (self.size.height - strHeight) / 2.0
				attrStr.drawWithRect(CGRect(x: 0, y: yOffset, width: self.size.width, height: strHeight), options: .UsesLineFragmentOrigin, context: nil)
				
				if let imageRef = CGBitmapContextCreateImage(context) {
					self.texture = SKTexture(CGImage: imageRef)
				} else {
					self.texture = nil
				}
				
				UIGraphicsPopContext()
			}
		} else {
			self.texture = nil
		}
	}
	
}
