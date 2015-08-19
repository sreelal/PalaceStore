//
//  NSString+Empty.m
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 07/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "NSString+Empty.h"

@implementation NSString (Empty)

+ (NSString*)getActualValue:(NSString*)optionalValue{
    
    return ([optionalValue isKindOfClass:[NSNull class]])?@"":optionalValue;
}


@end
