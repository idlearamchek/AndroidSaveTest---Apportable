//
//  MainMenuLayer.m
//  cocos2dAndTemplate
//
//  Created by Ghislain Bernier on 5/24/11.
//  Copyright 2011 XperimentalZ Games Inc. All rights reserved.
//

#import "MainMenuLayer.h"
#import "SceneMainMenu.h"
#import "DontRunAppDelegate.h"

#define APPORTABLE_SDK_1_0_34 NO
#define APPORTABLE_SDK_1_1_13 !APPORTABLE_SDK_1_0_34


#define INTEGER_SAVE_STR @"integer"
#define INTEGER_SAVE_1034 1034
//#define INTEGER_SAVE_1113 1113


@implementation MainMenuLayer

-(id) init{
	self = [super init];
    
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED    
    self.touchEnabled = YES;
#elif defined(__MAC_OS_X_VERSION_MAX_ALLOWED)
    self.keyboardEnabled = YES;
    self.mouseEnabled = YES;
#endif
    
    [self constructMainMenu];
    
	return self;
}

-(void) constructMainMenu{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    CCSprite * spi = [CCSprite spriteWithFile:@"main_menu_bg.png"];
    spi.anchorPoint = ccp(0,0);
    spi.position = ccp(0,0);
    [self addChild:spi];
    
    CCLabelBMFont * label = [CCLabelBMFont labelWithString:@"" fntFile:@"bd_cartoon_font.fnt"];
    label.position = ccp(20, 20);
    label.anchorPoint = ccp(0, 1);
    label.scale = .85;
    [self addChild:label];

    NSString * strVersion = @"version 1.0.34";
    
    if(APPORTABLE_SDK_1_1_13){
        strVersion = @"version 1.1.13";
    }
    
    CCLabelBMFont * labelTitle = [CCLabelBMFont labelWithString:strVersion fntFile:@"bd_cartoon_font.fnt"];
    [self addChild:labelTitle];
    
    labelTitle.anchorPoint = ccp(0.5, 1);
    labelTitle.position = ccp(winSize.height/2, winSize.width);

    CCSprite * loadSpi = [CCSprite spriteWithFile:@"load.png"];
    CCSprite * loadSpiSel = [CCSprite spriteWithFile:@"load.png"];
    loadSpiSel.opacity = 128;
    
    CCMenuItemSprite * loadButton = [CCMenuItemSprite itemWithNormalSprite:loadSpi selectedSprite:loadSpiSel block:^(id sender){
        int integer = [[NSUserDefaults standardUserDefaults] integerForKey:INTEGER_SAVE_STR];

        mStatusLbl.string = [NSString stringWithFormat:@"Loaded integer : %d", integer];
    }];
    
//    loadButton.position = ccp(winSize.height * 0.25, winSize.width * 0.7);
    
    CCSprite * saveSpi = [CCSprite spriteWithFile:@"save.png"];
    CCSprite * saveSpiSel = [CCSprite spriteWithFile:@"save.png"];
    saveSpiSel.opacity = 128;
    
    CCMenuItemSprite * saveButton = nil;
   
    if(APPORTABLE_SDK_1_0_34){
        saveButton = [CCMenuItemSprite itemWithNormalSprite:saveSpi selectedSprite:saveSpiSel block:^(id sender){
            int integer = INTEGER_SAVE_1034;
            
            //        if(APPORTABLE_SDK_1_1_13)
            //            integer = INTEGER_SAVE_1113;
            
            [[NSUserDefaults standardUserDefaults] setInteger:integer forKey:INTEGER_SAVE_STR];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            mStatusLbl.string = [NSString stringWithFormat:@"Saved integer : %d", integer];
        }];
        
//        saveButton.position = ccp(winSize.width * 0.75, winSize.height * 0.7);
    }
    
    CCMenu * menu = [CCMenu menuWithItems:loadButton, saveButton, nil];
    [menu alignItemsHorizontally];
    menu.position = ccp(winSize.height * .5, winSize.width * .5);
    [self addChild:menu];
    
    mStatusLbl = [CCLabelBMFont labelWithString:@"" fntFile:@"bd_cartoon_font.fnt"];
    mStatusLbl.position = ccp(winSize.height/2, winSize.width * 0.1);
    [self addChild:mStatusLbl];
}

-(void)dealloc {
    [super dealloc];
}

@end
