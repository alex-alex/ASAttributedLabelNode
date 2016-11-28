//
//  ASAttributedLabelNode.h
//
//  Created by Peter Easdown on 27/11/16.
//  Inspired by Alex Studnicka
//

#import <SpriteKit/SpriteKit.h>

@interface ASAttributedLabelNode : SKSpriteNode

@property (nonatomic, retain) NSAttributedString *attributedText;

- (id) initWithSize:(CGSize)size;

@end
