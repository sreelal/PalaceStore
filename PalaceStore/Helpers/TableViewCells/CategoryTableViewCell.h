//
//  CategoryTableViewCell.h
//  PalaceStore
//
//  Created by Sreelash S on 27/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "SLMarqueeView.h"
#import "PSHomeViewController.h"

@interface CategoryTableViewCell : UITableViewCell <SwipeViewDelegate, SwipeViewDataSource, SLMarqueeViewDelegate>

@property (strong, nonatomic) NSArray *categories;


@property (weak, nonatomic) IBOutlet UIView *topBar;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (weak, nonatomic) IBOutlet SLMarqueeView *marqueeView;

@property (strong, nonatomic) PSHomeViewController *callingControllerInstance;

- (void)loadCategories;
- (void)loadMarqueeControlWith:(NSMutableArray*)marqueeViews;
@end
