//
//  PSCartPaymentHeaderview.h
//  PalaceStore
//
//  Created by Sreelash S on 21/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCartPaymentView.h"

@interface PSCartPaymentHeaderview : UIView

@property (nonatomic, strong) PSCartPaymentView *paymentView;

@property (nonatomic, strong) IBOutlet UILabel *txtLabel;
@property (nonatomic, strong) IBOutlet UIButton *btn;

@end
