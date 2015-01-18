//
//  CTEndGameScene.m
//  Color Tap
//
//  Created by Vladimir Vinnik on 05.09.14.
//  Copyright (c) 2014 Vladimir Vinnik. All rights reserved.
//

#import "CTEndGameScene.h"
#import "CTViewController.h"
#import <RevMobAds/RevMobAds.h>
#import <GameKit/GameKit.h>

@implementation CTEndGameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //Send message to CTViewController to show iAd.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showAd" object:nil];
        
        // Serve RevMob ad
        [self initialiseRevMob:@"549a4ace6aa1a4cd5b621364" testMode:NO];
        [self revmobShowAd];
        
        //Initial sound class
        sound = [[CTSound alloc] init];
        [sound initSound];
        
        levelSelected = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"hardLevel"];
        gameSelected = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"Type"];
        colorORtext = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"colorText"];
        
        //Set best score
        if (gameSelected == 1 && colorORtext == 1) {
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel1"] > [[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel1"]) {
                [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel1"] forKey:@"bestScoreHardestLevel1"];
                
                // Report Score to leaderboard
                GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier: @"55118338"];
                scoreReporter.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel1"];
                scoreReporter.context = 0;
                
                [GKScore reportScores:@[scoreReporter] withCompletionHandler:^(NSError *error) {
                    if (error == nil) {
                        NSLog(@"Score reported successfully!");
                    } else {
                        NSLog(@"Unable to report score!");
                    }
                }];
                
                [sound playHighScore];
            } else {
                [sound playGameOver];
            }
            nowScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel1"];
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel1"];
        }
        else if (gameSelected == 1 && colorORtext == 2) {
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel2"] > [[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel2"]) {
                [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel2"] forKey:@"bestScoreHardestLevel2"];
                
                // Report Score to leaderboard
                GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier: @"55118336"];
                scoreReporter.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel2"];
                scoreReporter.context = 0;
                
                [GKScore reportScores:@[scoreReporter] withCompletionHandler:^(NSError *error) {
                    if (error == nil) {
                        NSLog(@"Score reported successfully!");
                    } else {
                        NSLog(@"Unable to report score!");
                    }
                }];
                
                [sound playHighScore];
            } else {
                [sound playGameOver];
            }
            nowScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel2"];
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel2"];
        }
        else if (gameSelected == 2 && colorORtext == 1) {
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel3"] > [[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel3"]) {
                [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel3"] forKey:@"bestScoreHardestLevel3"];
                
                // Report Score to leaderboard
                GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier: @"55118339"];
                scoreReporter.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel3"];
                scoreReporter.context = 0;
                
                [GKScore reportScores:@[scoreReporter] withCompletionHandler:^(NSError *error) {
                    if (error == nil) {
                        NSLog(@"Score reported successfully!");
                    } else {
                        NSLog(@"Unable to report score!");
                    }
                }];
                
                [sound playHighScore];
            } else {
                [sound playGameOver];
            }
            nowScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel3"];
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel3"];
        }
        else {
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel4"] > [[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel4"]) {
                [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel4"] forKey:@"bestScoreHardestLevel4"];
                
                // Report Score to leaderboard
                GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier: @"55118337"];
                scoreReporter.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel4"];
                scoreReporter.context = 0;
                
                [GKScore reportScores:@[scoreReporter] withCompletionHandler:^(NSError *error) {
                    if (error == nil) {
                        NSLog(@"Score reported successfully!");
                    } else {
                        NSLog(@"Unable to report score!");
                    }
                }];
                
                [sound playHighScore];
            } else {
                [sound playGameOver];
            }
            nowScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreHardestLevel4"];
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel4"];
        }
        
        [self setButtons];
        [self setLabels];
        [self setBackground];
        [self setButtonGameCenter];
    }
    return self;
}

#pragma mark Node

