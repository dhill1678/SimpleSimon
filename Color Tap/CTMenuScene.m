//
//  CTMenuScene.m
//  Color Tap
//
//  Created by Vladimir Vinnik on 05.09.14.
//  Copyright (c) 2014 Vladimir Vinnik. All rights reserved.
//
// Modified by David Hill

#import "CTMenuScene.h"
#import "CTViewController.h"
#import <GameKit/GameKit.h>

@implementation CTMenuScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //Send message to CTViewController to hide iAd.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideAd" object:nil];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"showAd" object:nil];
        
        //Initial sound class
        sound = [[CTSound alloc] init];
        [sound initSound];
        
        //Get settings
        hardestLevel = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"hardLevel"];
        gameType = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"Type"];
        colorOR = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"colorText"];
        
        /*
        if (hardestLevel < 1) {
            hardestLevel = 1;
        }
        if (gameType < 1) {
            gameType = 1;
        }
        if (colorOR < 1) {
            colorOR = 1;
        }
         */
        
        /*
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
            if (error == nil) {
                NSLog(@"Authentication Successful");
            } else {
                NSLog(@"Authentication Failed");
            }
        }];
         */
        // Game Center
        [[NSNotificationCenter defaultCenter] postNotificationName:@"authenticateUserOnViewController" object:nil];
        
        //Initial nodes
        [self setBackground];
        [self setButtonsHardestGame];
        [self setButtonsHardest];
        [self setButtonHardestGameSelect];
        [self setButtonHardestGameSelect2];
        [self setButtonHardestGameSelect3];
        [self setButtonStart];
        [self setLogo];
        //[self setLabels]; // best score animation removed
    }
    return self;
}

#pragma mark Node

// set background image - should be good to go
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
- (void)setButtonStart {
    //Set object image size and position.
    _buttonStart = [SKSpriteNode spriteNodeWithImageNamed:@"buttonStart"];
    _buttonStart.size = CGSizeMake(SIZE_OF_BUTTON_START, SIZE_OF_BUTTON_START / 3.7);
    _buttonStart.position = CGPointMake(self.frame.size.width / 2, POSITION_OF_START_BUTTON_Y); // y position altered to lower button
    if (self.frame.size.height < 1136) {
        _buttonStart.position = CGPointMake(self.frame.size.width / 2, POSITION_OF_START_BUTTON_Y - 20); // y position altered to lower button
    }
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        _buttonStart.size = CGSizeMake(SIZE_OF_BUTTON_START, SIZE_OF_BUTTON_START / 4.3);
        _buttonStart.position = CGPointMake(self.frame.size.width / 2, POSITION_OF_START_BUTTON_Y - 80); // y position altered to lower button
    }
    _buttonStart.zPosition = 40;
    //Add object to scene
    [self addChild:_buttonStart];
}

