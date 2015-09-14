//
//  Cart.h
//  PalaceStore
//
//  Created by Teja Swaroop on 21/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Cart : NSManagedObject

@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * category_id;
@property (nonatomic, retain) NSNumber * product_id;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * thumb_image_url;
@property (nonatomic, retain) NSNumber * count;

@end
