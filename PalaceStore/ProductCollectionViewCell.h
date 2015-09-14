//
//  ProductCollectionViewCell.h
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 03/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Products.h"

@interface ProductCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) id callingController;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UILabel *productInfo;
@property (weak, nonatomic) IBOutlet UILabel *priceInfo;
@property(nonatomic, strong) Products * selectedProductObj;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) IBOutlet UIView *bgView;


- (void)loadProductInformation:(Products *)product;

@end