- (void)setButtonsHardestGame {
    //Get start poit to lacated buttons
    CGPoint locationButtons = CGPointMake(self.frame.size.width / 2 - (SIZE_OF_HARDEST_BUTTON + INTERVAL_OF_HARDEST_BUTTON), POSITION_OF_HARDEST_BUTTONS_Y - SIZE_OF_HARDEST_BUTTON * 2);
    //Set first hardest level button image, size and position
    _buttonHardestGame1 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardestGame1"];
    _buttonHardestGame1.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON, SIZE_OF_HARDEST_BUTTON);
    _buttonHardestGame1.position = locationButtons;
    _buttonHardestGame1.zPosition = 30;
    //Add node to scene
    [self addChild:_buttonHardestGame1];
    
    //Change x position location buttons
    //locationButtons.x += SIZE_OF_HARDEST_BUTTON + INTERVAL_OF_HARDEST_BUTTON;
    locationButtons.x = self.frame.size.width / 2;
    
    //Set two hardest level button image, size and position
    _buttonHardestGame2 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardestGame2"];
    _buttonHardestGame2.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON, SIZE_OF_HARDEST_BUTTON);
    _buttonHardestGame2.position = locationButtons;
    _buttonHardestGame2.zPosition = 30;
    //Add node to scene
    [self addChild:_buttonHardestGame2];
    
    //Change x position location buttons
    locationButtons.x += SIZE_OF_HARDEST_BUTTON + INTERVAL_OF_HARDEST_BUTTON;
    
    //Set three hardest level button image, size and position
    _buttonHardestGame3 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardestGame3"];
    _buttonHardestGame3.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON, SIZE_OF_HARDEST_BUTTON);
    _buttonHardestGame3.position = locationButtons;
    _buttonHardestGame3.zPosition = 30;
    //Add node to scene
    [self addChild:_buttonHardestGame3];
    
    // for second row
    //Get start poit to lacated buttons
    CGPoint locationButtons2 = CGPointMake(self.frame.size.width / 2 - (SIZE_OF_HARDEST_BUTTON + INTERVAL_OF_HARDEST_BUTTON), POSITION_OF_HARDEST_BUTTONS_Y); // edited with - SIZE_OF_HARDEST_BUTTON_SELECT
    if (self.frame.size.height < 1136) {
        locationButtons2 = CGPointMake(self.frame.size.width / 2 - (SIZE_OF_HARDEST_BUTTON + INTERVAL_OF_HARDEST_BUTTON), POSITION_OF_HARDEST_BUTTONS_Y - 10); // edited with - SIZE_OF_HARDEST_BUTTON_SELECT
    }
    //Set first hardest level button image, size and position
    _buttonHardestGame4 = [SKSpriteNode spriteNodeWithImageNamed:@"simonSaysBlack"];
    _buttonHardestGame4.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON * 2, SIZE_OF_HARDEST_BUTTON * 2);
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        _buttonHardestGame4.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON * 1.95, SIZE_OF_HARDEST_BUTTON * 1.95);
        locationButtons2 = CGPointMake(self.frame.size.width / 2 - (SIZE_OF_HARDEST_BUTTON + INTERVAL_OF_HARDEST_BUTTON), POSITION_OF_HARDEST_BUTTONS_Y - 40); // edited with - SIZE_OF_HARDEST_BUTTON_SELECT
    }
    _buttonHardestGame4.position = locationButtons2;
    _buttonHardestGame4.zPosition = 30;
    //Add node to scene
    [self addChild:_buttonHardestGame4];
    
    //Change x position location buttons
    //locationButtons2.x += SIZE_OF_HARDEST_BUTTON * 2 + INTERVAL_OF_HARDEST_BUTTON;
    locationButtons2.x = self.frame.size.width / 2 + (SIZE_OF_HARDEST_BUTTON + INTERVAL_OF_HARDEST_BUTTON);
    
    //Set two hardest level button image, size and position
    _buttonHardestGame5 = [SKSpriteNode spriteNodeWithImageNamed:@"brainTeaserBlack"];
    _buttonHardestGame5.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON * 1.96, SIZE_OF_HARDEST_BUTTON * 1.98);
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        _buttonHardestGame5.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON * 1.91, SIZE_OF_HARDEST_BUTTON * 1.93);
    }
    _buttonHardestGame5.position = locationButtons2;
    _buttonHardestGame5.zPosition = 30;
    //Add node to scene
    [self addChild:_buttonHardestGame5];
    
    // for third row
    //Get start poit to lacated buttons
    CGPoint locationButtons3 = CGPointMake(self.frame.size.width / 2 - (SIZE_OF_HARDEST_BUTTON + INTERVAL_OF_HARDEST_BUTTON) / 2, locationButtons.y - SIZE_OF_HARDEST_BUTTON_SELECT - INTERVAL_OF_HARDEST_BUTTON); // edited with - SIZE_OF_HARDEST_BUTTON_SELECT
    //Set first hardest level button image, size and position
    _buttonHardestGame6 = [SKSpriteNode spriteNodeWithImageNamed:@"colorCircleBlue"];
    _buttonHardestGame6.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON, SIZE_OF_HARDEST_BUTTON);
    _buttonHardestGame6.position = locationButtons3;
    _buttonHardestGame6.zPosition = 30;
    //Add node to scene
    [self addChild:_buttonHardestGame6];
    
    //Change x position location buttons
    //locationButtons3.x += SIZE_OF_HARDEST_BUTTON + INTERVAL_OF_HARDEST_BUTTON;
    locationButtons3.x = self.frame.size.width / 2 + (SIZE_OF_HARDEST_BUTTON + INTERVAL_OF_HARDEST_BUTTON) / 2;
    
    //Set two hardest level button image, size and position
    _buttonHardestGame7 = [SKSpriteNode spriteNodeWithImageNamed:@"textCircleBlue"];
    _buttonHardestGame7.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON, SIZE_OF_HARDEST_BUTTON);
    _buttonHardestGame7.position = locationButtons3;
    _buttonHardestGame7.zPosition = 30;
    //Add node to scene
    [self addChild:_buttonHardestGame7];
}

