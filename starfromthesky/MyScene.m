//
//  MyScene.m
//  starfromthesky
//
//  Created by Paweł Ksieniewicz on 13.09.2013.
//  Copyright (c) 2013 Deathly Owl. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene {
    SKSpriteNode *sprite;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor redColor];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];

        sprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                      -100);

        myLabel.text = @"Star from the Sky!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [sprite runAction:[SKAction moveToY:100 duration:1]];
        
        [self addChild:myLabel];
        [self addChild:sprite];
        
     }
    return self;
}

- (void) steerToX:(CGFloat) x{
    [sprite runAction:[SKAction moveToX:x
                               duration:.25]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        [self steerToX:location.x];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        [self steerToX:location.x];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
