//
//  Product_Details.h
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 06/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product_Attributes;

@interface Product_Details : NSManagedObject

@property (nonatomic, retain) NSString * detailedInfo;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSString * stock_status;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * manufacturer;
@property (nonatomic, retain) NSNumber * reward;
@property (nonatomic, retain) NSString * date_available;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSNumber * reviews;
@property (nonatomic, retain) NSSet *relationship;
@end

@interface Product_Details (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(Product_Attributes *)value;
- (void)removeRelationshipObject:(Product_Attributes *)value;
- (void)addRelationship:(NSSet *)values;
- (void)removeRelationship:(NSSet *)values;

@end