- (void)setButtonsHardest {
    //Set one hardest level button image, size and position
    _buttonHardest1 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardest1"];
    _buttonHardest1.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON, SIZE_OF_HARDEST_BUTTON);
    _buttonHardest1.position = _buttonHardestGame1.position;
    _buttonHardest1.zPosition = 35;
    //Add node to scene
    [self addChild:_buttonHardest1];
    
    //Set two hardest level button image, size and position
    _buttonHardest2 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardest2"];
    _buttonHardest2.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON, SIZE_OF_HARDEST_BUTTON);
    _buttonHardest2.position = _buttonHardestGame2.position;
    _buttonHardest2.zPosition = 35;
    //Add node to scene
    [self addChild:_buttonHardest2];
    
    //Set three hardest level button image, size and position
    _buttonHardest3 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardest3"];
    _buttonHardest3.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON, SIZE_OF_HARDEST_BUTTON);
    _buttonHardest3.position = _buttonHardestGame3.position;
    _buttonHardest3.zPosition = 35;
    //Add node to scene
    [self addChild:_buttonHardest3];
    
    // for second row
    //Set one hardest level button image, size and position
    _buttonHardest4 = [SKSpriteNode spriteNodeWithImageNamed:@"simonSaysWhite"];
    _buttonHardest4.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON * 2, SIZE_OF_HARDEST_BUTTON * 2);
    _buttonHardest4.position = _buttonHardestGame4.position;
    _buttonHardest4.zPosition = 35;
    //Add node to scene
    [self addChild:_buttonHardest4];
    
    //Set two hardest level button image, size and position
    _buttonHardest5 = [SKSpriteNode spriteNodeWithImageNamed:@"brainTeaserWhite"];
    _buttonHardest5.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON * 1.96, SIZE_OF_HARDEST_BUTTON * 1.98);
    _buttonHardest5.position = _buttonHardestGame5.position;
    _buttonHardest5.zPosition = 35;
    //Add node to scene
    [self addChild:_buttonHardest5];
    
    // for third row
    //Set three hardest level button image, size and position
    _buttonHardest6 = [SKSpriteNode spriteNodeWithImageNamed:@"colorCircleGray"];
    _buttonHardest6.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON, SIZE_OF_HARDEST_BUTTON);
    _buttonHardest6.position = _buttonHardestGame6.position;
    _buttonHardest6.zPosition = 35;
    //Add node to scene
    [self addChild:_buttonHardest6];
    
    //Set three hardest level button image, size and position
    _buttonHardest7 = [SKSpriteNode spriteNodeWithImageNamed:@"textCircleGray"];
    _buttonHardest7.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON, SIZE_OF_HARDEST_BUTTON);
    _buttonHardest7.position = _buttonHardestGame7.position;
    _buttonHardest7.zPosition = 35;
    //Add node to scene
    [self addChild:_buttonHardest7];
}

- (void)setButtonHardestGameSelect {
    //Set object image size and position.
    //Set position to selected hard
    if (hardestLevel == 1) {
        _buttonHardestGameSelect = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardersSelectBack1"];
        _buttonHardestGameSelect.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT, SIZE_OF_HARDEST_BUTTON_SELECT);
        _buttonHardestGameSelect.position = _buttonHardestGame1.position;
        _buttonHardest1.alpha = 0;
    }
    else if (hardestLevel == 2) {
        _buttonHardestGameSelect = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardersSelectBack2"];
        _buttonHardestGameSelect.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT, SIZE_OF_HARDEST_BUTTON_SELECT);
        _buttonHardestGameSelect.position = _buttonHardestGame2.position;
        _buttonHardest2.alpha = 0;
    }
    else {
        _buttonHardestGameSelect = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardersSelectBack3"];
        _buttonHardestGameSelect.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT, SIZE_OF_HARDEST_BUTTON_SELECT);
        _buttonHardestGameSelect.position = _buttonHardestGame3.position;
        _buttonHardest3.alpha = 0;
    }
    _buttonHardestGameSelect.zPosition = 28;
    //Add node to scene
    [self addChild:_buttonHardestGameSelect];
}

