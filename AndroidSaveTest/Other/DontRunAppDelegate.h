//
//  DontRunAppDelegate.h
//  cocos2d Test
//
//  Created by Ghislain Bernier on 2/7/11.
//  Copyright XperimentalZ Games Inc 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CocosDenshion.h"
#import "cocos2d.h"
#import "RootViewController.h"

@interface DontRunAppDelegate : NSObject <UIApplicationDelegate, CCDirectorDelegate> {
	UIWindow *window_;
    UIWindow* _secondWindow;
    UIScreen* extScreen;

    UIImageView * imageView;
                                              
	RootViewController *navController_;
    
	CCDirectorIOS	*director_;							// weak ref
}

-(void)applicationWillResignActive:(UIApplication *)application;


@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *viewController;
@property (readonly) CCDirectorIOS *director;

@end
