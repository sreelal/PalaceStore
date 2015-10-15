//
//  LatestArrivals_Promotions+CoreDataProperties.h
//  PalaceStore
//
//  Created by MTT User 1 Balasiva on 09/10/15.
//  Copyright © 2015 Sreelal  Hamsavahanan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LatestArrivals_Promotions.h"

NS_ASSUME_NONNULL_BEGIN

@interface LatestArrivals_Promotions (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *is_latest;
@property (nullable, nonatomic, retain) NSNumber *is_promotion;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *product_description;
@property (nullable, nonatomic, retain) NSNumber *product_id;
@property (nullable, nonatomic, retain) NSNumber *raing;
@property (nullable, nonatomic, retain) NSString *tax;
@property (nullable, nonatomic, retain) NSString *thumb_image_url;
@property (nullable, nonatomic, retain) NSString *ean;
@property (nullable, nonatomic, retain) NSNumber *height;
@property (nullable, nonatomic, retain) NSString *isbn;
@property (nullable, nonatomic, retain) NSString *jan;
@property (nullable, nonatomic, retain) NSNumber *length;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSString *model;
@property (nullable, nonatomic, retain) NSString *mpn;
@property (nullable, nonatomic, retain) NSNumber *points;
@property (nullable, nonatomic, retain) NSString *sku;
@property (nullable, nonatomic, retain) NSString *upc;
@property (nullable, nonatomic, retain) NSNumber *viewed;
@property (nullable, nonatomic, retain) NSNumber *weight;
@property (nullable, nonatomic, retain) NSNumber *width;
@property (nullable, nonatomic, retain) Product_Details *relationship;

@end

NS_ASSUME_NONNULL_END