- (void)setButtonHardestGameSelect2 {
    // for second row
    //Set object image size and position.
    //Set position to selected hard
    if (gameType == 1) {
        //_buttonHardestGameSelect2 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardersSelectBack1"];
        //_buttonHardestGameSelect2.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT, SIZE_OF_HARDEST_BUTTON_SELECT);
        //_buttonHardestGameSelect2.position = _buttonHardestGame4.position;
        _buttonHardest4.alpha = 0;
    }
    else {
        //_buttonHardestGameSelect2 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardersSelectBack2"];
        //_buttonHardestGameSelect2.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT, SIZE_OF_HARDEST_BUTTON_SELECT);
        //_buttonHardestGameSelect2.position = _buttonHardestGame5.position;
        _buttonHardest5.alpha = 0;
    }

    //_buttonHardestGameSelect2.zPosition = 26;
    //Add node to scene
    //[self addChild:_buttonHardestGameSelect2];
}

- (void)setButtonHardestGameSelect3 {
    // for third row
    //Set object image size and position.
    //Set position to selected hard
    if (colorOR == 1) {
        _buttonHardestGameSelect3 = [SKSpriteNode spriteNodeWithImageNamed:@"blueSelectCircle"];
        _buttonHardestGameSelect3.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT, SIZE_OF_HARDEST_BUTTON_SELECT);
        _buttonHardestGameSelect3.position = _buttonHardestGame6.position;
        _buttonHardest6.alpha = 0;
    }
    else {
        _buttonHardestGameSelect3 = [SKSpriteNode spriteNodeWithImageNamed:@"blueSelectCircle"];
        _buttonHardestGameSelect3.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT, SIZE_OF_HARDEST_BUTTON_SELECT);
        _buttonHardestGameSelect3.position = _buttonHardestGame7.position;
        _buttonHardest7.alpha = 0;
    }
    
    _buttonHardestGameSelect3.zPosition = 27;
    //Add node to scene
    [self addChild:_buttonHardestGameSelect3];
}

