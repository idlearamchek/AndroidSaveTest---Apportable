//
//  SceneMainMenu.m
//  GravitationDefense
//
//  Created by Patrick Jacob on 10-05-02.
//  Copyright 2010 XperimentalZ Games Inc. All rights reserved.
//

#import "SceneMainMenu.h"
#import "MainMenuLayer.h"

@implementation SceneMainMenu

+ (CCScene *)scene
{
    return [[[self alloc] init] autorelease];
}

-(void) load{
    if(mainMenuLayer == nil){
        mainMenuLayer = [[MainMenuLayer alloc] init];
        [self addChild:mainMenuLayer z:0];
    }
}

-(id) init{
    self = [super init];

    [self load];

    return self;
}


-(void) dealloc{
    [mainMenuLayer release];
    [super dealloc];
}

@end
