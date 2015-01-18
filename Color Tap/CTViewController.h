//
//  CTViewController.h
//  Color Tap
//

//  Copyright (c) 2014 Vladimir Vinnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/iAD.h>
#import <Twitter/Twitter.h>
#import <RevMobAds/RevMobAds.h>
#import <GameKit/GameKit.h>

@interface CTViewController : UIViewController <ADBannerViewDelegate,RevMobAdsDelegate,GKGameCenterControllerDelegate> {
    ADBannerView *adView;
    
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
}

@property (assign, readonly) BOOL gameCenterAvailable;
@property (nonatomic,strong)RevMobFullscreen *fullscreen;
@property (nonatomic, strong) NSArray* leaderboards;

//-(void)showRevFullscreen;
-(void)showBanner;
-(void)hidesBanner;

//**********************************************************//
//********************* GAME CENTER ************************//
//**********************************************************//

//Authenticate the Game Center (MUST PUT IT ON YOUR MAIN MENU)
- (void)authenticateLocalUserOnViewController:(UIViewController*)viewController
                            setCallbackObject:(id)obj
                            withPauseSelector:(SEL)selector;
//--------------------------------------------------------------------------------//

@end
