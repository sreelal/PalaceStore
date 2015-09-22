//
//  PSCartPaymentHeaderview.m
//  PalaceStore
//
//  Created by Sreelash S on 21/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSCartPaymentHeaderview.h"
#import "UIColor+CustomColor.h"

@implementation PSCartPaymentHeaderview

- (void)awakeFromNib {
    [self.btn addTarget:self.paymentView action:@selector(didSelectPaymentOption:) forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.5];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
