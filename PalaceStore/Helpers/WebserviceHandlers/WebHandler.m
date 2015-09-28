//
//  RequestHandler.h
//  DMT
//
//  Created by Sreelash S on 10/08/14.
//  Copyright (c) 2014 Sreelash S. All rights reserved.
//

#import "WebHandler.h"
#import "Constants.h"
#import "HelperClass.h"
#import "DatabaseHandler.h"
#import "Banner.h"
#import "AppDelegate.h"

@implementation WebHandler

+ (void)getHomeDetailsWithCallback:(ResponseCallback)callback {
    
    if (![HelperClass hasNetwork]) {
        [self showAlertWithMessage:ALERT_INTERNET_FAILURE];
        [[AppDelegate instance] hideBusyView];
        
        return;
    }
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@%@", SERVICE_URL_ROOT, SERVICE_HOME];
    
    [RequestHandler getRequestWithURL:serviceURL withCallback:^(id result, NSError *error) {
        
        if (result != nil) {
            
            [DatabaseHandler deleteItemsFromTable:TABLE_BANNER_IMAGES withPredicate:nil];
            [DatabaseHandler deleteItemsFromTable:TABLE_LATEST_ARRIVALS_PROMOTIONS withPredicate:nil];
            [DatabaseHandler deleteItemsFromTable:TABLE_PRODUCT_CATEGORY withPredicate:nil];
            
            [DatabaseHandler insertBannerImages:result[KEY_BANNER_IMAGES]];
            [DatabaseHandler insertLogoImages:result[KEY_BRANDS]];
            [DatabaseHandler insertLatestArrivals:result[KEY_LATEST_ARRIVALS] andPromotions:result[KEY_PROMOIONS]];
            [DatabaseHandler insertProductCategories:result[KEY_CATEGORIES]];
        }
        
        callback(result, error);
    }];
}

+ (void)getSubCategoriesForCategoryId:(int)categoryId withCallback:(ResponseCallback)callback {
    
    if (![HelperClass hasNetwork]) {
        [self showAlertWithMessage:ALERT_INTERNET_FAILURE];
        [[AppDelegate instance] hideBusyView];
        
        return;
    }
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@%@%d", SERVICE_URL_ROOT, SERVICE_SUB_CATEGORY, categoryId];
    
    [RequestHandler getRequestWithURL:serviceURL withCallback:^(id result, NSError *error) {
        
        if (result != nil) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parent_category_id == %d", categoryId];
            [DatabaseHandler deleteItemsFromTable:TABLE_PRODUCT_CATEGORY withPredicate:predicate];
            [DatabaseHandler insertSubCategories:result forParentCategoryId:[NSNumber numberWithInt:categoryId]];
        }
        
        callback(result, error);
    }];
}

+ (void)getProductListWithCategoryId:(int)categoryId withCallback:(ResponseCallback)callback{
    
    if (![HelperClass hasNetwork]) {
        [self showAlertWithMessage:ALERT_INTERNET_FAILURE];
        [[AppDelegate instance] hideBusyView];
        
        return;
    }
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@%@%d", SERVICE_URL_ROOT, SERVICE_PRODUCT, categoryId];
    
    [RequestHandler getRequestWithURL:serviceURL withCallback:^(id result, NSError *error) {
        
        if (result != nil) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category_id == %d", categoryId];
            [DatabaseHandler deleteItemsFromTable:TABLE_PRODUCTS withPredicate:predicate];
            [DatabaseHandler insertProductsDetails:result
                               forParentCategory:[NSNumber numberWithInt:categoryId]];
        }
        
        callback(result, error);
    }];
}

+ (void)showAlertWithMessage:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:ALERT_OK otherButtonTitles:nil, nil];
    [alert show];
}

+ (void)getproductdetailsWithproductID:(int)productID andCategoryID:(int)categoryID  withCallback:(ResponseCallback)callback{
    
    if (![HelperClass hasNetwork]) {
        [self showAlertWithMessage:ALERT_INTERNET_FAILURE];
        [[AppDelegate instance] hideBusyView];
        
        return;
    }
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@%@%d", SERVICE_URL_ROOT, SERVICE_PRODUCT_DETAIL, productID];
    [RequestHandler getRequestWithURL:serviceURL withCallback:^(id result, NSError *error) {
        
        if (result != nil) {

            [DatabaseHandler updateProductDetailswithProductID:productID
                                                 andCategoryID:categoryID
                                                      withData:result];
        }
        
        callback(result, error);
    }];
}

+ (void)signUpWihDict:(NSDictionary *)dataDict withCallback:(ResponseCallback)callback {
    
    if ([HelperClass hasNetwork]) {
        NSString *serviceURL = [NSString stringWithFormat:@"%@%@", SERVICE_URL_ROOT, SERVICE_SIGN_UP];
        
        NSLog(@"Service URL : %@", serviceURL);
        
        [RequestHandler postRequestWithURL:serviceURL andDictionary:dataDict withCallback:^(id result, NSError *error) {
            callback(result, error);
        }];
    }
    else {
        [self showAlertWithMessage:ALERT_INTERNET_FAILURE];
        callback(nil, nil);
    }    
}

+ (void)loginWihDict:(NSDictionary *)dataDict withCallback:(ResponseCallback)callback {
    
    if ([HelperClass hasNetwork]) {
        NSString *serviceURL = [NSString stringWithFormat:@"%@%@", SERVICE_URL_ROOT, SERVICE_LOGIN];
        
        NSLog(@"Service URL : %@", serviceURL);
        
        [RequestHandler postRequestWithURL:serviceURL andDictionary:dataDict withCallback:^(id result, NSError *error) {
            callback(result, error);
        }];
    }
    else {
        [self showAlertWithMessage:ALERT_INTERNET_FAILURE];
        callback(nil, nil);
    }
}

+ (void)getAllAddressWithUserId:(NSString *)userId withCallback:(ResponseCallback)callback {
    
    if (![HelperClass hasNetwork]) {
        [self showAlertWithMessage:ALERT_INTERNET_FAILURE];
        [[AppDelegate instance] hideBusyView];
        
        return;
    }
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@%@%@", SERVICE_URL_ROOT, SERVICE_ALL_ADDRESSES, userId];
    [RequestHandler getRequestWithURL:serviceURL withCallback:^(id result, NSError *error) {
        
        if (result != nil) {
            
        }
        
        callback(result, error);
    }];
}

+ (void)addAddressWihDict:(NSDictionary *)dataDict withUserId:(NSString *)userId withCallback:(ResponseCallback)callback {
    
    if ([HelperClass hasNetwork]) {
        NSString *serviceURL = [NSString stringWithFormat:@"%@%@%@", SERVICE_URL_ROOT, SERVICE_ADD_ADDRESS, userId];
        
        NSLog(@"Service URL : %@", serviceURL);
        
        [RequestHandler postRequestWithURL:serviceURL andDictionary:dataDict withCallback:^(id result, NSError *error) {
            callback(result, error);
        }];
    }
    else {
        [self showAlertWithMessage:ALERT_INTERNET_FAILURE];
        callback(nil, nil);
    }
}

@end
