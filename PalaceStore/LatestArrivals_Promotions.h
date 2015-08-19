//
//  LatestArrivals_Promotions.h
//  PalaceStore
//
//  Created by Sreelash S on 26/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LatestArrivals_Promotions : NSManagedObject

@property (nonatomic, retain) NSNumber * product_id;
@property (nonatomic, retain) NSNumber * is_latest;
@property (nonatomic, retain) NSNumber * is_promotion;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * product_description;
@property (nonatomic, retain) NSNumber * raing;
@property (nonatomic, retain) NSString * tax;
@property (nonatomic, retain) NSString * thumb_image_url;

@end
