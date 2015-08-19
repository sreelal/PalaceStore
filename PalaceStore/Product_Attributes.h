//
//  Product_Attributes.h
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 06/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product_Attributes : NSManagedObject

@property (nonatomic, retain) NSString * attributeName;
@property (nonatomic, retain) NSString * attributeKey;
@property (nonatomic, retain) NSString * attributeValue;

@end