- (void)setButtonHardestGameNewWithColor:(int)changeColor {
    //Set object image size and position.
    if (changeColor == 1) {
        _buttonHardestGameNew = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardersSelectBack1"];
        _buttonHardestGameNew.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT, SIZE_OF_HARDEST_BUTTON_SELECT);
        _buttonHardestGameNew.position = _buttonHardestGame1.position;
        _buttonHardestGameNew.zPosition = 29;
        _buttonHardestGameNew.alpha = 0;
        //Add node to scene
        [self addChild:_buttonHardestGameNew];
    } else if (changeColor == 2) {
        _buttonHardestGameNew = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardersSelectBack2"];
        _buttonHardestGameNew.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT, SIZE_OF_HARDEST_BUTTON_SELECT);
        _buttonHardestGameNew.position = _buttonHardestGame2.position;
        _buttonHardestGameNew.zPosition = 29;
        _buttonHardestGameNew.alpha = 0;
        //Add node to scene
        [self addChild:_buttonHardestGameNew];
    } else if (changeColor == 3) {
        _buttonHardestGameNew = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardersSelectBack3"];
        _buttonHardestGameNew.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT, SIZE_OF_HARDEST_BUTTON_SELECT);
        _buttonHardestGameNew.position = _buttonHardestGame3.position;
        _buttonHardestGameNew.zPosition = 29;
        _buttonHardestGameNew.alpha = 0;
        //Add node to scene
        [self addChild:_buttonHardestGameNew];
    } else if (changeColor == 4) {
        /*
        _buttonHardestGameNew2 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardersSelectBack1"]; //change image
        _buttonHardestGameNew2.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT * 2, SIZE_OF_HARDEST_BUTTON_SELECT * 2);
        _buttonHardestGameNew2.position = _buttonHardestGame4.position;
        _buttonHardestGameNew2.zPosition = 29;
        _buttonHardestGameNew2.alpha = 0;
        //Add node to scene
        [self addChild:_buttonHardestGameNew2];
         */
    } else if (changeColor == 5) {
        /*
        _buttonHardestGameNew2 = [SKSpriteNode spriteNodeWithImageNamed:@"buttonHardersSelectBack2"]; //change image
        _buttonHardestGameNew2.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT * 2, SIZE_OF_HARDEST_BUTTON_SELECT * 2);
        _buttonHardestGameNew2.position = _buttonHardestGame5.position;
        _buttonHardestGameNew2.zPosition = 29;
        _buttonHardestGameNew2.alpha = 0;
        //Add node to scene
        [self addChild:_buttonHardestGameNew2];
         */
    } else if (changeColor == 6)  {
        _buttonHardestGameNew3 = [SKSpriteNode spriteNodeWithImageNamed:@"blueSelectCircle"];
        _buttonHardestGameNew3.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT, SIZE_OF_HARDEST_BUTTON_SELECT);
        _buttonHardestGameNew3.position = _buttonHardestGame6.position;
        _buttonHardestGameNew3.zPosition = 29;
        _buttonHardestGameNew3.alpha = 0;
        //Add node to scene
        [self addChild:_buttonHardestGameNew3];
    } else if (changeColor == 7)  {
        _buttonHardestGameNew3 = [SKSpriteNode spriteNodeWithImageNamed:@"blueSelectCircle"];
        _buttonHardestGameNew3.size = CGSizeMake(SIZE_OF_HARDEST_BUTTON_SELECT, SIZE_OF_HARDEST_BUTTON_SELECT);
        _buttonHardestGameNew3.position = _buttonHardestGame7.position;
        _buttonHardestGameNew3.zPosition = 29;
        _buttonHardestGameNew3.alpha = 0;
        //Add node to scene
        [self addChild:_buttonHardestGameNew3];
    }
}

- (void)setLogo {
    //Set object image size and position.
    _logo = [SKSpriteNode spriteNodeWithImageNamed:@"logo"];
    _logo.size = CGSizeMake(SIZE_OF_LOGO, SIZE_OF_LOGO / 2.7);
    _logo.position = CGPointMake(self.frame.size.width / 2, POSITION_OF_LOGO_Y);
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        _logo.size = CGSizeMake(SIZE_OF_LOGO, SIZE_OF_LOGO / 3.2);
    }
    _logo.zPosition = 45;
    //Add object to scene
    [self addChild:_logo];
}

- (void)setLabels {
    //Set font type
    _labelBestScoreCount = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _labelBestScore.fontSize = FONT_SIZE_BIG * 2;
    }
    else {
        _labelBestScoreCount.fontSize = FONT_SIZE_BIG;
    }
    //Set font color
    _labelBestScoreCount.fontColor = FONT_COLOR_DARK;
    //Set object positions
    _labelBestScoreCount.zPosition = 30;
    _labelBestScoreCount.position = CGPointMake(self.frame.size.width / 2, POSITION_OF_LABEL_SCORE_COUNT_Y);
    //Set label text
    if (hardestLevel == 1) {
        _labelBestScoreCount.text = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel1"]];
    }
    else if (hardestLevel == 2) {
        _labelBestScoreCount.text = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel2"]];
    }
    else {
        _labelBestScoreCount.text = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel3"]];
    }
    //Add object to scene
    [self addChild:_labelBestScoreCount];
    
    //Set font type
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
    //Set object positions
    _labelBestScore.zPosition = 30;
    _labelBestScore.position = CGPointMake(self.frame.size.width / 2, POSITION_OF_LABEL_SCORE_Y);
    //Set label text
    _labelBestScore.text = [NSString stringWithFormat:@"Best score"];
    //Add object to scene
    [self addChild:_labelBestScore];
    
    //Set object image size and position.
    _blockScore = [SKSpriteNode spriteNodeWithImageNamed:@"blockScore"];
    _blockScore.size = CGSizeMake(SIZE_OF_BLOCK_SCORE, SIZE_OF_BLOCK_SCORE);
    _blockScore.position = CGPointMake(self.frame.size.width / 2, POSITION_OF_LABEL_SCORE_COUNT_Y);
    _blockScore.zPosition = 29;
    //Add object to scene
    [self addChild:_blockScore];
}

