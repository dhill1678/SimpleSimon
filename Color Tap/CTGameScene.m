//
//  CTMyScene.m
//  Color Tap
//
//  Created by Vladimir Vinnik on 05.09.14.
//  Copyright (c) 2014 Vladimir Vinnik. All rights reserved.
//

#import "CTGameScene.h"
#import <RevMobAds/RevMobAds.h>

@implementation CTGameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        //Send message to CTViewController to hide iAd.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideAd" object:nil];
        
        //Initial sound class
        sound = [[CTSound alloc] init];
        [sound initSound];
        
        //Setting
        levelSelected = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"hardLevel"];
        gameSelected = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"Type"];
        colorORtext = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"colorText"];
        if (levelSelected == 1) {
            animationSpeedForFollow = TIME_TO_ANIMATION_BUTTON_LEVEL_1;
            animationSpeedBetweenArray = TIME_TO_ANIMATION_ARRAY_FOLLOW_1;
        }
        else if (levelSelected == 2) {
            animationSpeedForFollow = TIME_TO_ANIMATION_BUTTON_LEVEL_2;
            animationSpeedBetweenArray = TIME_TO_ANIMATION_ARRAY_FOLLOW_2;
        }
        else {
            animationSpeedForFollow = TIME_TO_ANIMATION_BUTTON_LEVEL_3;
            animationSpeedBetweenArray = TIME_TO_ANIMATION_ARRAY_FOLLOW_3;
        }
        
        //Set interface
        [self setButtonBack];
        [self setButtonsSelect];
        [self setLabelScore];
        [self setBackground];
        
        //Initial array
        arrayForFollow = [[NSMutableArray alloc] init];
        
        //Start game
        timeToStartGame = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startGameWithDelay) userInfo:nil repeats:NO];
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

- (void)setButtonBack {
    //Set image, size and positions to node
    _buttonBack = [SKSpriteNode spriteNodeWithImageNamed:@"buttonMenu"];
    _buttonBack.size = CGSizeMake(SIZE_OF_BUTTON_BACK_GAME_SCENE, SIZE_OF_BUTTON_BACK_GAME_SCENE / 3.5);
    _buttonBack.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - _buttonBack.size.height / 2);
    _buttonBack.zPosition = 10;
    //Add node to scene
    [self addChild:_buttonBack];
}

- (void)setLabelScore {
    //Set font name
    _labelScore = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _labelScore.fontSize = FONT_SIZE_LABEL_SCORE * 2;
    }
    else {
        _labelScore.fontSize = FONT_SIZE_LABEL_SCORE;
    }
    //Set font color
    _labelScore.fontColor = FONT_COLOR_DARK;
    //Set object positions
    _labelScore.zPosition = 30;
    _labelScore.position = CGPointMake(self.frame.size.width / 2, POSITION_OF_LABEL_SCORE_COUNT_GAME_SCENE_Y);
    //Set label text
    _labelScore.text = @"0";
    //Add object to scene
    [self addChild:_labelScore];

}

