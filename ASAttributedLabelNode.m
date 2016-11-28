//
//  ASAttributedLabelNode.h
//
//  Created by Peter Easdown on 27/11/16.
//  Inspired by Alex Studnicka
//

#import "ASAttributedLabelNode.h"

@implementation ASAttributedLabelNode

- (id) initWithSize:(CGSize)size {
    self = [super initWithColor:[UIColor clearColor] size:size];
    
    return self;
}

- (void) setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    
    [self draw];
}

- (void) draw {
    NSAttributedString *attrStr = self.attributedText;
    
    if (attrStr == nil) {
        self.texture = nil;
        
        return;
    }
    
    float scaleFactor = [UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageAlphaInfo bitmapInfo = kCGImageAlphaPremultipliedLast;
    CGContextRef context = CGBitmapContextCreate(nil, self.size.width * scaleFactor, self.size.height * scaleFactor, 8, (self.size.width * scaleFactor) * 4, colorSpace, bitmapInfo);
    
    if (context == nil) {
        return;
    }

    CGContextScaleCTM(context, scaleFactor, scaleFactor);
    CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, self.size.height));
    UIGraphicsPushContext(context);
    
    float strHeight = [attrStr boundingRectWithSize:self.size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    float yOffset = (self.size.height - strHeight) / 2.0;
    CGRect rect = CGRectMake(0.0, yOffset, self.size.width, strHeight);
    [attrStr drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    if (imageRef != nil) {
        self.texture = [SKTexture textureWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    
    UIGraphicsPopContext();
}

@end
