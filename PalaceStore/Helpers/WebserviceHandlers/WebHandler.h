//
//  RequestHandler.h
//  DMT
//
//  Created by Sreelash S on 10/08/14.
//  Copyright (c) 2014 Sreelash S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestHandler.h"

typedef void (^ResponseCallback) (id object, NSError *error);

@interface WebHandler : NSObject {
    
}

+ (void)getHomeDetailsWithCallback:(ResponseCallback)callback;

+ (void)getSubCategoriesForCategoryId:(int)categoryId withCallback:(ResponseCallback)callback;

+ (void)getProductListWithCategoryId:(int)categoryId withCallback:(ResponseCallback)callback;

+ (void)getproductdetailsWithproductID:(int)productID
                         andCategoryID:(int)categoryID
                          withCallback:(ResponseCallback)callback;

+ (void)signUpWihDict:(NSDictionary *)dataDict withCallback:(ResponseCallback)callback;

+ (void)loginWihDict:(NSDictionary *)dataDict withCallback:(ResponseCallback)callback;

+ (void)getAllAddressWithUserId:(NSString *)userId withCallback:(ResponseCallback)callback;

+ (void)addAddressWihDict:(NSDictionary *)dataDict withUserId:(NSString *)userId withCallback:(ResponseCallback)callback;

@end