- (void)setButtonsSelect {
    //////////////////////////////////////////////////
    //             Positions of buttons             //
    //////////////////////////////////////////////////
    //                                              //
    //                                              //
    //                                              //
    //         1 button            2 button         //
    //                                              //
    //                                              //
    //                                              //
    //         3 button            4 button         //
    //                                              //
    //                                              //
    //                                              //
    //////////////////////////////////////////////////
    
    //Set start location for initial game buttons
    CGPoint locationButtons = CGPointMake(self.frame.size.width / 2 - (SIZE_OF_BUTTON_SELECT / 2 + INTERVAL_OF_BUTTON_SELECT / 2), POSITION_OF_BUTTONS_SELECT_Y);
    
    //Set image, size and positions to node
    _buttonSelect1 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonCircle1"];
    _buttonSelect1.size = CGSizeMake(SIZE_OF_BUTTON_SELECT, SIZE_OF_BUTTON_SELECT);
    _buttonSelect1.position = locationButtons;
    _buttonSelect1.zPosition = 30;
    //Add node to scene
    [self addChild:_buttonSelect1];
    
    //Change locations for next buttons
    locationButtons.x += SIZE_OF_BUTTON_SELECT + INTERVAL_OF_BUTTON_SELECT;
    
    //Set image, size and positions to node
    _buttonSelect2 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonCircle2"];
    _buttonSelect2.size = CGSizeMake(SIZE_OF_BUTTON_SELECT, SIZE_OF_BUTTON_SELECT);
    _buttonSelect2.position = locationButtons;
    _buttonSelect2.zPosition = 30;
    //Add node to scene
    [self addChild:_buttonSelect2];
    
    //Change locations for next buttons
    locationButtons.x = self.frame.size.width / 2 - (SIZE_OF_BUTTON_SELECT / 2 + INTERVAL_OF_BUTTON_SELECT / 2);
    locationButtons.y -= SIZE_OF_BUTTON_SELECT + INTERVAL_OF_BUTTON_SELECT;
    
    //Set image, size and positions to node
    _buttonSelect3 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonCircle3"];
    _buttonSelect3.size = CGSizeMake(SIZE_OF_BUTTON_SELECT, SIZE_OF_BUTTON_SELECT);
    _buttonSelect3.position = locationButtons;
    _buttonSelect3.zPosition = 35;
    //Add node to scene
    [self addChild:_buttonSelect3];
    
    //Change locations for next buttons
    locationButtons.x += SIZE_OF_BUTTON_SELECT + INTERVAL_OF_BUTTON_SELECT;
    
    //Set image, size and positions to node
    _buttonSelect4 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonCircle4"];
    _buttonSelect4.size = CGSizeMake(SIZE_OF_BUTTON_SELECT, SIZE_OF_BUTTON_SELECT);
    _buttonSelect4.position = locationButtons;
    _buttonSelect4.zPosition = 35;
    //Add node to scene
    [self addChild:_buttonSelect4];
    
    //Set image, size and positions to node
    _buttonSelect1Back = [SKSpriteNode spriteNodeWithImageNamed:@"buttonCircleSelect1"];
    _buttonSelect1Back.size = _buttonSelect1.size;
    _buttonSelect1Back.position = _buttonSelect1.position;
    _buttonSelect1Back.zPosition = 29;
    //Add node to scene
    [self addChild:_buttonSelect1Back];
    
    //Set image, size and positions to node
    _buttonSelect2Back = [SKSpriteNode spriteNodeWithImageNamed:@"buttonCircleSelect2"];
    _buttonSelect2Back.size = _buttonSelect2.size;
    _buttonSelect2Back.position = _buttonSelect2.position;
    _buttonSelect2Back.zPosition = 29;
    //Add node to scene
    [self addChild:_buttonSelect2Back];
    
    //Set image, size and positions to node
    _buttonSelect3Back = [SKSpriteNode spriteNodeWithImageNamed:@"buttonCircleSelect3"];
    _buttonSelect3Back.size = _buttonSelect3.size;
    _buttonSelect3Back.position = _buttonSelect3.position;
    _buttonSelect3Back.zPosition = 34;
    //Add node to scene
    [self addChild:_buttonSelect3Back];
    
    //Set image, size and positions to node
    _buttonSelect4Back = [SKSpriteNode spriteNodeWithImageNamed:@"buttonCircleSelect4"];
    _buttonSelect4Back.size = _buttonSelect4.size;
    _buttonSelect4Back.position = _buttonSelect4.position;
    _buttonSelect4Back.zPosition = 34;
    //Add node to scene
    [self addChild:_buttonSelect4Back];
}

