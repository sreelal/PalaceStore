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
    
    self.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:1];
    
}

-(void)addTargetToAddressListView {
    
    if (self.addressListView) {
        [self.btn addTarget:self.addressListView action:@selector(didSelectAddressOption:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)addTargetToPaymentView {
    
    if (self.paymentView) {
        [self.btn addTarget:self.paymentView action:@selector(didSelectPaymentOption:) forControlEvents:UIControlEventTouchUpInside];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
