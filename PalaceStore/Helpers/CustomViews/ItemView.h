//
//  PromotionItemView.h
//  PalaceStore
//
//  Created by Sreelash S on 05/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LatestArrivals_Promotions.h"
#import "Product_Category.h"

#import "PSHomeViewController.h"

@interface ItemView : UIView {
    IBOutlet UIImageView *imgView;
    IBOutlet UILabel *label;
    IBOutlet UIButton *btn;
    IBOutlet UIActivityIndicatorView *activity;
    
    BOOL isLoading;
}

@property (strong, nonatomic) PSHomeViewController *callingControllerInstance;

@property (nonatomic) IBInspectable CGFloat borderWidth;

- (void)loadItem:(LatestArrivals_Promotions *)item;
- (void)loadCategory:(Product_Category *)category;

@end