- (void)setFrontSideWithText:(NSString *)text {
    //Set color, size and positions to node
    _frontSide = [SKSpriteNode spriteNodeWithColor:FONT_COLOR_WHITE size:CGSizeMake(self.frame.size.width, self.frame.size.height)];
    _frontSide.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _frontSide.zPosition = 100;
    _frontSide.alpha = 0.6;
    //Add node to scene
    [self addChild:_frontSide];
    
    //Set font for label node
    _labelFrontSide = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size for iPad and iPhone
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _labelFrontSide.fontSize = FONT_SIZE_END * 2;
    }
    else {
        _labelFrontSide.fontSize = FONT_SIZE_END;
    }
    //Set positions and other
    _labelFrontSide.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _labelFrontSide.text = text;
    _labelFrontSide.fontColor = FONT_COLOR_DARK;
    _labelFrontSide.zPosition = 101;
    
    if (gameSelected == 1 && colorORtext == 1 && text.length > 4) {
        //Set font for label node
        _labelDesc = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        //Set different font size for iPad and iPhone
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
            _labelDesc.fontSize = FONT_SIZE_END;
            _labelDesc.position = CGPointMake(self.frame.size.width / 2, ((self.frame.size.height / 2) - FONT_SIZE_END*2));
        }
        else {
            _labelDesc.fontSize = FONT_SIZE_END/2;
            _labelDesc.position = CGPointMake(self.frame.size.width / 2, (self.frame.size.height / 2) - FONT_SIZE_END);
        }
        //Set positions and other
        _labelDesc.text = @"Highlighted Buttons";
        _labelDesc.fontColor = FONT_COLOR_DARK;
        _labelDesc.zPosition = 101;
    } else if (gameSelected == 1 && colorORtext == 2 && text.length > 4) {
        //Set font for label node
        _labelDesc = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        //Set different font size for iPad and iPhone
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
            _labelDesc.fontSize = FONT_SIZE_END;
            _labelDesc.position = CGPointMake(self.frame.size.width / 2, ((self.frame.size.height / 2) - FONT_SIZE_END*2));
        }
        else {
            _labelDesc.fontSize = FONT_SIZE_END/2;
            _labelDesc.position = CGPointMake(self.frame.size.width / 2, (self.frame.size.height / 2) - FONT_SIZE_END);
        }
        //Set positions and other
        _labelDesc.text = @"Text";
        _labelDesc.fontColor = FONT_COLOR_DARK;
        _labelDesc.zPosition = 101;
    } else if (gameSelected == 2 && colorORtext == 1 && text.length > 4) {
        //Set font for label node
        _labelDesc = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        //Set different font size for iPad and iPhone
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
            _labelDesc.fontSize = FONT_SIZE_END;
            _labelDesc.position = CGPointMake(self.frame.size.width / 2, ((self.frame.size.height / 2) - FONT_SIZE_END*2));
        }
        else {
            _labelDesc.fontSize = FONT_SIZE_END/2;
            _labelDesc.position = CGPointMake(self.frame.size.width / 2, (self.frame.size.height / 2) - FONT_SIZE_END);
        }
        //Set positions and other
        _labelDesc.text = @"Text Color";
        _labelDesc.fontColor = FONT_COLOR_DARK;
        _labelDesc.zPosition = 101;
    } else if (gameSelected == 2 && colorORtext == 2 && text.length > 4) {
        //Set font for label node
        _labelDesc = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        //Set different font size for iPad and iPhone
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
            _labelDesc.fontSize = FONT_SIZE_END;
            _labelDesc.position = CGPointMake(self.frame.size.width / 2, ((self.frame.size.height / 2) - FONT_SIZE_END*2));
        }
        else {
            _labelDesc.fontSize = FONT_SIZE_END/2;
            _labelDesc.position = CGPointMake(self.frame.size.width / 2, (self.frame.size.height / 2) - FONT_SIZE_END);
        }
        //Set positions and other
        _labelDesc.text = @"Text";
        _labelDesc.fontColor = FONT_COLOR_DARK;
        _labelDesc.zPosition = 101;
    }
    //Add node to scene
    [self addChild:_labelFrontSide];
    [self addChild:_labelDesc];

    //Hide after time
    timeToHideFrontSide = [NSTimer scheduledTimerWithTimeInterval:TIME_TO_DELAY_FRONT_SIDE target:self selector:@selector(startHideAnimationToFrontSide) userInfo:nil repeats:NO];
}

#pragma mark Game

- (void)startGame {
    //Start game method
    nowPlayPlayer = YES;
    [self nextStep];
}

- (void)startGameWithDelay {
    [self startGame];
}

- (void)endGame {
    //Save results and change scene
    if (gameSelected == 1 && colorORtext == 1) {
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"scoreHardestLevel1"];
    }
    else if (gameSelected == 1 && colorORtext == 2) {
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"scoreHardestLevel2"];
    }
    else if (gameSelected == 2 && colorORtext == 1) {
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"scoreHardestLevel3"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"scoreHardestLevel4"];
    }
    
    [self changeSceneToEnd];
}

