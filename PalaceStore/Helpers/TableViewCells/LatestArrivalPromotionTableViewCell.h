//
//  HomeBottomTableViewCell.h
//  PalaceStore
//
//  Created by Sreelash S on 05/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"

@class PSHomeViewController;
@interface LatestArrivalPromotionTableViewCell : UITableViewCell <SwipeViewDelegate, SwipeViewDataSource>

@property (strong, nonatomic) PSHomeViewController *callingController;

@property (strong, nonatomic) NSArray *latestArrivals;
@property (strong, nonatomic) NSArray *promotionalItems;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *latestBottonImageView;
@property (weak, nonatomic) IBOutlet UIImageView *promotionBottonImageView;
@property (weak, nonatomic) IBOutlet UIButton *latestBtn;
@property (weak, nonatomic) IBOutlet UIButton *promotionBtn;
@property (weak, nonatomic) IBOutlet UILabel *seperatorLabel;

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;

- (IBAction)loadLatestArrivals:(id)sender;

@end
