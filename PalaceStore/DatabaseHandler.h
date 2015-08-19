//
//  DatabaseHandler.h
//  PalaceStore
//
//  Created by Sreelash S on 26/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"

@interface DatabaseHandler : NSObject

+ (void)insertBannerImages:(NSArray *)bannerImages;
+ (void)insertLatestArrivals:(NSArray *)latestArrivals andPromotions:(NSArray *)promotions;
+ (void)insertProductCategories:(NSArray *)categories;
+ (void)insertSubCategories:(NSArray *)subCategories forParentCategoryId:(NSNumber *)parentCategoryId;

+ (NSArray *)fetchItemsFromTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate;

+ (void)deleteItemsFromTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate;

//Products handling methods

+ (void)insertProductsDetails:(NSArray*)productsCollection forParentCategory:(NSNumber *)parentCategoryId;
+ (void)updateProductDetailswithProductID:(int)productID
                            andCategoryID:(int)categoryID withData:(NSDictionary*)dictionaryData;
@end
