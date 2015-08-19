//
//  Products.h
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 06/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product_Details;

@interface Products : NSManagedObject

@property (nonatomic, retain) NSNumber * category_id;
@property (nonatomic, retain) NSString * ean;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * isbn;
@property (nonatomic, retain) NSString * jan;
@property (nonatomic, retain) NSNumber * length;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * mpn;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * points;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * product_id;
@property (nonatomic, retain) NSString * sku;
@property (nonatomic, retain) NSString * thumb_image_url;
@property (nonatomic, retain) NSString * upc;
@property (nonatomic, retain) NSNumber * viewed;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) Product_Details *relationship;

@end
