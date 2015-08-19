//
//  PriceInfoCell.m
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 06/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PriceInfoCell.h"
#import "Product_Details.h"


@interface PriceInfoCell (){
}

@property (weak, nonatomic) IBOutlet UILabel *piceInfo;
@property (weak, nonatomic) IBOutlet UILabel *ratingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (weak, nonatomic) IBOutlet PSStarRatingView *ratingsView;

@end


@implementation PriceInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buyNowAction:(id)sender {
    
    
}

- (IBAction)addToCartAction:(id)sender {
    
}

- (void)loadProductInformation:(Products*)productInfo{
    
    _piceInfo.text =  [NSString stringWithFormat:@"%0.2f $",[productInfo.price doubleValue]];
    _ratingsLabel.text = [NSString stringWithFormat:@"%d Ratings",[productInfo.relationship.rating intValue]];
    _reviewsLabel.text = [NSString stringWithFormat:@"%d Ratings",[productInfo.relationship.reviews intValue]];
    _ratingsView.ratingValue = [productInfo.relationship.rating intValue];
    
}


@end
