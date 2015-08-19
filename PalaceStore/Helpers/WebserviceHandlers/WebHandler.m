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


@implementation WebHandler

+ (void)getHomeDetailsWithCallback:(ResponseCallback)callback {
    
    if (![HelperClass hasNetwork]) {
        [self showAlertWithMessage:ALERT_INTERNET_FAILURE];
        return;
    }
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@%@", SERVICE_URL_ROOT, SERVICE_HOME];
    
    [RequestHandler getRequestWithURL:serviceURL withCallback:^(id result, NSError *error) {
        
        if (result != nil) {
            
            [DatabaseHandler deleteItemsFromTable:TABLE_BANNER_IMAGES withPredicate:nil];
            [DatabaseHandler deleteItemsFromTable:TABLE_LATEST_ARRIVALS_PROMOTIONS withPredicate:nil];
            [DatabaseHandler deleteItemsFromTable:TABLE_PRODUCT_CATEGORY withPredicate:nil];
            
            [DatabaseHandler insertBannerImages:result[KEY_BANNER_IMAGES]];
            [DatabaseHandler insertLatestArrivals:result[KEY_LATEST_ARRIVALS] andPromotions:result[KEY_PROMOIONS]];
            [DatabaseHandler insertProductCategories:result[KEY_CATEGORIES]];
        }
        
        callback(result, error);
    }];
}

+ (void)getSubCategoriesForCategoryId:(int)categoryId withCallback:(ResponseCallback)callback {
    
    if (![HelperClass hasNetwork]) {
        [self showAlertWithMessage:ALERT_INTERNET_FAILURE];
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
        return;
    }
    
    NSString *serviceURL = @"http://ezcomdesign.com/demo/palace/index.php?route=service/product&category=20";//[NSString stringWithFormat:@"%@%@%d", SERVICE_URL_ROOT, SERVICE_PRODUCT, categoryId];
    
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

@end
