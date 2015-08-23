//
//  WishList.h
//  PalaceStore
//
//  Created by Manoj Kumar on 23/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WishList : NSManagedObject

@property (nonatomic, retain) NSNumber * category_id;
@property (nonatomic, retain) NSNumber * product_id;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * thumb_image_url;

@end
