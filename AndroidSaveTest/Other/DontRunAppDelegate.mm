//
//  DontRunAppDelegate.m
//  cocos2d Test
//
//  Created by Ghislain Bernier on 2/7/11.
//  Copyright XperimentalZ Games Inc 2011. All rights reserved.
//

#import "cocos2d.h"
#import "DontRunAppDelegate.h"
#import "SceneMainMenu.h"

@implementation DontRunAppDelegate

@synthesize window=window_, viewController=navController_, director=director_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    srand(time(0));
    
#ifdef APPORTABLE    
    [UIScreen mainScreen].currentMode = [UIScreenMode emulatedMode:UIScreenBestEmulatedMode];
#endif
    
    CGRect winBounds = [[UIScreen mainScreen] bounds];
    
//    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)){
//        size = CGSizeMake(size.height, size.width);
//    }
//
//    CGRect winBounds = CGRectMake(0, 0, size.width, size.height);
//    
//    if(bounds.size.height > bounds.size.width){
//        //Force landscape
//        winBounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width);
//    }
//    else
//        winBounds = bounds;
    
    window_ = [[UIWindow alloc] initWithFrame:winBounds];
        
    // Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];
    
	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
    
	director_.wantsFullScreenLayout = YES;
    
	// set FPS at 30
	[director_ setAnimationInterval:1.0/30];
    
    [glView setMultipleTouchEnabled:YES]; 

	// attach the openglView to the director
	[director_ setView:glView];
    
	// for rotation and other messages
	[director_ setDelegate:self];
    
	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
    
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	
    if(UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
        if( ! [director_ enableRetinaDisplay:YES] )
            CCLOG(@"Retina Display Not supported");
    }
       
	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:YES];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-hd"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-hd"];	// Default on iPad RetinaDisplay is "-ipadhd"
    
	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
    
	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
	[director_ pushScene: [SceneMainMenu node]];
	
	// Create a Navigation Controller with the Director
	navController_ = [[RootViewController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;
	
	// set the Navigation Controller as the root view controller
    //	[window_ addSubview:navController_.view];	// Generates flicker.
	[window_ setRootViewController:navController_];
	
	// make main window visible
	[window_ makeKeyAndVisible];
		
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);    
    
    return YES;
}

//// Supported orientations: Landscape. Customize it for your own needs
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
//}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationLandscapeLeft;
}

void uncaughtExceptionHandler(NSException * exception) {
    [[NSUserDefaults standardUserDefaults] synchronize];

    CCLOG(@"EXCEPTION %@", exception.reason);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    if( [navController_ visibleViewController] == director_ ){
        [director_ pause];
//        [DontRunAppDelegate save];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if( [navController_ visibleViewController] == director_ ){
        [director_ resume];
    }
}


-(void) applicationDidEnterBackground:(UIApplication*)application {
    if( [navController_ visibleViewController] == director_ ){
        [director_ stopAnimation];
//        [DontRunAppDelegate save];
    }
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
    if( [navController_ visibleViewController] == director_ )
        [director_ startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {	
	[[director_ view] removeFromSuperview];
	
	[navController_ release];
	navController_ = nil;
	[window_ release];
    
//    [DontRunAppDelegate save];
	
    CC_DIRECTOR_END();
}

//+(void) save{
//    [[NSUserDefaults standardUserDefaults] setInteger:INTEGER_SAVE_TEST forKey:INTEGER_SAVE_STR];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    NSLog(@"Saving...");
//}


// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[window_ release];
    [navController_ release];

	[super dealloc];
}

@end