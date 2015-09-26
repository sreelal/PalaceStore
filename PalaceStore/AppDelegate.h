//
//  AppDelegate.h
//  PalaceStore
//
//  Created by Sreelal  Hamsavahanan on 02/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputAccessoryBar.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (retain) MBProgressHUD *hud;

+ (AppDelegate *)instance;

- (void)hideBusyView;

- (void)showBusyView:(NSString *)textToDisplay;

- (InputAccessoryBar *)getInputAccesory;

- (UIBarButtonItem *)getHomeBarButtonItemWithTarget:(id)target andSelector:(SEL)homeAction;

- (UIBarButtonItem *)getCartBarButtonItemWithTarget:(id)target andSelector:(SEL)cartAction;

- (NSArray *)getCartAndHomeButtonItemsWithTarget:(id)target andCartSelector:(SEL)cartAction andHomeSelector:(SEL)homeAction;

@end

