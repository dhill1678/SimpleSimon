//
//  CTMyScene.h
//  Color Tap
//

//  Copyright (c) 2014 Vladimir Vinnik. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "CTMenuScene.h"
#import "CTEndGameScene.h"
#import "CTSetting.h"
#import "CTSound.h"

@interface CTGameScene : SKScene {
    NSTimer *animateArrayFollow;
    NSTimer *animatePlayerTap;
    NSTimer *animateFrontSide;
    NSTimer *timeToNextStep;
    NSTimer *unlockButton;
    NSTimer *changeLabelText;
    NSTimer *timeToStartGame;
    NSTimer *timeToHideFrontSide;
    
    NSMutableArray *arrayForFollow;
    
    BOOL nowPlayPlayer;
    BOOL lockButton;
    BOOL allArrayComplite;
    
    int score;
    
    int levelSelected;
    int gameSelected;
    int colorORtext;
    float animationSpeedForFollow;
    float animationSpeedBetweenArray;
    
    int nowArrayFollowAnimateObjectCount;
    int nowArrayCountSelect;
    
    CTSound *sound;
}

@property (nonatomic) SKSpriteNode *background;

@property (nonatomic) SKSpriteNode *buttonSelect1;
@property (nonatomic) SKSpriteNode *buttonSelect2;
@property (nonatomic) SKSpriteNode *buttonSelect3;
@property (nonatomic) SKSpriteNode *buttonSelect4;
@property (nonatomic) SKSpriteNode *buttonSelect1Back;
@property (nonatomic) SKSpriteNode *buttonSelect2Back;
@property (nonatomic) SKSpriteNode *buttonSelect3Back;
@property (nonatomic) SKSpriteNode *buttonSelect4Back;

@property (nonatomic) SKSpriteNode *buttonToAnimate;

@property (nonatomic) SKSpriteNode *buttonBack;

@property (nonatomic) SKLabelNode *labelScore;
@property (nonatomic) SKLabelNode *colorLabel;

@property (nonatomic) SKSpriteNode *frontSide;
@property (nonatomic) SKLabelNode *labelFrontSide;
@property (nonatomic) SKLabelNode *labelDesc;

@end
