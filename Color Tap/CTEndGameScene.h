//
//  CTEndGameScene.h
//  Color Tap
//
//  Created by Vladimir Vinnik on 05.09.14.
//  Copyright (c) 2014 Vladimir Vinnik. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "CTEndGameScene.h"
#import "CTMenuScene.h"
#import "CTSetting.h"
#import "CTSound.h"

@interface CTEndGameScene : SKScene {
    CTSound *sound;
    
    int levelSelected;
    int gameSelected;
    int colorORtext;
    int nowScore;
    int highScore;
}

@property (nonatomic) SKSpriteNode *background;

@property (nonatomic) SKSpriteNode *buttonMenu;
@property (nonatomic) SKSpriteNode *buttonRestart;
@property (nonatomic) SKSpriteNode *buttonTwitter;

@property (nonatomic) SKSpriteNode *buttonGameCenter;

@property (nonatomic) SKLabelNode *labelScore;
@property (nonatomic) SKLabelNode *labelScoreCount;

@property (nonatomic) SKLabelNode *labelBestScore;
@property (nonatomic) SKLabelNode *labelBestScoreCount;

@end
