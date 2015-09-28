//
//  Address.h
//  PalaceStore
//
//  Created by Sreelash S on 27/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Address : NSManagedObject

@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * address_1;
@property (nonatomic, retain) NSString * address_2;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * postcode;
@property (nonatomic, retain) NSNumber * is_billingaddress;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSString * address_id;

@end