- (void)nextStep {
    //Change following/player mode
    //if (nowPlayPlayer) { nowPlayPlayer = NO;}
    //else { nowPlayPlayer = YES;}
    
    //Start animation fronSide node and call method "afterAnimationFrontSide"
    if (!nowPlayPlayer) {
        [self setFrontSideWithText:@"Play"];
        animateFrontSide = [NSTimer scheduledTimerWithTimeInterval:TIME_TO_ANIMATION_FRONT_SIDE + TIME_TO_DELAY_FRONT_SIDE target:self selector:@selector(afterAnimationFrontSide) userInfo:nil repeats:NO];
        nowPlayPlayer = YES; //added to remove crash when button press during play screen
    }
    else {
        [self setFrontSideWithText:@"Memorize"];
        animateFrontSide = [NSTimer scheduledTimerWithTimeInterval:TIME_TO_ANIMATION_FRONT_SIDE +TIME_TO_DELAY_FRONT_SIDE target:self selector:@selector(afterAnimationFrontSide) userInfo:nil repeats:NO];
        nowPlayPlayer = NO; //added
    }
}

- (void)addNewItemToArrayFollow {
    //Get random int
    int random = arc4random() % 4;
    
    //And set it to array
    if (random == 0) {
        [arrayForFollow addObject:@"0"];
    }
    else if (random == 1) {
        [arrayForFollow addObject:@"1"];
    }
    else if (random == 2) {
        [arrayForFollow addObject:@"2"];
    }
    else {
        [arrayForFollow addObject:@"3"];
    }
}

- (void)pickColor {
    //Get random int
    int random = arc4random() % 4;
    
    //And set it to array
    //Run action
    if (random == 0) {
        //Set font color
        _colorLabel.fontColor = [UIColor colorWithRed:(255/255.0) green:(206/255.0) blue:(119/255.0) alpha:1];
    }
    else if (random == 1) {
        //Set font color
        _colorLabel.fontColor = [UIColor colorWithRed:(99/255.0) green:(143/255.0) blue:(192/255.0) alpha:1];
    }
    else if (random == 2) {
        //Set font color
        _colorLabel.fontColor = [UIColor colorWithRed:(56/255.0) green:(194/255.0) blue:(158/255.0) alpha:1];
    }
    else {
        //Set font color
        _colorLabel.fontColor = [UIColor colorWithRed:(254/255.0) green:(75/255.0) blue:(97/255.0) alpha:1];
    }
}

- (void)pickLabel {
    //Get random int
    int random = arc4random() % 4;
    
    //And set it to array
    //Run action
    if (random == 0) {
        //Set label text
        _colorLabel.text = @"Yellow";
    }
    else if (random == 1) {
        //Set label text
        _colorLabel.text = @"Blue";
    }
    else if (random == 2) {
        //Set label text
        _colorLabel.text = @"Green";
    }
    else {
        //Set label text
        _colorLabel.text = @"Red";
    }
}

- (void)animateArrayFollow {
    //Animate buttons from array info
    if ([[arrayForFollow objectAtIndex:nowArrayFollowAnimateObjectCount] isEqualToString:@"0"]) {
        if (gameSelected == 1) {
            if (colorORtext == 1) {
                [self animateButton:0];
            } else {
                [self setLabelColor:0];
            }
        } else {
            [self setLabelColor:0];
        }
    }
    if ([[arrayForFollow objectAtIndex:nowArrayFollowAnimateObjectCount] isEqualToString:@"1"]) {
        if (gameSelected == 1) {
            if (colorORtext == 1) {
                [self animateButton:1];
            } else {
                [self setLabelColor:1];
            }
        } else {
            [self setLabelColor:1];
        }
    }
    if ([[arrayForFollow objectAtIndex:nowArrayFollowAnimateObjectCount] isEqualToString:@"2"]) {
        if (gameSelected == 1) {
            if (colorORtext == 1) {
                [self animateButton:2];
            } else {
                [self setLabelColor:2];
            }
        } else {
            [self setLabelColor:2];
        }
    }
    if ([[arrayForFollow objectAtIndex:nowArrayFollowAnimateObjectCount] isEqualToString:@"3"]) {
        if (gameSelected == 1) {
            if (colorORtext == 1) {
                [self animateButton:3];
            } else {
                [self setLabelColor:3];
            }
        } else {
            [self setLabelColor:3];
        }
    }
    
    //Check end of array if no animate next object
    nowArrayFollowAnimateObjectCount++;
    if (nowArrayFollowAnimateObjectCount == [arrayForFollow count]) {
        timeToNextStep = [NSTimer scheduledTimerWithTimeInterval:animationSpeedForFollow + animationSpeedBetweenArray target:self selector:@selector(nextStepAfterTimer) userInfo:nil repeats:NO];
    }
    else {
        animateArrayFollow = [NSTimer scheduledTimerWithTimeInterval:animationSpeedBetweenArray + animationSpeedForFollow target:self selector:@selector(animateArrayFollow) userInfo:nil repeats:NO];
    }
}

