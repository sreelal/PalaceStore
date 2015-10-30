//
//  AppDelegate.m
//  PalaceStore
//
//  Created by Sreelal  Hamsavahanan on 02/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "AppDelegate.h"
#import "UIBarButtonItem+Badge.h"
#import "BBBadgeBarButtonItem.h"
#import "AppDelegate.h"
#import "WebHandler.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark - Helper Methods

+ (AppDelegate*)instance {
    
    return [[UIApplication sharedApplication] delegate];
}

- (void)showBusyView:(NSString *)textToDisplay {
    
    _hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    
    _hud.labelText = textToDisplay;
}

- (void)hideBusyView {
    
    [MBProgressHUD hideHUDForView:self.window animated:YES];
    
    self.hud=nil;
}

#pragma mark - Public Methods

- (InputAccessoryBar *)getInputAccesory {
    
    InputAccessoryBar *inputAccessoryBar = [[NSBundle mainBundle] loadNibNamed:@"InputAccessoryBar" owner:self options:nil][0];
    //inputAccessoryBar.delegate = self;
    inputAccessoryBar.frame = CGRectMake(inputAccessoryBar.frame.origin.x, inputAccessoryBar.frame.origin.y, [UIScreen mainScreen].bounds.size.width, inputAccessoryBar.frame.size.height);
    
    return inputAccessoryBar;
}

- (UIImageView *)getNavigationBarImageView {
    
    UIImageView *navBgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"palace_logo.png"]];
    navBgImage.frame = CGRectMake(0, 0, navBgImage.frame.size.width, 30);
    navBgImage.contentMode = UIViewContentModeScaleAspectFit;
    
    return navBgImage;
}

#pragma mark - Navigation Bar Buttons Helper Methods

- (UIBarButtonItem *)getCartBarButtonItemWithTarget:(id)target andSelector:(SEL)cartAction {
    
    UIButton *cartButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 20)];
    [cartButton addTarget:target action:cartAction forControlEvents:UIControlEventTouchUpInside];
    [cartButton setImage:[UIImage imageNamed:@"cart_icon.png"] forState:UIControlStateNormal];
    
    
    BBBadgeBarButtonItem *cartBarButton = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:cartButton];
    
    cartBarButton.badgeOriginX = 13;
    cartBarButton.badgeOriginY = -9;
    
    return cartBarButton;
}

- (UIBarButtonItem *)getHomeBarButtonItemWithTarget:(id)target andSelector:(SEL)homeAction {
    
    UIImage *homeImage = [UIImage imageNamed:@"Home_icon.png"];
     
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithImage:homeImage
     style:UIBarButtonItemStylePlain
     target:target
     action:homeAction];
     
    return homeButton;
}

- (NSArray *)getCartAndHomeButtonItemsWithTarget:(id)target andCartSelector:(SEL)cartAction andHomeSelector:(SEL)homeAction {
    
    UIButton *cartButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 20)];
    [cartButton addTarget:target action:cartAction forControlEvents:UIControlEventTouchUpInside];
    [cartButton setImage:[UIImage imageNamed:@"cart_icon.png"] forState:UIControlStateNormal];
    
    
    BBBadgeBarButtonItem *cartBarButton = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:cartButton];
    
    cartBarButton.badgeOriginX = 13;
    cartBarButton.badgeOriginY = -9;
    
    UIImage *homeImage = [UIImage imageNamed:@"Home_icon.png"];
    UIBarButtonItem *navRightButton2 = [[UIBarButtonItem alloc] initWithImage:homeImage
                                                                                                                style:UIBarButtonItemStylePlain
                                                                                                               target:target
                                                                                                               action:homeAction];
                                        
    cartBarButton.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    navRightButton2.imageInsets = UIEdgeInsetsMake(-3, 5, 0, -5);
    
    NSArray *righBarButtonItems = [NSArray arrayWithObjects:cartBarButton, navRightButton2, nil];
    
    return righBarButtonItems;
    
//    UIImage *image1 = [UIImage imageNamed:@"cart_icon.png"];
//    UIImage *image2 = [UIImage imageNamed:@"Home_icon.png"];
//    
//    UIBarButtonItem *navRightButton1 = [[UIBarButtonItem alloc] initWithImage:image1
//                                                                        style:UIBarButtonItemStylePlain
//                                                                       target:target
//                                                                       action:cartAction];
//    UIBarButtonItem *navRightButton2 = [[UIBarButtonItem alloc] initWithImage:image2
//                                                                        style:UIBarButtonItemStylePlain
//                                                                       target:target
//                                                                       action:homeAction];
//    
//    navRightButton1.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    navRightButton2.imageInsets = UIEdgeInsetsMake(-5, 15, 0, -15);
//    
//    NSArray *righBarButtonItems = [NSArray arrayWithObjects:navRightButton1, navRightButton2, nil];
//    
//    return righBarButtonItems;
}

#pragma mark - Application Delegates

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor]
                                                           , NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
    NSDictionary *_headerTxtAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor]
                                          , NSForegroundColorAttributeName,
                                          [UIFont systemFontOfSize:21.0], NSFontAttributeName, nil];
    
    NSDictionary *_backTxtAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor]
                                        , NSForegroundColorAttributeName,
                                        [UIFont systemFontOfSize:15.0], NSFontAttributeName, nil];
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:_headerTxtAttributes];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(39.0/255.0) green:(41.0/255.0) blue:(132.0/255.0) alpha:1.0]];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:_backTxtAttributes forState:UIControlStateNormal];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavigationBg.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self enablePush];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ];
}

#pragma mark - Enable APNS & Delegates

- (void)enablePush {
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

- (void)application:(UIApplication *)application   didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString   *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler {
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    //if (deviceToken && [[CacheManager sharedInstance] deviceToken] != nil) {
    NSString *token = [deviceToken description];
    token = [token stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"My token is: %@", token);
    
    [WebHandler sendDeviceToken:token withCallback:^(id object, NSError *error) {
        
    }];
    //}
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    NSLog(@"Received notification: %@", userInfo);
}

@end
