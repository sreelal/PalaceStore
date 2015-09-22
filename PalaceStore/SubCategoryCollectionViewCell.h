//
//  SubCategoryCollectionViewCell.h
//  PalaceStore
//
//  Created by Sreelash S on 01/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonHeaders.h"
#import "Product_Category.h"

@class PSSubCategoryViewController;
@interface SubCategoryCollectionViewCell : UICollectionViewCell 

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIButton *btn;

@property (strong, nonatomic) PSSubCategoryViewController *callingControllerInstance;

- (void)loadSubCategory:(Product_Category *)subCategory;

@end
