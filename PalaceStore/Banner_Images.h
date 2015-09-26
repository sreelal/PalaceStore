//
//  Banner_Images.h
//  PalaceStore
//
//  Created by Sreelal H on 26/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Banner_Images : NSManagedObject

@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * isBrands;

@end
