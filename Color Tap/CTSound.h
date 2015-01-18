//
//  CTSound.h
//  Color Tap
//
//  Created by Vladimir Vinnik on 06.09.14.
//  Copyright (c) 2014 Vladimir Vinnik. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface CTSound : NSObject <AVAudioRecorderDelegate, AVAudioPlayerDelegate> {
    SystemSoundID buttonClick;
    SystemSoundID buttonClickPlayer;
    SystemSoundID buttonClickFollow;
    SystemSoundID getOnePoint;
    SystemSoundID highScore;
    SystemSoundID gameOver;
    
    AVAudioPlayer *audioPlayer;
}

- (void)initSound;

- (void)playButtonClick;
- (void)playButtonClickPlayer;
- (void)playButtonClickFollow;
- (void)playGetOnePoint;
//my sounds
- (void)playHighScore;
- (void)playGameOver;

@end
