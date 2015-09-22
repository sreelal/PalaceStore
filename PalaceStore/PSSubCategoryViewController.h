//
//  PSCategoryViewController.h
//  PalaceStore
//
//  Created by Sreelash S on 29/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product_Category.h"
#import "SubCategoryCollectionViewCell.h"
#import "AppDelegate.h"
#import "SwipeView.h"

@interface PSSubCategoryViewController : UIViewController <SwipeViewDelegate, SwipeViewDataSource> {
    
    IBOutlet NSLayoutConstraint *viewPinConstraint;
}

@property (nonatomic, strong) Product_Category *productCategory;

@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

- (void)categoryBtnClick:(Product_Category *)subCategory;

@end
