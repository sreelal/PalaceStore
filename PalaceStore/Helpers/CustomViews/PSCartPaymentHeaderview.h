//
//  PSCartPaymentHeaderview.h
//  PalaceStore
//
//  Created by Sreelash S on 21/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCartPaymentView.h"
#import "PSAddressListView.h"
#import "PSCheckoutConfirmView.h"

@protocol HeaderViewDelegate <NSObject>

@optional
- (void)aboutTappedWithTag:(long)tag;

@end

@interface PSCartPaymentHeaderview : UIView

@property (nonatomic, strong) PSCartPaymentView *paymentView;
@property (nonatomic, strong) PSAddressListView *addressListView;

@property (nonatomic, strong) IBOutlet UILabel *txtLabel;
@property (nonatomic, strong) IBOutlet UIButton *btn;
@property (nonatomic, strong) IBOutlet UIButton *btnEdit;
@property (nonatomic, strong) IBOutlet UIButton *btnAboutUs;

@property (nonatomic, weak) id <HeaderViewDelegate> delegate;

- (void)initHeaderViewForConfirmOrder:(PSCheckoutConfirmView *)confirmOrderView;
- (void)addTargetToAddressListView;
- (void)addTargetToPaymentView;

@end
