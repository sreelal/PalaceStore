//
//  PSProductViewController.h
//  PalaceStore
//
//  Created by Sreelash S on 02/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product_Category.h"

@interface PSProductViewController : UIViewController

@property (nonatomic, strong) Product_Category *productCategory;

@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;

@property (nonatomic, weak) IBOutlet UIView *filterBgView;
@property (nonatomic, weak) IBOutlet UILabel *firstRightBorderLabel;
@property (nonatomic, weak) IBOutlet UILabel *secondRightBorderLabel;
@property (nonatomic, weak) IBOutlet UIImageView *firstBottomBorder;
@property (nonatomic, weak) IBOutlet UIImageView *secondBottomBorder;
@property (nonatomic, weak) IBOutlet UIImageView *thirdBottomBorder;
@property (nonatomic, weak) IBOutlet UIButton *azBtn;
@property (nonatomic, weak) IBOutlet UIButton *highBtn;
@property (nonatomic, weak) IBOutlet UIButton *lowBtn;

@end