- (void)input:(int)value {
    BOOL win = YES;
    
    //If dont correct input change boolean value
    if (!allArrayComplite) {
        if (value == 0) {
            if (![[arrayForFollow objectAtIndex:nowArrayCountSelect] isEqualToString:@"0"]) {
                win = NO;
            }
        }
        else if (value == 1) {
            if (![[arrayForFollow objectAtIndex:nowArrayCountSelect] isEqualToString:@"1"]) {
                win = NO;
            }
        }
        else if (value == 2) {
            if (![[arrayForFollow objectAtIndex:nowArrayCountSelect] isEqualToString:@"2"]) {
                win = NO;
            }
        }
        else {
            if (![[arrayForFollow objectAtIndex:nowArrayCountSelect] isEqualToString:@"3"]) {
                win = NO;
            }
        }
    }
    
    //If correct input
    if (win) {
        nowArrayCountSelect++;
        lockButton = YES;
        //If last object in array
        if (nowArrayCountSelect == [arrayForFollow count]) {
            allArrayComplite = YES;
            
            score += levelSelected;
            [self animationAddScore:value];
            
            timeToNextStep = [NSTimer scheduledTimerWithTimeInterval:TIME_TO_ANIMATION_BUTTON_PLAYER * 2 target:self selector:@selector(nextStepAfterTimer) userInfo:nil repeats:NO];
        }
    }
    else {
        [self endGame];
    }
}

- (void)setLabelColor:(int)value {
    //Lock button
    //added to remove crash when button press during play screen
    if (!nowPlayPlayer) {
        lockButton = YES;
    } else {
        lockButton = NO;
    }
    
    //Set font name
    _colorLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _colorLabel.fontSize = FONT_SIZE_LABEL_SCORE * 2;
    }
    else {
        _colorLabel.fontSize = FONT_SIZE_LABEL_SCORE;
    }
    //Set object positions
    _colorLabel.zPosition = 30;
    _colorLabel.position = CGPointMake(self.frame.size.width / 2, POSITION_OF_LABEL_SCORE_COUNT_GAME_SCENE_Y - ((POSITION_OF_LABEL_SCORE_COUNT_GAME_SCENE_Y-POSITION_OF_BUTTONS_SELECT_Y)/2));
    
    //Run action
    if (value == 0) {
        if (gameSelected == 1) {
            //Set label text
            _colorLabel.text = @"Yellow";
            //Set font color
            _colorLabel.fontColor = [UIColor colorWithRed:(255/255.0) green:(206/255.0) blue:(119/255.0) alpha:1];
        } else {
            if (colorORtext == 1) {
                [self pickLabel];
                //Set font color
                _colorLabel.fontColor = [UIColor colorWithRed:(255/255.0) green:(206/255.0) blue:(119/255.0) alpha:1];
            } else {
                //Set label text
                _colorLabel.text = @"Yellow";
                [self pickColor];
            }
        }
        
    }
    else if (value == 1) {
        if (gameSelected == 1) {
            //Set label text
            _colorLabel.text = @"Blue";
            //Set font color
            _colorLabel.fontColor = [UIColor colorWithRed:(99/255.0) green:(143/255.0) blue:(192/255.0) alpha:1];
        } else {
            if (colorORtext == 1) {
                [self pickLabel];
                //Set font color
                _colorLabel.fontColor = [UIColor colorWithRed:(99/255.0) green:(143/255.0) blue:(192/255.0) alpha:1];
            } else {
                //Set label text
                _colorLabel.text = @"Blue";
                [self pickColor];
            }
        }
    }
    else if (value == 2) {
        if (gameSelected == 1) {
            //Set label text
            _colorLabel.text = @"Green";
            //Set font color
            _colorLabel.fontColor = [UIColor colorWithRed:(56/255.0) green:(194/255.0) blue:(158/255.0) alpha:1];
        } else {
            if (colorORtext == 1) {
                [self pickLabel];
                //Set font color
                _colorLabel.fontColor = [UIColor colorWithRed:(56/255.0) green:(194/255.0) blue:(158/255.0) alpha:1];
            } else {
                //Set label text
                _colorLabel.text = @"Green";
                [self pickColor];
            }
        }
    }
    else {
        if (gameSelected == 1) {
            //Set label text
            _colorLabel.text = @"Red";
            //Set font color
            _colorLabel.fontColor = [UIColor colorWithRed:(254/255.0) green:(75/255.0) blue:(97/255.0) alpha:1];
        } else {
            if (colorORtext == 1) {
                [self pickLabel];
                //Set font color
                _colorLabel.fontColor = [UIColor colorWithRed:(254/255.0) green:(75/255.0) blue:(97/255.0) alpha:1];
            } else {
                //Set label text
                _colorLabel.text = @"Red";
                [self pickColor];
            }
        }
    }
    
    //Add object to scene
    [self addChild:_colorLabel];
    
    //Unlock button after animation
    unlockButton = [NSTimer scheduledTimerWithTimeInterval:animationSpeedForFollow target:self selector:@selector(removeLabelColor) userInfo:nil repeats:NO];
}

