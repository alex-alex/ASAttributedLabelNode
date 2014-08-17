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
        /* Setup your scene here */
		
		let demoURL = NSBundle.mainBundle().URLForResource("demo", withExtension: "rtf")
		let attrStr = NSAttributedString(fileURL: demoURL, options: [NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType], documentAttributes: nil, error: nil)
		
		let myLabel = ASAttributedLabelNode(size: self.size)
		myLabel.attributedString = attrStr
		myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
		self.addChild(myLabel)
		
    }

}