#pragma mark Programm

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //Get location
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        //If touch _buttonStart
        if ([_buttonStart containsPoint:location]){
            [[NSUserDefaults standardUserDefaults] setInteger:hardestLevel forKey:@"hardLevel"];
            [[NSUserDefaults standardUserDefaults] setInteger:gameType forKey:@"Type"];        // for new buttons
            [[NSUserDefaults standardUserDefaults] setInteger:colorOR forKey:@"colorText"];    // for new buttons
            
            //Change scene
            [self changeSceneToGame];
            
            [sound playButtonClick];
        }
        
        //Change hardest level
        if ([_buttonHardestGame1 containsPoint:location]){
            [self changeButtonSelectPosition:1];
            [sound playButtonClick];
        }
        if ([_buttonHardestGame2 containsPoint:location]){
            [self changeButtonSelectPosition:2];
            [sound playButtonClick];
        }
        if ([_buttonHardestGame3 containsPoint:location]){
            [self changeButtonSelectPosition:3];
            [sound playButtonClick];
        }
        //Change game type
        if ([_buttonHardestGame4 containsPoint:location]){
            [self changeButtonSelectPosition:4];
            [sound playButtonClick];
        }
        if ([_buttonHardestGame5 containsPoint:location]){
            [self changeButtonSelectPosition:5];
            [sound playButtonClick];
        }
        //Change between color or text
        if ([_buttonHardestGame6 containsPoint:location]){
            [self changeButtonSelectPosition:6];
            [sound playButtonClick];
        }
        if ([_buttonHardestGame7 containsPoint:location]){
            [self changeButtonSelectPosition:7];
            [sound playButtonClick];
        }
    }
}

- (void)changeButtonSelectPosition:(int)value {
    [self setButtonHardestGameNewWithColor:value];
    
    if (value <= 3) {
        //Hide old level and show new
        oldHardLevel = hardestLevel;
        newHardLevel = value;
        [self changeButtonHardestTopAlpha];
        
        //Set button to new hardes level
        hardestLevel = value;
        NSLog(@"%i",hardestLevel);
    } else if (value >= 6) {
        //Hide old level and show new
        oldHardLevel = colorOR + 5;
        newHardLevel = value;
        [self changeButtonHardestTopAlpha];
        
        //Set button to new hardes level
        colorOR = value - 5;
        NSLog(@"%i",colorOR);
    } else {
        //Hide old level and show new
        oldHardLevel = gameType + 3;
        newHardLevel = value;
        [self changeButtonHardestTopAlpha];

        //Set button to new hardes level
        gameType = value - 3;
        NSLog(@"%i",gameType);
    }
    
    /*
    //Change label
    if (newHardLevel != oldHardLevel) {
        if (!nowAnimateLabel) {
            [self animateBlockWithLabelMove];
        }
        else {
            [_blockScore removeAllActions];
            [_labelBestScore removeAllActions];
            [_labelBestScoreCount removeAllActions];
            [self moveBlockBack];
        }
    }
     */
    
    CGPoint newPosition;
    
    if (value <= 3) {
        if (hardestLevel == 1) {
            newPosition = _buttonHardestGame1.position;
        }
        else if (hardestLevel == 2) {
            newPosition = _buttonHardestGame2.position;
        }
        else {
            newPosition = _buttonHardestGame3.position;
        }
        //Animate this
        SKAction *actionMoveTo = [SKAction moveTo:newPosition duration:TIME_TO_ANIMATION_CHANGE_LEVEL];
        SKAction *changeAlpha = [SKAction fadeInWithDuration:TIME_TO_ANIMATION_CHANGE_LEVEL];
        SKAction *removeAfter = [SKAction removeFromParent];
        [_buttonHardestGameSelect runAction:[SKAction sequence:@[actionMoveTo]]];
        [_buttonHardestGameNew runAction:[SKAction sequence:@[actionMoveTo, removeAfter]]];
        [_buttonHardestGameNew runAction:[SKAction sequence:@[changeAlpha]]];
        
        timerForChangeColorButtonHardesGameSelect = [NSTimer scheduledTimerWithTimeInterval:TIME_TO_ANIMATION_CHANGE_LEVEL target:self selector:@selector(changeColorOfButtonHardestSelect) userInfo:nil repeats:NO];
    } else if (value >= 6) {
        if (colorOR == 1) {
            newPosition = _buttonHardestGame6.position;
        } else {
            newPosition = _buttonHardestGame7.position;
        }
        //Animate this
        SKAction *actionMoveTo = [SKAction moveTo:newPosition duration:TIME_TO_ANIMATION_CHANGE_LEVEL];
        SKAction *changeAlpha = [SKAction fadeInWithDuration:TIME_TO_ANIMATION_CHANGE_LEVEL];
        SKAction *removeAfter = [SKAction removeFromParent];
        [_buttonHardestGameSelect3 runAction:[SKAction sequence:@[actionMoveTo]]];
        [_buttonHardestGameNew3 runAction:[SKAction sequence:@[actionMoveTo, removeAfter]]];
        [_buttonHardestGameNew3 runAction:[SKAction sequence:@[changeAlpha]]];
        
        timerForChangeColorButtonHardesGameSelect = [NSTimer scheduledTimerWithTimeInterval:TIME_TO_ANIMATION_CHANGE_LEVEL target:self selector:@selector(changeColorOfButtonHardestSelect3) userInfo:nil repeats:NO];
    } else {
        timerForChangeColorButtonHardesGameSelect = [NSTimer scheduledTimerWithTimeInterval:TIME_TO_ANIMATION_CHANGE_LEVEL target:self selector:@selector(changeColorOfButtonHardestSelect2) userInfo:nil repeats:NO];
    }
}