- (void)animateButton:(int)value {
    //Lock button
    //added to remove crash when button press during play screen
    if (!nowPlayPlayer) {
        lockButton = YES;
    } else {
        lockButton = NO;
    }
    //Create action
    SKAction *changeSize;
    SKAction *changeSizeBack;
    //Set different stat for action for different play mode
    if (nowPlayPlayer) {
        changeSize = [SKAction resizeToWidth:SIZE_OF_BUTTON_SELECT_ANIMATION height:SIZE_OF_BUTTON_SELECT_ANIMATION duration:TIME_TO_ANIMATION_BUTTON_PLAYER];
        changeSizeBack = [SKAction resizeToWidth:SIZE_OF_BUTTON_SELECT height:SIZE_OF_BUTTON_SELECT duration:TIME_TO_ANIMATION_BUTTON_PLAYER];
    }
    else {
        changeSize = [SKAction resizeToWidth:SIZE_OF_BUTTON_SELECT_ANIMATION height:SIZE_OF_BUTTON_SELECT_ANIMATION duration:animationSpeedForFollow];
        changeSizeBack = [SKAction resizeToWidth:SIZE_OF_BUTTON_SELECT height:SIZE_OF_BUTTON_SELECT duration:animationSpeedForFollow];
        [sound playButtonClickFollow];
    }
    
    //Run action
    if (value == 0) {
        [_buttonSelect1Back runAction:[SKAction sequence:@[changeSize, changeSizeBack]]];
    }
    else if (value == 1) {
        [_buttonSelect2Back runAction:[SKAction sequence:@[changeSize, changeSizeBack]]];
    }
    else if (value == 2) {
        [_buttonSelect3Back runAction:[SKAction sequence:@[changeSize, changeSizeBack]]];
    }
    else {
        [_buttonSelect4Back runAction:[SKAction sequence:@[changeSize, changeSizeBack]]];
    }
    
    //Unlock button after animation
    unlockButton = [NSTimer scheduledTimerWithTimeInterval:(TIME_TO_ANIMATION_BUTTON_PLAYER) * 2 target:self selector:@selector(unlockButtonAfterAnimations) userInfo:nil repeats:NO];
}

- (void)animationAddScore:(int)value {
    //Fly animation for add score count
    //Set different image and positions
    if (value == 0) {
        _buttonToAnimate = [SKSpriteNode spriteNodeWithImageNamed:@"buttonCircle1"];
        _buttonToAnimate.position = _buttonSelect1.position;
    }
    else if (value == 1) {
        _buttonToAnimate = [SKSpriteNode spriteNodeWithImageNamed:@"buttonCircle2"];
        _buttonToAnimate.position = _buttonSelect2.position;
    }
    else if (value == 2) {
        _buttonToAnimate = [SKSpriteNode spriteNodeWithImageNamed:@"buttonCircle3"];
        _buttonToAnimate.position = _buttonSelect3.position;
    }
    else {
        _buttonToAnimate = [SKSpriteNode spriteNodeWithImageNamed:@"buttonCircle4"];
        _buttonToAnimate.position = _buttonSelect4.position;
    }
    //Set size and zPosition
    _buttonToAnimate.size = _buttonSelect1.size;
    _buttonToAnimate.zPosition = 31;
    //Add node to scene
    [self addChild:_buttonToAnimate];
    
    //Create actions
    SKAction *changeSize = [SKAction resizeToWidth:0 height:0 duration:TIME_TO_ANIMATION_ADD_SCORE];
    SKAction *changePosition = [SKAction moveTo:CGPointMake(_labelScore.position.x, _labelScore.position.y + _labelScore.frame.size.height / 2) duration:TIME_TO_ANIMATION_ADD_SCORE];
    SKAction *actionRemove = [SKAction removeFromParent];
    //Add action to node
    [_buttonToAnimate runAction:[SKAction sequence:@[changeSize, actionRemove]]];
    [_buttonToAnimate runAction:[SKAction sequence:@[changePosition]]];
    
    //Change label text after animation
    changeLabelText = [NSTimer scheduledTimerWithTimeInterval:TIME_TO_ANIMATION_ADD_SCORE target:self selector:@selector(changeScoreTimer) userInfo:nil repeats:NO];
}

