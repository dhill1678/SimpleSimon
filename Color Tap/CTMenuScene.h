//
//  CTMenuScene.h
//  Color Tap
//
//  Created by Vladimir Vinnik on 05.09.14.
//  Copyright (c) 2014 Vladimir Vinnik. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "CTGameScene.h"
#import "CTSetting.h"
#import "CTSound.h"

@interface CTMenuScene : SKScene {
    NSTimer *timerForChangeColorButtonHardesGameSelect;
    NSTimer *timeToGoBlockBack;
    NSTimer *animateLabelEnd;

    int hardestLevel;
    int oldHardLevel;
    int newHardLevel;
    
    int gameType;
    int colorOR;
    
    BOOL nowAnimateLabel;
    
    CTSound *sound;
}

@property (nonatomic) SKSpriteNode *background;

@property (nonatomic) SKSpriteNode *logo;

@property (nonatomic) SKSpriteNode *buttonHardestGame1;
@property (nonatomic) SKSpriteNode *buttonHardestGame2;
@property (nonatomic) SKSpriteNode *buttonHardestGame3;

@property (nonatomic) SKSpriteNode *buttonHardest1;
@property (nonatomic) SKSpriteNode *buttonHardest2;
@property (nonatomic) SKSpriteNode *buttonHardest3;

@property (nonatomic) SKSpriteNode *blockScore;

@property (nonatomic) SKSpriteNode *buttonHardestGameSelect;
@property (nonatomic) SKSpriteNode *buttonHardestGameNew;

@property (nonatomic) SKSpriteNode *buttonStart;

@property (nonatomic) SKLabelNode *labelBestScore;
@property (nonatomic) SKLabelNode *labelBestScoreCount;

// additional buttons - 2nd Row
@property (nonatomic) SKSpriteNode *buttonHardestGame4;
@property (nonatomic) SKSpriteNode *buttonHardestGame5;
@property (nonatomic) SKSpriteNode *buttonHardestGame6;
@property (nonatomic) SKSpriteNode *buttonHardestGame7;

@property (nonatomic) SKSpriteNode *buttonHardest4;
@property (nonatomic) SKSpriteNode *buttonHardest5;
@property (nonatomic) SKSpriteNode *buttonHardest6;
@property (nonatomic) SKSpriteNode *buttonHardest7;

@property (nonatomic) SKSpriteNode *buttonHardestGameSelect2;
@property (nonatomic) SKSpriteNode *buttonHardestGameNew2;
@property (nonatomic) SKSpriteNode *buttonHardestGameSelect3;
@property (nonatomic) SKSpriteNode *buttonHardestGameNew3;

@end
