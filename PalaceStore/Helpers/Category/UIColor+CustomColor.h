//
//  UIColor+CustomColor.h
//  PalaceStore
//
//  Created by Sreelash S on 27/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CustomColor)

+ (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

@end
