//
//  MyScene.m
//  starfromthesky
//
//  Created by Paweł Ksieniewicz on 13.09.2013.
//  Copyright (c) 2013 Deathly Owl. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene {
    SKSpriteNode *dog;
    SKAction *walkingDog;
    SKAction *standingDog;
}

- (void) makeDog {
    SKTexture *dogTexture = [SKTexture textureWithImageNamed:@"dog"];
    SKTexture *dogWalk1Texture = [SKTexture textureWithImageNamed:@"dog_walk1"];
    SKTexture *dogWalk2Texture = [SKTexture textureWithImageNamed:@"dog_walk2"];
    
    walkingDog = [SKAction animateWithTextures:@[dogTexture,dogWalk1Texture,dogWalk2Texture]
                                  timePerFrame:.1 resize:NO restore:YES];
    
    dog = [SKSpriteNode spriteNodeWithTexture:dogTexture];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithWhite:.9 alpha:1];

        SKLabelNode *textNode = [SKLabelNode labelNodeWithFontNamed:@"HydrophiliaIced"];
        
        [textNode setFontSize:11];
        [textNode setText:@"Hello, world!"];
        [textNode setFontColor:[SKColor blackColor]];
        [textNode setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
        
        [self addChild:textNode];
        
        [self makeDog];

        dog.position = CGPointMake(0,144);

        [self addChild:dog];
    }
    return self;
}

- (void) moveDogToLocation:(CGPoint) location{
    [dog removeAllActions];
    
    if (location.x > dog.position.x) [dog setXScale:-1];
    else [dog setXScale:1];
    
    [dog runAction:[SKAction repeatActionForever:walkingDog]];
    [dog runAction:[SKAction moveTo:location duration:2]
        completion:^(){
            [dog removeAllActions];
        }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint location = [[touches anyObject] locationInNode:self];
    [self moveDogToLocation:CGPointMake(location.x, 144)];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