#pragma mark Timer

- (void)afterAnimationFrontSide {
    //Set player stat
    if (nowPlayPlayer) {
        nowArrayCountSelect = 0;
        nowPlayPlayer = YES;
        allArrayComplite = NO;
        lockButton = NO;
    }
    //Set following stat
    else {
        nowPlayPlayer = NO;
        nowArrayFollowAnimateObjectCount = 0;
        [self addNewItemToArrayFollow];
        [self animateArrayFollow];
    }
}

- (void)changeScoreTimer {
    //Change label text and play sound
    _labelScore.text = [NSString stringWithFormat:@"%d", score];
    [sound playGetOnePoint];
}

- (void)nextStepAfterTimer {
    [self nextStep];
}

- (void)unlockButtonAfterAnimations {
    //Unlock button
    if (nowPlayPlayer) {
        lockButton = NO;
    }
}

- (void)removeLabelColor {
    [_colorLabel removeFromParent];
}

- (void)startHideAnimationToFrontSide {
    //Create animation to hide frontSide and label
    SKAction *actionAlpha = [SKAction fadeAlphaTo:0 duration:TIME_TO_ANIMATION_FRONT_SIDE];
    SKAction *actionRemove = [SKAction removeFromParent];
    //Add animation to nodes
    [_frontSide runAction:[SKAction sequence:@[actionAlpha, actionRemove]]];
    [_labelFrontSide runAction:[SKAction sequence:@[actionAlpha, actionRemove]]];
    [_labelDesc runAction:[SKAction sequence:@[actionAlpha, actionRemove]]];
}

#pragma mark Target Actions

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        //Select back buttons
        if ([_buttonBack containsPoint:location]) {
            [self changeSceneToMenu];
            [sound playButtonClick];
        }
        
        //Touch select buttons
        if (nowPlayPlayer) {
            if (!lockButton) {
                if (!allArrayComplite) {
                    //Input stat, animation button and play sound
                    
                    if ([_buttonSelect1 containsPoint:location]) {
                        [self input:0];
                        [self animateButton:0];
                        [sound playButtonClickPlayer];
                    }
                    if ([_buttonSelect2 containsPoint:location]) {
                        [self input:1];
                        [self animateButton:1];
                        [sound playButtonClickPlayer];
                    }
                    if ([_buttonSelect3 containsPoint:location]) {
                        [self input:2];
                        [self animateButton:2];
                        [sound playButtonClickPlayer];
                    }
                    if ([_buttonSelect4 containsPoint:location]) {
                        [self input:3];
                        [self animateButton:3];
                        [sound playButtonClickPlayer];
                    }
                }
            }
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

- (void)changeSceneToMenu {
    // Serve RevMob ad
    [self initialiseRevMob:@"549a4ace6aa1a4cd5b621364" testMode:NO];
    [self revmobShowAd];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    // Create and configure the scene.
    SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionRight duration:1];
    SKScene *level = [[CTMenuScene alloc] initWithSize:skView.bounds.size];
    
    [self.view presentScene:level transition:reveal];
}

- (void)changeSceneToEnd {
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    // Create and configure the scene.
    SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionLeft duration:TIME_TO_CHANGE_SCENE];
    SKScene *level = [[CTEndGameScene alloc] initWithSize:skView.bounds.size];
    
    [self.view presentScene:level transition:reveal];
}

@end