- (void)setBackground {
    //Set image, size and positions to node
    _background = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
    _background.size = CGSizeMake(self.frame.size.width , self.frame.size.height);
    _background.position = CGPointMake(self.frame.size.width - (_background.size.width / 2), self.frame.size.height - (_background.size.height / 2));
    _background.zPosition = 5;
    //Add node to scene
    [self addChild:_background];
}

// set start button and position - may need to be moved down
- (void)setButtonGameCenter {
    //Set object image size and position.
    _buttonGameCenter = [SKSpriteNode spriteNodeWithImageNamed:@"leaderboards"];
    _buttonGameCenter.size = CGSizeMake(SIZE_OF_BUTTON_START * 1.3, SIZE_OF_BUTTON_START / 3.7);
    _buttonGameCenter.position = CGPointMake(self.frame.size.width / 2, POSITION_OF_BUTTONS_END_SCENE_Y-(SIZE_OF_BUTTON_END_SCENE*1.2)); // y position altered to lower button
    _buttonGameCenter.zPosition = 40;
    //Add object to scene
    [self addChild:_buttonGameCenter];
}

- (void)setButtons {
    CGPoint locationButtons = CGPointMake(self.frame.size.width / 2 - (SIZE_OF_BUTTON_END_SCENE + INTERVAL_OF_BUTTON_END_SCENE), POSITION_OF_BUTTONS_END_SCENE_Y);
    
    //Set object image size and position.
    _buttonMenu = [SKSpriteNode spriteNodeWithImageNamed:@"buttonMenuEndScene"];
    _buttonMenu.size = CGSizeMake(SIZE_OF_BUTTON_END_SCENE, SIZE_OF_BUTTON_END_SCENE);
    _buttonMenu.position = locationButtons;
    _buttonMenu.zPosition = 10;
    //Add object to scene
    [self addChild:_buttonMenu];
    
    locationButtons.x += SIZE_OF_BUTTON_END_SCENE + INTERVAL_OF_BUTTON_END_SCENE;
    
    //Set object image size and position.
    _buttonRestart = [SKSpriteNode spriteNodeWithImageNamed:@"buttonRestartEndScene"];
    _buttonRestart.size = CGSizeMake(SIZE_OF_BUTTON_END_SCENE, SIZE_OF_BUTTON_END_SCENE);
    _buttonRestart.position = locationButtons;
    _buttonRestart.zPosition = 10;
    //Add object to scene
    [self addChild:_buttonRestart];
    
    locationButtons.x += SIZE_OF_BUTTON_END_SCENE + INTERVAL_OF_BUTTON_END_SCENE;
    
    //Set object image size and position.
    _buttonTwitter = [SKSpriteNode spriteNodeWithImageNamed:@"buttonTwitterEndScene"];
    _buttonTwitter.size = CGSizeMake(SIZE_OF_BUTTON_END_SCENE, SIZE_OF_BUTTON_END_SCENE);
    _buttonTwitter.position = locationButtons;
    _buttonTwitter.zPosition = 10;
    //Add object to scene
    [self addChild:_buttonTwitter];
}

