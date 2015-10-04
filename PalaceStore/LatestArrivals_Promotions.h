//
//  LatestArrivals_Promotions.h
//  
//
//  Created by Sreelal H on 04/10/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product_Details;

@interface LatestArrivals_Promotions : NSManagedObject

@property (nonatomic, retain) NSNumber * is_latest;
@property (nonatomic, retain) NSNumber * is_promotion;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * product_description;
@property (nonatomic, retain) NSNumber * product_id;
@property (nonatomic, retain) NSNumber * raing;
@property (nonatomic, retain) NSString * tax;
@property (nonatomic, retain) NSString * thumb_image_url;
@property (nonatomic, retain) Product_Details *relationship;

@end
