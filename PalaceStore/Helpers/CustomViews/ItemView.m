//
//  PromotionItemView.m
//  PalaceStore
//
//  Created by Sreelash S on 05/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "ItemView.h"
#import "HelperClass.h"
#import "UIColor+CustomColor.h"
#import "LatestArrivals_Promotions.h"

@interface ItemView ()

@property (strong, nonatomic) Product_Category *productCategory;
@property (strong, nonatomic) LatestArrivals_Promotions *lateArrPromotion;

@end

@implementation ItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)updateNewArrivalItemWithDict:(NSDictionary *)dict {
    
    imgView.image = [UIImage imageNamed:dict[@"image"]];
    label.text = dict[@"name"];
}

- (void)loadItem:(LatestArrivals_Promotions *)item {
    
    _lateArrPromotion = item;
    
    label.text = item.name;
    
    [activity setHidesWhenStopped:YES];
    [activity setHidden:NO];
    [activity startAnimating];
    
    NSString *imageURL = item.thumb_image_url;
    NSArray *urlSplits = [imageURL componentsSeparatedByString:@"/"];
    
    NSLog(@"Image Name : %@", [urlSplits lastObject]);
    
    NSString *imageName = [urlSplits lastObject];
    
    if (imageURL) {
        [HelperClass getCachedImageWithName:imageName withCompletionBlock:^(UIImage *img) {
            if (img) {
                [activity stopAnimating];
                imgView.image = img;
                //NSLog(@"Cached Image Loaded for %@", imageName);
            }
            else if (!isLoading) {
                isLoading = YES;
                
                [HelperClass loadImageWithURL:imageURL andCompletionBlock:^(UIImage *img, NSData *imgData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [activity stopAnimating];
                        if (img) imgView.image = img;
                        else imgView.image = [UIImage imageNamed:@"no_image.png"];
                    });
                    
                    if (imgData) {
                        BOOL isImageCached = [HelperClass cacheImageWithData:imgData withName:imageName];
                        
                        if (isImageCached) NSLog(@"%@ Promotion Image Cached", imageName);
                        else NSLog(@"%@ Image Not Cached", imageName);
                    }
                    
                    isLoading = NO;
                }];
            }
        }];
    }
    else {
        [activity stopAnimating];
        imgView.image = [UIImage imageNamed:@"no_image.png"];
    }
}

- (void)loadCategory:(Product_Category *)category {
    
    _productCategory = category;
    
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.layer.borderWidth = 1.0f;
    imgView.layer.borderColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:1.0].CGColor;
    imgView.layer.cornerRadius = 5;//imgView.frame.size.width / 2;
    imgView.clipsToBounds = YES;
    
    label.text = category.name;
    
    [activity setHidesWhenStopped:YES];
    [activity setHidden:NO];
    [activity startAnimating];
    
    NSString *imageURL = category.image_url;
    NSArray *urlSplits = [imageURL componentsSeparatedByString:@"/"];
    
    //NSLog(@"Image Name : %@", [urlSplits lastObject]);
    
    NSString *imageName = [urlSplits lastObject];
    
    if (imageURL) {
        [HelperClass getCachedImageWithName:imageName withCompletionBlock:^(UIImage *img) {
            if (img) {
                [activity stopAnimating];
                imgView.image = img;
                //NSLog(@"Cached Image Loaded for %@", imageName);
            }
            else if (!isLoading) {
                isLoading = YES;
                
                [HelperClass loadImageWithURL:imageURL andCompletionBlock:^(UIImage *img, NSData *imgData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [activity stopAnimating];
                        if (img) imgView.image = img;
                        else imgView.image = [UIImage imageNamed:@"no_image.png"];
                    });
                    
                    if (imgData) {
                        BOOL isImageCached = [HelperClass cacheImageWithData:imgData withName:imageName];
                        
                        if (isImageCached) NSLog(@"%@ Promotion Image Cached", imageName);
                        else NSLog(@"%@ Image Not Cached", imageName);
                    }
                    
                    isLoading = NO;
                }];
            }
        }];
    }
    else {
        [activity stopAnimating];
        imgView.image = [UIImage imageNamed:@"no_image.png"];
    }
}

#pragma mark - Btn Action

- (IBAction)btnClicked:(id)sender {
    
    if (_productCategory) {
        [_callingControllerInstance categoryBtnClick:_productCategory];
    }
    else if (_islatestPromotionItem) {
        [_callingControllerInstance promotionLatestItemBtnActionWithObj:_lateArrPromotion];
    }
}

@end