- (void)setLabels {
    //Set font style
    _labelScoreCount = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _labelScoreCount.fontSize = FONT_SIZE_END * 2;
    }
    else {
        _labelScoreCount.fontSize = FONT_SIZE_END;
    }
    //Set font color
    _labelScoreCount.fontColor = FONT_COLOR_DARK;
    //Set positions of object
    _labelScoreCount.position = CGPointMake(self.frame.size.width / 4, POSITION_OF_LABEL_SCORE_COUN_END_SCENE_Y);
    _labelScoreCount.zPosition = 40;
    //Set text to label
    _labelScoreCount.text = [NSString stringWithFormat:@"%d", nowScore];
    //Add object to scene
    [self addChild:_labelScoreCount];
    
    //Set font style
    _labelScore = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _labelScore.fontSize = FONT_SIZE * 2;
    }
    else {
        _labelScore.fontSize = FONT_SIZE;
    }
    //Set font color
    _labelScore.fontColor = FONT_COLOR_DARK;
    //Set positions of object
    _labelScore.position = CGPointMake(self.frame.size.width / 4, POSITION_OF_LABEL_SCORE_END_SCENE_Y);
    _labelScore.zPosition = 40;
    //Set text to label
    _labelScore.text = @"Your Score";
    //Add object to scene
    [self addChild:_labelScore];
    
    //Set best font style
    _labelBestScoreCount = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _labelBestScoreCount.fontSize = FONT_SIZE_END * 2;
    }
    else {
        _labelBestScoreCount.fontSize = FONT_SIZE_END;
    }
    //Set font color
    _labelBestScoreCount.fontColor = FONT_COLOR_DARK;
    //Set positions of object
    _labelBestScoreCount.position = CGPointMake(3 * (self.frame.size.width / 4), POSITION_OF_LABEL_SCORE_COUN_END_SCENE_Y);
    _labelBestScoreCount.zPosition = 40;
    //Set text to label
    _labelBestScoreCount.text = [NSString stringWithFormat:@"%d", highScore];
    //Add object to scene
    [self addChild:_labelBestScoreCount];
    
    //Set best font style
    _labelBestScore = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _labelBestScore.fontSize = FONT_SIZE * 2;
    }
    else {
        _labelBestScore.fontSize = FONT_SIZE;
    }
    //Set font color
    _labelBestScore.fontColor = FONT_COLOR_DARK;
    //Set positions of object
    _labelBestScore.position = CGPointMake(3 * (self.frame.size.width / 4), POSITION_OF_LABEL_SCORE_END_SCENE_Y);
    _labelBestScore.zPosition = 40;
    //Set text to label
    _labelBestScore.text = @"High Score";
    //Add object to scene
    [self addChild:_labelBestScore];
}

#pragma mark Touches Action

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if ([_buttonMenu containsPoint:location]) {
            [self changeSceneToMenu];
            [sound playButtonClick];
        }
        if ([_buttonRestart containsPoint:location]) {
            [self changeSceneToGame];
            [sound playButtonClick];
        }
        if ([_buttonTwitter containsPoint:location]) {
            //Call method from CTViewController.m for get twitter message
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendTwitter" object:nil];
            [sound playButtonClick];
        }
        if ([_buttonGameCenter containsPoint:location]) {
            // Open leaderboards.
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showLeaderboardOnViewController" object:nil];
            [sound playButtonClick];
        }
    }
}

#pragma mark RevMob methods

-(void)revmobAdDidFailWithError:(NSError *)error {
    if(error) {
        NSLog(@"%@",error);
    }
}

-(void)initialiseRevMob: (NSString*)appID testMode:(BOOL)testModeEnable {
    
    if(testModeEnable == YES) {
        [RevMobAds startSessionWithAppID:appID];
        [RevMobAds session].testingMode = RevMobAdsTestingModeWithAds;
    }
    else {
        [RevMobAds startSessionWithAppID:appID];
    }
}

-(void)revmobShowAd {
    [[RevMobAds session] showFullscreen];
}

#pragma mark Change Scene

- (void)changeSceneToGame {
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    // Create and configure the scene.
    SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionRight duration:TIME_TO_CHANGE_SCENE];
    SKScene *level = [[CTGameScene alloc] initWithSize:skView.bounds.size];
    
    [self.view presentScene:level transition:reveal];
}

- (void)changeSceneToMenu {
    // Serve RevMob ad
    [self initialiseRevMob:@"549a4ace6aa1a4cd5b621364" testMode:NO];
    [self revmobShowAd];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    // Create and configure the scene.
    SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionRight duration:TIME_TO_CHANGE_SCENE];
    SKScene *level = [[CTMenuScene alloc] initWithSize:skView.bounds.size];
    
    [self.view presentScene:level transition:reveal];
}

// Close leaderboards
//- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
  //  [self dismissModalViewControllerAnimated:YES];
//}
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [gameCenterViewController dismissViewControllerAnimated:YES completion:^{
    }];
}
 

@end
