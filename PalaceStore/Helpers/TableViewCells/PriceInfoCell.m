//
//  PriceInfoCell.m
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 06/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PriceInfoCell.h"
#import "Product_Details.h"

#import "Cart.h"
#import "WishList.h"

@interface PriceInfoCell (){
}

@property (weak, nonatomic) IBOutlet UILabel *piceInfo;
@property (weak, nonatomic) IBOutlet UILabel *ratingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (weak, nonatomic) IBOutlet PSStarRatingView *ratingsView;

@end


@implementation PriceInfoCell

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (IBAction)buyNowAction:(id)sender {
    
    NSLog(@"%s",__func__);
    
    WishList * wishListObj = [NSEntityDescription insertNewObjectForEntityForName:@"WishList" inManagedObjectContext:[[DatabaseManager sharedInstance] managedObjectContext]];
    
    wishListObj.category_id = self.currentProductObj.category_id;
    wishListObj.price = self.currentProductObj.price;
    wishListObj.product_id = self.currentProductObj.product_id;
    wishListObj.model = self.currentProductObj.model;
    wishListObj.name = self.currentProductObj.name;
    wishListObj.thumb_image_url = self.currentProductObj.thumb_image_url;
    
    [[DatabaseManager sharedInstance]saveContext];
    
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Current item is added to WishList" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];

}
- (IBAction)addToCartAction:(id)sender {
    NSLog(@"%s",__func__);
    
    
    Cart * cartObj = [NSEntityDescription insertNewObjectForEntityForName:@"Cart" inManagedObjectContext:[[DatabaseManager sharedInstance] managedObjectContext]];
    
    cartObj.category_id = self.currentProductObj.category_id;
    cartObj.price = self.currentProductObj.price;
    cartObj.product_id = self.currentProductObj.product_id;
    cartObj.model = self.currentProductObj.model;
    cartObj.name = self.currentProductObj.name;
    cartObj.thumb_image_url = self.currentProductObj.thumb_image_url;
    
    [[DatabaseManager sharedInstance]saveContext];
    
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Current item is added to Cart" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)loadProductInformation:(Products*)productInfo{
    
    
    self.currentProductObj = productInfo;
    
    _piceInfo.text =  [NSString stringWithFormat:@"%0.2f $",[productInfo.price doubleValue]];
    _ratingsLabel.text = [NSString stringWithFormat:@"%d Ratings",[productInfo.relationship.rating intValue]];
    _reviewsLabel.text = [NSString stringWithFormat:@"%d Ratings",[productInfo.relationship.reviews intValue]];
    _ratingsView.ratingValue = [productInfo.relationship.rating intValue];
    
}


@end
