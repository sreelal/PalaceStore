//
//  HelperClass.m
//  DeviceGH
//
//  Created by Sreelash S on 16/12/14.
//  Copyright (c) 2014 Sreelal H. All rights reserved.
//

#import "HelperClass.h"
#import "UIColor+CustomColor.h"
#import "Constants.h"

@implementation HelperClass

+ (BOOL)hasNetwork {
    
    BOOL status;
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) status = NO;
    else status = YES;
    
    return status;
}

+ (BOOL)cacheJsonForData:(id)data withName:(NSString *)fileName {
    
    BOOL isCached;
    
    NSString* cachedDirectoryName = [CacheDirectory stringByAppendingPathComponent:fileName];
    
    isCached = [data writeToFile:cachedDirectoryName atomically:YES];
    
    return isCached;
}

+ (id)getCachedJsonFor:(NSString *)fileName {
    
    id cachedObject = nil;
    
    NSString *filePath = [CacheDirectory stringByAppendingPathComponent:fileName];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    if (fileExists) {
        cachedObject = [NSArray arrayWithContentsOfFile:filePath];
    }
    
    return cachedObject;
}

+ (void)loadImageWithURL:(NSString *)imageURL andCompletionBlock:(void(^)(UIImage *img, NSData *imgData))block {
    
    NSString *encodedURL = [imageURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURL *url = [NSURL URLWithString:encodedURL];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        NSData *data        = [NSData dataWithContentsOfURL:url];
        UIImage *image      = [UIImage imageWithData:data];
        
        block(image, data);
    });
}

+ (BOOL)cacheImageWithData:(NSData *)imageData withName:(NSString *)imageName {
    
    BOOL isCached = NO;
    
    if (imageData && imageName) {
        NSString *imagePath = [CacheDirectory stringByAppendingPathComponent:imageName];
        
        isCached = [imageData writeToFile:imagePath atomically:YES];        
    }
    
    return isCached;
}

+ (void)getCachedImageWithName:(NSString *)imageName withCompletionBlock:(void(^)(UIImage *img))block {
    
    NSString *filePath = [CacheDirectory stringByAppendingPathComponent:imageName];
    UIImage *image     = [UIImage imageWithContentsOfFile:filePath];
    
    block(image);
}

+ (NSDictionary *)getRightBarButtonItemTextAttributes {
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    NSDictionary *rightBarButtonTextAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor lightGrayColor]
                                                  , NSForegroundColorAttributeName,
                                                  shadow, NSShadowAttributeName,
                                                  [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:13.0], NSFontAttributeName, nil];
    
    return rightBarButtonTextAttributes;
}

+ (NSString *)getStringDateFromTimeStamp:(NSString *)timeStamp {
    
    NSString *strDate;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    
    strDate = [self getStringDateFromNSDate:date];
    
    return strDate;
}

+ (NSString *)getStringDateFromNSDate:(NSDate *)date {
    
    NSString *strDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    strDate = [formatter stringFromDate:date];
    
    return strDate;
}

+ (BOOL)is6thGeneration {
    
    BOOL status = NO;
    
    if ([UIScreen mainScreen].bounds.size.width > 320) status = YES;
    
    return status;
}

+ (BOOL)is5thGeneration {
    
    BOOL status = NO;
    
    if ([UIScreen mainScreen].bounds.size.height == 568) status = YES;
    
    return status;
}

+ (BOOL)isIphone6 {
    
    BOOL status = NO;
    
    if ([UIScreen mainScreen].bounds.size.width == 375) status = YES;
    
    return status;
}

+ (BOOL)isIphone6Plus {
    
    BOOL status = NO;
    
    if ([UIScreen mainScreen].bounds.size.width == 414) status = YES;
    
    return status;
}

+ (BOOL)is4thGeneration {
    
    BOOL status = NO;
    
    if ([UIScreen mainScreen].bounds.size.height == 480) status = YES;
    
    return status;
}

+ (void)showAlertWithMessage:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:ALERT_OK otherButtonTitles:nil, nil];
    [alert show];
}

+ (void)addBorderForView:(UIView *)view withHexCodeg:(NSString *)hexCode andAlpha:(CGFloat)alpha {
    
    UIColor *borderColor = [UIColor getUIColorObjectFromHexString:hexCode alpha:alpha];
    view.layer.borderColor = borderColor.CGColor;
    view.layer.borderWidth = 1.0f;
}

+ (UIBarButtonItem *)getBackButtonItemWithTarget:(id)target andAction:(SEL)action {
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_btn_back"] style:UIBarButtonItemStylePlain target:target action:action];
    
    leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -19, 1, 0);
    [leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor blackColor], NSForegroundColorAttributeName,nil]
                                     forState:UIControlStateNormal];
    
    return leftBarButtonItem;
}

+ (UIBarButtonItem *)getMenuButtonItemWithTarget:(id)target andAction:(SEL)action {
    
    UIBarButtonItem * menuButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"MenuIcon.png"] style:UIBarButtonItemStylePlain target:target action:action];
    
    return menuButtonItem;
}

+ (void)makeRoundedImageViewForView:(UIImageView *)imgView {
    
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.layer.borderWidth = 2.0f;
    imgView.layer.borderColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:1.0].CGColor;
    imgView.layer.cornerRadius = imgView.frame.size.width / 2;
    imgView.clipsToBounds = YES;
}

+ (NSString *) getTimeStamp {
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
}

+ (NSNumber *)getNSNumberFromString:(NSString *)string {
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *nsNumber = [numberFormatter numberFromString:string];
    
    return nsNumber;
}

@end