- (void)changeColorOfButtonHardestSelect {
    [_buttonHardestGameSelect removeFromParent];
    [self setButtonHardestGameSelect];
}

- (void)changeColorOfButtonHardestSelect2 {
    [_buttonHardestGameSelect2 removeFromParent];
    [self setButtonHardestGameSelect2];
}

- (void)changeColorOfButtonHardestSelect3 {
    [_buttonHardestGameSelect3 removeFromParent];
    [self setButtonHardestGameSelect3];
}

- (void)changeButtonHardestTopAlpha {
    //Make animation
    SKAction *fadeIn = [SKAction fadeInWithDuration:TIME_TO_ANIMATION_CHANGE_LEVEL];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:TIME_TO_ANIMATION_CHANGE_LEVEL / 2];
    
    if (oldHardLevel != newHardLevel) {
        //Hide old level
        if (oldHardLevel == 1) {
            [_buttonHardest1 runAction:[SKAction sequence:@[fadeIn]]];
        }
        else if (oldHardLevel == 2) {
            [_buttonHardest2 runAction:[SKAction sequence:@[fadeIn]]];
        }
        else if (oldHardLevel == 3) {
            [_buttonHardest3 runAction:[SKAction sequence:@[fadeIn]]];
        }
        else if (oldHardLevel == 4) {
            [_buttonHardest4 runAction:[SKAction sequence:@[fadeIn]]];
        }
        else if (oldHardLevel == 5) {
            [_buttonHardest5 runAction:[SKAction sequence:@[fadeIn]]];
        }
        else if (oldHardLevel == 6) {
            [_buttonHardest6 runAction:[SKAction sequence:@[fadeIn]]];
        }
        else {
            [_buttonHardest7 runAction:[SKAction sequence:@[fadeIn]]];
        }
    }
    
    //Show new level
    if (newHardLevel == 1) {
        [_buttonHardest1 runAction:[SKAction sequence:@[fadeOut]]];
    }
    else if (newHardLevel == 2) {
        [_buttonHardest2 runAction:[SKAction sequence:@[fadeOut]]];
    }
    else if (newHardLevel == 3) {
        [_buttonHardest3 runAction:[SKAction sequence:@[fadeOut]]];
    }
    else if (newHardLevel == 4) {
        [_buttonHardest4 runAction:[SKAction sequence:@[fadeOut]]];
    }
    else if (newHardLevel == 5) {
        [_buttonHardest5 runAction:[SKAction sequence:@[fadeOut]]];
    }
    else if (newHardLevel == 6) {
        [_buttonHardest6 runAction:[SKAction sequence:@[fadeOut]]];
    }
    else {
        [_buttonHardest7 runAction:[SKAction sequence:@[fadeOut]]];
    }
}

