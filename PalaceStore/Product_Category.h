//
//  Product_Category.h
//  PalaceStore
//
//  Created by Sreelash S on 02/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product_Category : NSManagedObject

@property (nonatomic, retain) NSNumber * category_id;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * product_count;
@property (nonatomic, retain) NSNumber * subcategory_count;
@property (nonatomic, retain) NSNumber * parent_category_id;

@end
