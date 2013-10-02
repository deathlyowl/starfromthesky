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
    SKSpriteNode *protagonist;
    
    SKAction *walkingProtagonist;
    
    SKAction *walkingDog;
}

- (void) makeProtagonist{
    SKTexture *protagonistTexture = [SKTexture textureWithImageNamed:@"man"];
    SKTexture *protagonistSideTexture = [SKTexture textureWithImageNamed:@"man_side"];
    SKTexture *protagonistSwitchTexture = [SKTexture textureWithImageNamed:@"man_switch"];
    SKTexture *protagonistWalk1Texture = [SKTexture textureWithImageNamed:@"man_walk2"];
    SKTexture *protagonistWalk2Texture = [SKTexture textureWithImageNamed:@"man_walk1"];
    
    walkingProtagonist = [SKAction animateWithTextures:@[protagonistSideTexture,protagonistWalk1Texture,protagonistWalk2Texture,protagonistSwitchTexture]
                                          timePerFrame:.1
                                                resize:NO
                                               restore:YES];
    
    protagonist = [SKSpriteNode spriteNodeWithTexture:protagonistTexture];
}

- (void) makeDog {
    SKTexture *dogTexture = [SKTexture textureWithImageNamed:@"dog"];
    SKTexture *dogWalk1Texture = [SKTexture textureWithImageNamed:@"dog_walk1"];
    SKTexture *dogWalk2Texture = [SKTexture textureWithImageNamed:@"dog_walk2"];
    
    walkingDog = [SKAction animateWithTextures:@[dogTexture,dogWalk1Texture,dogWalk2Texture]
                                  timePerFrame:.1
                                        resize:NO
                                       restore:YES];
    
    dog = [SKSpriteNode spriteNodeWithTexture:dogTexture];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithWhite:.9 alpha:1];
        
        [self makeDog];
        [self makeProtagonist];
        
        protagonist.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));

        dog.position = CGPointMake(40,144);
        
        [self addChild:dog];
        [self addChild:protagonist];
    }
    return self;
}

- (void) moveProtagonistToLocation:(CGPoint) location{
    [protagonist removeAllActions];
    
    if (location.x > protagonist.position.x) [protagonist setXScale:1];
    else [protagonist setXScale:-1];
    if (abs(protagonist.position.x - dog.position.x) > 40) {
        NSLog(@"!!!");
        [self moveDogToLocation:protagonist.position];
    }
    [protagonist runAction:[SKAction repeatActionForever:walkingProtagonist]];
    [protagonist runAction:[SKAction moveTo:location duration:2]
                completion:^(){
                    [protagonist removeAllActions];
                    
                }];
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
    [self moveProtagonistToLocation:location];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
   
}

@end
