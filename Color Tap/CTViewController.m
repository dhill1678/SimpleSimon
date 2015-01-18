//
//  CTViewController.m
//  Color Tap
//
//  Created by Vladimir Vinnik on 05.09.14.
//  Copyright (c) 2014 Vladimir Vinnik. All rights reserved.
//

#import "CTViewController.h"
#import "CTMenuScene.h"
#import <GameKit/GameKit.h>

NSString *kLeaderBoardIdentifier = @"55118338";

@implementation CTViewController

@synthesize gameCenterAvailable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Check first launch
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        // app already launched
    }
    else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // This is the first launch ever
        
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"hardLevel"];
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"Type"];
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"colorText"];
    }

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    //Add view controller as observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"hideAd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"showAd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendTwitter) name:@"sendTwitter" object:nil];
    
    // Create and configure the scene.
    SKScene * scene = [CTMenuScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    //iAd View settings
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    adView.frame = CGRectOffset(adView.frame, 0, 0.0f);
    adView.delegate=self;
    [adView setAlpha:0];
    [self.view addSubview:adView];
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark iAd banner methods

//Handle Notification
- (void)handleNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:@"hideAd"]) {
        [self hidesBanner];
    }
    else if ([notification.name isEqualToString:@"showAd"]) {
        [self showBanner];
    }
}

//Hide iAd banner
-(void)hidesBanner {
    NSLog(@"Hide banner");
    [adView setAlpha:0];
}

//Show iAd banner
-(void)showBanner {
    NSLog(@"Show banner");
    [adView setAlpha:1];
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

#pragma mark Twitter
// handle twitter stuff on game over screen
- (void)sendTwitter {
    //Initial object
    SLComposeViewController *tweetContent;
    tweetContent = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    //Set text of message
    [tweetContent setInitialText:[NSString stringWithFormat:@"Wow, I scored %ld points in Simple Simon!", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"score"]]];
    //See message to send
    [self presentViewController:tweetContent animated:YES completion:nil];
}

#pragma mark GAME CENTER
#pragma mark -
- (id)init {
    if ((self = [super init])) {
        gameCenterAvailable = [self isGameCenterAvailable];
        
        if (gameCenterAvailable) {
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            [nc addObserver:self selector:@selector(authenticationChanged) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
            //_transactionGoing = false;
            //[[SKPaymentQueue defaultQueue]addTransactionObserver:self];
        }
    }
    return self;
}

- (BOOL)isGameCenterAvailable {
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                           options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

#pragma mark Authentication

- (void)authenticationChanged {
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        userAuthenticated = TRUE;
        
        [self loadLeaderBoardInfo];
        //[self loadAchievements];
        
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated.");
        userAuthenticated = FALSE;
    }
}

- (void)authenticateLocalUserOnViewController:(UIViewController*)viewController
                            setCallbackObject:(id)obj
                            withPauseSelector:(SEL)selector
{
    if (!gameCenterAvailable) return;
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    NSLog(@"Authenticating local user...");
    if (localPlayer.authenticated == NO) {
        [localPlayer setAuthenticateHandler:^(UIViewController* authViewController, NSError *error) {
            if (authViewController != nil) {
                if (obj) {
                    [obj performSelector:selector withObject:nil afterDelay:0];
                }
                
                [viewController presentViewController:authViewController animated:YES completion:^ {
                }];
            } else if (error != nil) {
                // process error
            }
        }];
    }
    else {
        NSLog(@"Already authenticated!");
    }
}

- (void)authenticateUserOnViewController {
    if (!gameCenterAvailable) return;
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    id obj = nil;
    SEL selector = nil;
    
    NSLog(@"Authenticating local user...");
    if (localPlayer.authenticated == NO) {
        [localPlayer setAuthenticateHandler:^(UIViewController* authViewController, NSError *error) {
            if (authViewController != nil) {
                if (obj) {
                    [obj performSelector:selector withObject:nil afterDelay:0];
                }
                NSLog(@"Working!");
                
                [self presentViewController:authViewController animated:YES completion:^ {
                }];
            } else if (error != nil) {
                // process error
                NSLog(@"%@",error);
            }
        }];
    }
    else {
        NSLog(@"Already authenticated!");
    }
}

#pragma mark Leaderboards

- (void)loadLeaderBoardInfo
{
    [GKLeaderboard loadLeaderboardsWithCompletionHandler:^(NSArray *leaderboards, NSError *error) {
        self.leaderboards = leaderboards;
    }];
}

- (void)reportScore:(int64_t)score forLeaderboardID:(NSString*)identifier
{
    GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier: identifier];
    scoreReporter.value = score;
    scoreReporter.context = 0;
    
    [GKScore reportScores:@[scoreReporter] withCompletionHandler:^(NSError *error) {
        if (error == nil) {
            NSLog(@"Score reported successfully!");
        } else {
            NSLog(@"Unable to report score!");
        }
    }];
}

- (void)showLeaderboardOnViewController {
    //(void)showLeaderboardOnViewController:(UIViewController*)viewController
    
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil) {
        gameCenterController.gameCenterDelegate = self;
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gameCenterController.leaderboardIdentifier = kLeaderBoardIdentifier;
        
        //[viewController presentViewController: gameCenterController animated: YES completion:nil];
        [self presentViewController: gameCenterController animated: YES completion:nil];
    }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
