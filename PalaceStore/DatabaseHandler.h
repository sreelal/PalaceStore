//
//  DatabaseHandler.h
//  PalaceStore
//
//  Created by Sreelash S on 26/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Products.h"
#import "DatabaseManager.h"

@interface DatabaseHandler : NSObject

+ (void)insertBannerImages:(NSArray *)bannerImages;
+ (void)insertLatestArrivals:(NSArray *)latestArrivals andPromotions:(NSArray *)promotions;
+ (void)insertProductCategories:(NSArray *)categories;
+ (void)insertSubCategories:(NSArray *)subCategories forParentCategoryId:(NSNumber *)parentCategoryId;
+ (void)insertLogoImages:(NSArray *)logoImages;

+ (NSArray *)fetchItemsFromTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate;

+ (void)deleteItemsFromTableWithDictionary:(NSDictionary *)dictionaryObj;
+ (void)deleteItemsFromTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate;

//Products handling methods

+ (void)insertProductsDetails:(NSArray*)productsCollection forParentCategory:(NSNumber *)parentCategoryId;
+ (void)updateProductDetailswithProductID:(int)productID
                       andIsLatestArrival:(BOOL)latestArrival
                            andCategoryID:(int)categoryID withData:(NSDictionary*)dictionaryData;
+ (void)addToCartWithObj:(Products *)product;
+ (void)addToAddressWithDict:(NSMutableDictionary *)addressDict;

@end
