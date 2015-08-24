//
//  ProductCollectionViewCell.m
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 03/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "ProductCollectionViewCell.h"
#import "HelperClass.h"
#import "PSProductViewController.h"
#import "UIColor+CustomColor.h"
#import "Cart.h"

#import "WishList.h"

@interface ProductCollectionViewCell () {
    BOOL isLoading;
}

@end

@implementation ProductCollectionViewCell


- (void)loadProductInformation:(Products *)product{
    
    self.selectedProductObj = product;
    
    NSString *_priceinformation = [NSString stringWithFormat:@"%0.2f $",[product.price doubleValue]];
    self.priceInfo.text = _priceinformation;
    self.productInfo.text = product.name;
    
    [_activity setHidesWhenStopped:YES];
    [_activity setHidden:NO];
    [_activity startAnimating];

    
    [HelperClass addBorderForView:_bgView withHexCodeg:COLOR_HEX_LIGHT_GRAY andAlpha:0.5];
    _bgView.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.2];

    
    NSString *imgURL = product.thumb_image_url;
    NSArray *urlSplits = [imgURL componentsSeparatedByString:@"/"];
    NSString *imageName = [urlSplits lastObject];
    
    
    if (imgURL) {
        [HelperClass getCachedImageWithName:imageName withCompletionBlock:^(UIImage *img) {
            if (img) {
                [_activity stopAnimating];
                _productImage.image = img;
            }
            else if (!isLoading) {
                isLoading = YES;
                
                [HelperClass loadImageWithURL:imgURL andCompletionBlock:^(UIImage *img, NSData *imgData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                       [_activity stopAnimating];
                        if (img) _productImage.image = img;
                    });
                    
                    if (imgData) {
                        BOOL isImageCached = [HelperClass cacheImageWithData:imgData withName:imageName];
                        
                        if (isImageCached) NSLog(@"%@ SubCategory Image Cached", imageName);
                        else NSLog(@"%@ Image Not Cached", imageName);
                    }
                    
                    isLoading = NO;
                }];
            }
        }];
    }
    else {
        _productImage.image = [UIImage imageNamed:@"no_image.png"];
    }
}

- (IBAction)cartAction:(id)sender
{
    Cart * cartObj = [NSEntityDescription insertNewObjectForEntityForName:@"Cart" inManagedObjectContext:[[DatabaseManager sharedInstance] managedObjectContext]];
    
    cartObj.category_id = self.selectedProductObj.category_id;
    cartObj.price = self.selectedProductObj.price;
    cartObj.product_id = self.selectedProductObj.product_id;
    cartObj.model = self.selectedProductObj.model;
    cartObj.name = self.selectedProductObj.name;
    cartObj.thumb_image_url = self.selectedProductObj.thumb_image_url;
    
    [[DatabaseManager sharedInstance]saveContext];
    
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Current item is added to Cart" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];

}

- (IBAction)wishlistAction:(id)sender
{
    WishList * wishObj = [NSEntityDescription insertNewObjectForEntityForName:@"WishList" inManagedObjectContext:[[DatabaseManager sharedInstance] managedObjectContext]];
    
    wishObj.category_id = self.selectedProductObj.category_id;
    wishObj.price = self.selectedProductObj.price;
    wishObj.product_id = self.selectedProductObj.product_id;
    wishObj.model = self.selectedProductObj.model;
    wishObj.name = self.selectedProductObj.name;
    wishObj.thumb_image_url = self.selectedProductObj.thumb_image_url;
    
    [[DatabaseManager sharedInstance]saveContext];
    
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Current item is added to wishlist" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];

}

/*

- (void)loadProductDetails:(Product_Category *)subCategory {
    
    sub_Category = subCategory;
    
    _bgView.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.2];
    [HelperClass addBorderForView:_bgView withHexCodeg:COLOR_HEX_LIGHT_GRAY andAlpha:0.5];
    
    _activity.hidesWhenStopped = YES;
    
    NSString *imgURL = subCategory.image_url;
    NSArray *urlSplits = [imgURL componentsSeparatedByString:@"/"];
    NSString *imageName = [urlSplits lastObject];
    
    _categoryNameLabel.text = subCategory.name;
    
    if (imgURL) {
        [HelperClass getCachedImageWithName:imageName withCompletionBlock:^(UIImage *img) {
            if (img) {
                [_activity stopAnimating];
                _imageView.image = img;
            }
            else if (!isLoading) {
                isLoading = YES;
                
                [HelperClass loadImageWithURL:imgURL andCompletionBlock:^(UIImage *img, NSData *imgData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_activity stopAnimating];
                        if (img) _imageView.image = img;
                    });
                    
                    if (imgData) {
                        BOOL isImageCached = [HelperClass cacheImageWithData:imgData withName:imageName];
                        
                        if (isImageCached) NSLog(@"%@ SubCategory Image Cached", imageName);
                        else NSLog(@"%@ Image Not Cached", imageName);
                    }
                    
                    isLoading = NO;
                }];
            }
        }];
    }
    else {
        _imageView.image = [UIImage imageNamed:@"no_image.png"];
    }
}
*/
@end