// slide in high scores for each difficulty level
- (void)animateBlockWithLabelMove {
    nowAnimateLabel = YES;
    //Create actions
    SKAction *moveBlock = [SKAction moveTo:CGPointMake(_blockScore.position.x + self.frame.size.width, _blockScore.position.y) duration:TIME_TO_ANIMATION_CHANGE_SCORE];
    SKAction *moveBlockForLabel = [SKAction moveTo:CGPointMake(_blockScore.position.x + self.frame.size.width, _labelBestScore.position.y) duration:TIME_TO_ANIMATION_CHANGE_SCORE];
    //Add actions to node
    [_blockScore runAction:[SKAction sequence:@[moveBlock]]];
    [_labelBestScoreCount runAction:[SKAction sequence:@[moveBlock]]];
    [_labelBestScore runAction:[SKAction sequence:@[moveBlockForLabel]]];
    
    //Change text and move back
    timeToGoBlockBack = [NSTimer scheduledTimerWithTimeInterval:TIME_TO_ANIMATION_CHANGE_SCORE target:self selector:@selector(moveBlockBack) userInfo:nil repeats:NO];
}

// slide out high scores for each difficulty level
- (void)moveBlockBack {
    nowAnimateLabel = YES;
    //Change label text
    [self changeLabelScoreText];
    
    //Create actions
    SKAction *moveBlockToStartPositions = [SKAction moveTo:CGPointMake(0 - _blockScore.size.width, _blockScore.position.y) duration:0];
    SKAction *moveBlockToStartPositionsForLabel = [SKAction moveTo:CGPointMake(0 - _blockScore.size.width, _labelBestScore.position.y) duration:0];
    SKAction *moveBlock = [SKAction moveTo:CGPointMake(self.frame.size.width / 2, _blockScore.position.y) duration:TIME_TO_ANIMATION_CHANGE_SCORE];
    SKAction *moveBlockForLabel = [SKAction moveTo:CGPointMake(self.frame.size.width / 2, _labelBestScore.position.y) duration:TIME_TO_ANIMATION_CHANGE_SCORE];
    //Add actions to node
    [_blockScore runAction:[SKAction sequence:@[moveBlockToStartPositions, moveBlock]]];
    [_labelBestScoreCount runAction:[SKAction sequence:@[moveBlockToStartPositions, moveBlock]]];
    [_labelBestScore runAction:[SKAction sequence:@[moveBlockToStartPositionsForLabel, moveBlockForLabel]]];
    
    //Change boolean value to NO
    animateLabelEnd = [NSTimer scheduledTimerWithTimeInterval:TIME_TO_ANIMATION_CHANGE_SCORE target:self selector:@selector(animateLabelAndBlockEnd) userInfo:nil repeats:NO];
}

- (void)animateLabelAndBlockEnd {
    nowAnimateLabel = NO;
}

// load saved high scores for each difficulty level
- (void)changeLabelScoreText {
    //Set label text
    if (hardestLevel == 1) {
        _labelBestScoreCount.text = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel1"]];
    }
    else if (hardestLevel == 2) {
        _labelBestScoreCount.text = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel2"]];
    }
    else {
        _labelBestScoreCount.text = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"bestScoreHardestLevel3"]];
    }
}

#pragma mark Change Scene

- (void)changeSceneToGame {
        // Configure the view.
        SKView * skView = (SKView *)self.view;
        // Create and configure the scene.
        SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionLeft duration:TIME_TO_CHANGE_SCENE];
        SKScene *level = [[CTGameScene alloc] initWithSize:skView.bounds.size];
        
        [self.view presentScene:level transition:reveal];
}

@end
