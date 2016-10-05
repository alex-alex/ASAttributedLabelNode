//
//  ASAttributedLabelNode.swift
//
//  Created by Alex Studnicka on 15/08/14.
//  Copyright © 2016 Alex Studnicka. MIT License.
//

import UIKit
import SpriteKit

class ASAttributedLabelNode: SKSpriteNode {
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	init(size: CGSize) {
		super.init(texture: nil, color: UIColor.clear, size: size)
	}
	
	var attributedString: NSAttributedString! {
		didSet {
			draw()
		}
	}
	
	func draw() {
		guard let attrStr = attributedString else {
			texture = nil
			return
		}
		
		let scaleFactor = UIScreen.main.scale
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
		guard let context = CGContext(data: nil, width: Int(size.width * scaleFactor), height: Int(size.height * scaleFactor), bitsPerComponent: 8, bytesPerRow: Int(size.width * scaleFactor) * 4, space: colorSpace, bitmapInfo: bitmapInfo) else {
			return
		}

		context.scaleBy(x: scaleFactor, y: scaleFactor)
		context.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
		UIGraphicsPushContext(context)
		
		let strHeight = attrStr.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil).height
		let yOffset = (size.height - strHeight) / 2.0
		attrStr.draw(with: CGRect(x: 0, y: yOffset, width: size.width, height: strHeight), options: .usesLineFragmentOrigin, context: nil)
		
		if let imageRef = context.makeImage() {
			texture = SKTexture(cgImage: imageRef)
		} else {
			texture = nil
		}
		
		UIGraphicsPopContext()
	}
	
}
