//
//  UIViewController+Refresh.h
//  PalaceStore
//
//  Created by Sreelash S on 13/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Refresh)

- (void)updateCartCount;
- (void)removeCartItemAtIndex:(NSInteger)index;
- (void)paymentOptionAcionWithTag:(NSInteger)tag;
- (void)updateDeleteCartList:(NSInteger)index;
@end
