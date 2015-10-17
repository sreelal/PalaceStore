//
//  BannerTableViewCell.h
//  PalaceStore
//
//  Created by Sreelal H on 04/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "LatestArrivals_Promotions.h"
#import "PSHomeViewController.h"

@interface BannerTableViewCell : UITableViewCell

@property (strong, nonatomic) PSHomeViewController *callingController;

@property (weak, nonatomic) IBOutlet UIView *bannerContainer;
@property (weak, nonatomic) IBOutlet UIView *OfferContainer;
@property (weak, nonatomic) IBOutlet UIView *latestContainer;
@property (weak, nonatomic) IBOutlet UIView *OfferBgView;
@property (weak, nonatomic) IBOutlet UIView *latestBgView;
@property (weak, nonatomic) IBOutlet UIImageView *OfferImgView;
@property (weak, nonatomic) IBOutlet UIImageView *latestImgView;
@property (weak, nonatomic) IBOutlet UILabel *OfferLabel;
@property (weak, nonatomic) IBOutlet UILabel *latestLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *latestActivity;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *offerActivity;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *bannerActivity;

- (void)loadBannerImagesWith:(NSMutableArray*)bannerImages;
- (void)loadPromotion:(LatestArrivals_Promotions *)promotion;
- (void)loadLatestArrival:(LatestArrivals_Promotions *)latestArrival;

@end
