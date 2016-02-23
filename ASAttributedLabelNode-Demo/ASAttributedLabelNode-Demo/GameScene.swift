//
//  GameScene.swift
//  ASAttributedLabelNode-Demo
//
//  Created by Alex Studnicka on 17/08/14.
//  Copyright (c) 2014 astudnicka. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
	
    override func didMoveToView(view: SKView) {
		
		guard let demoURL = NSBundle.mainBundle().URLForResource("demo", withExtension: "rtf"),
			attrStr = try? NSAttributedString(fileURL: demoURL, options: [NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType], documentAttributes: nil) else {
			return
		}

		let myLabel = ASAttributedLabelNode(size: size)
		myLabel.attributedString = attrStr
		myLabel.position = CGPoint(x: frame.midX, y: frame.midY)
		addChild(myLabel)
		
    }

}
