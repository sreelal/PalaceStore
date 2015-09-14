//
//  MyCartCell.h
//  PalaceStore
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCartCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *cartImage;
@property (strong, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet UILabel *itemCost;
@property (strong, nonatomic) IBOutlet UILabel *sellerLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ratingImage;
@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;
@property (strong, nonatomic) IBOutlet UILabel *offerLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

- (void)loadProductImage:(NSString*)productURL;

- (IBAction)removeAction:(id)sender;
- (IBAction)placeOrderAction:(id)sender;

@end
