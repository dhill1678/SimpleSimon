//
//  CTSound.m
//  Color Tap
//
//  Created by Vladimir Vinnik on 06.09.14.
//  Copyright (c) 2014 Vladimir Vinnik. All rights reserved.
//

#import "CTSound.h"

@implementation CTSound

- (void)initSound {
    //Init sounds
    NSURL *buttonClickURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"buttonClick" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)buttonClickURL, &buttonClick);
    NSURL *buttonClickPlayerURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"buttonClickPlayer" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)buttonClickPlayerURL, &buttonClickPlayer);
    NSURL *buttonClickFollowURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"buttonClickFollow" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)buttonClickFollowURL, &buttonClickFollow);
    NSURL *getOnePointURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"getOnePoint" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)getOnePointURL, &getOnePoint);
    //my sounds
    NSURL *gameOverURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gameOver" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)gameOverURL, &gameOver);
    NSURL *highScoreURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"highScore" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)highScoreURL, &highScore);
}

//Play methods
- (void)playButtonClick {
    //If buttonClick initial play sound if not initial him and play.
    if (buttonClick) {
        AudioServicesPlaySystemSound(buttonClick);
    }
    else {
        [self initSound];
        [self playButtonClick];
    }
}

- (void)playButtonClickPlayer {
    //If buttonClickPlayer initial play sound if not initial him and play.
    if (buttonClickPlayer) {
        AudioServicesPlaySystemSound(buttonClickPlayer);
    }
    else {
        [self initSound];
        [self playButtonClickPlayer];
    }
}

- (void)playButtonClickFollow {
    //If buttonClickFollow initial play sound if not initial him and play.
    if (buttonClickFollow) {
        AudioServicesPlaySystemSound(buttonClickFollow);
    }
    else {
        [self initSound];
        [self playButtonClickFollow];
    }
}

- (void)playGetOnePoint {
    //If getOnePoint initial play sound if not initial him and play.
    if (getOnePoint) {
        AudioServicesPlaySystemSound(getOnePoint);
    }
    else {
        [self initSound];
        [self playGetOnePoint];
    }
}

- (void)playGameOver {
    //If gameOver initial play sound if not initial him and play.
    if (gameOver) {
        AudioServicesPlaySystemSound(gameOver);
    }
    else {
        [self initSound];
        [self playGameOver];
    }
}

- (void)playHighScore {
    //If highScore initial play sound if not initial him and play.
    if (highScore) {
        AudioServicesPlaySystemSound(highScore);
    }
    else {
        [self initSound];
        [self playHighScore];
    }
}

@end
