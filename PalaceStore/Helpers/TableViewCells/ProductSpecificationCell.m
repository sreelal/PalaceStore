//
//  ProductSpecificationCell.m
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 07/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "ProductSpecificationCell.h"
#import "Product_Details.h"


@interface ProductSpecificationCell (){
    
}
@property (weak, nonatomic) IBOutlet UILabel *manufacturerLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *dimensionLabel;

@end

@implementation ProductSpecificationCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadSpecifications:(Products*)productDetails{
    
    _manufacturerLabel.text = productDetails.relationship.manufacturer;
    _modelLabel.text = productDetails.model;
    _pointsLabel.text = [NSString stringWithFormat:@"%d",[productDetails.points intValue]];
    _weightLabel.text = [NSString stringWithFormat:@"%0.1f g",[productDetails.weight doubleValue]];
    _dimensionLabel.text = [NSString stringWithFormat:@"%0.1f x %0.1f x %0.1f",[productDetails.length doubleValue],[productDetails.width doubleValue],[productDetails.height doubleValue]];
}

@end
