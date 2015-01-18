//
//  CTSetting.h
//  Color Tap
//
//  Created by Vladimir Vinnik on 05.09.14.
//  Copyright (c) 2014 Vladimir Vinnik. All rights reserved.
//

#ifndef Color_Tap_CTSetting_h
#define Color_Tap_CTSetting_h

//Color
#define BACKGROUND_COLOR_MENU [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1]

#define FONT_COLOR_DARK [UIColor colorWithRed:(97/255.0) green:(97/255.0) blue:(97/255.0) alpha:1]
#define FONT_COLOR_WHITE [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1]

//Main
#define TIME_TO_CHANGE_SCENE 0.6

//Interface
#define FONT_SIZE 17
#define FONT_SIZE_BIG 30
#define FONT_SIZE_LABEL_SCORE 60
#define FONT_SIZE_END 65

//Menu scene
#define TIME_TO_ANIMATION_CHANGE_LEVEL 0.3
#define TIME_TO_ANIMATION_CHANGE_SCORE 0.7

#define SIZE_OF_LOGO self.size.width / 100 * 85

#define SIZE_OF_HARDEST_BUTTON self.size.width / 100 * 15
#define SIZE_OF_HARDEST_BUTTON_SELECT self.size.width / 100 * 18
#define SIZE_OF_BUTTON_START self.size.width / 100 * 51

#define SIZE_OF_BLOCK_SCORE self.size.width / 100 * 30

#define INTERVAL_OF_HARDEST_BUTTON self.size.width / 100 * 3

//#define POSITION_OF_HARDEST_BUTTONS_Y self.frame.size.height / 100 * 60
#define POSITION_OF_HARDEST_BUTTONS_Y self.frame.size.height / 100 * 65
//#define POSITION_OF_START_BUTTON_Y self.frame.size.height / 100 * 45
#define POSITION_OF_START_BUTTON_Y self.frame.size.height / 100 * 20
#define POSITION_OF_LOGO_Y self.frame.size.height / 100 * 85
#define POSITION_OF_LABEL_SCORE_COUNT_Y self.frame.size.height / 100 * 12
#define POSITION_OF_LABEL_SCORE_Y self.frame.size.height / 100 * 8

//Game scene
#define TIME_TO_ANIMATION_FRONT_SIDE 0.6
#define TIME_TO_DELAY_FRONT_SIDE 0.5
#define TIME_TO_ANIMATION_BUTTON_PLAYER 0.3
#define TIME_TO_ANIMATION_BUTTON_LEVEL_1 0.8
//#define TIME_TO_ANIMATION_BUTTON_LEVEL_2 0.3
#define TIME_TO_ANIMATION_BUTTON_LEVEL_2 0.4
#define TIME_TO_ANIMATION_BUTTON_LEVEL_3 0.1
//#define TIME_TO_ANIMATION_ARRAY_FOLLOW 0.5
#define TIME_TO_ANIMATION_ARRAY_FOLLOW_1 0.8
#define TIME_TO_ANIMATION_ARRAY_FOLLOW_2 0.4
#define TIME_TO_ANIMATION_ARRAY_FOLLOW_3 0.1
#define TIME_TO_ANIMATION_ADD_SCORE 0.6

#define SIZE_OF_BUTTON_BACK_GAME_SCENE self.size.width / 100 * 45
#define SIZE_OF_BUTTON_SELECT self.size.width / 100 * 32
#define SIZE_OF_BUTTON_SELECT_ANIMATION self.size.width / 100 * 40

#define INTERVAL_OF_BUTTON_SELECT self.size.width / 100 * 5

//#define POSITION_OF_BUTTONS_SELECT_Y self.frame.size.height / 100 * 50
#define POSITION_OF_BUTTONS_SELECT_Y self.frame.size.height / 100 * 40
#define POSITION_OF_LABEL_SCORE_COUNT_GAME_SCENE_Y self.frame.size.height / 100 * 75

//End scene
#define SIZE_OF_BUTTON_END_SCENE self.size.width / 100 * 20
#define INTERVAL_OF_BUTTON_END_SCENE self.size.width / 100 * 5

#define POSITION_OF_BUTTONS_END_SCENE_Y self.frame.size.height / 100 * 45

#define POSITION_OF_LABEL_SCORE_END_SCENE_Y self.frame.size.height / 100 * 77
#define POSITION_OF_LABEL_SCORE_COUN_END_SCENE_Y self.frame.size.height / 100 * 65

#endif
