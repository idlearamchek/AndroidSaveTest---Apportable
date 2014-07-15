
//
//  RootViewController.m
//  cocos2d Test
//
//  Created by Ghislain Bernier on 2/7/11.
//  Copyright XperimentalZ Games Inc 2011. All rights reserved.
//

#import "cocos2d.h"
#import "RootViewController.h"

@implementation RootViewController

//- (void)buttonUpWithEvent:(UIEvent *)event
//{
//#ifdef APPORTABLE
//    switch (event.buttonCode)
//    {
//        case UIEventButtonCodeBack:{
//            // Pop current scene
//
//            CCScene<SceneBackProtocol>* runningScene = [CCDirector sharedDirector].runningScene;
//            [runningScene androidBackButton];
//                break;
//        }
//        case UIEventButtonCodeMenu:
//            // show menu if possible.
//            break;
//        default:
//            break;
//    }
//#endif
//}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void) viewDidLoad{
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}

@end
