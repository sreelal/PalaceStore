//
//  SubCategoryCollectionViewCell.m
//  PalaceStore
//
//  Created by Sreelash S on 01/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "SubCategoryCollectionViewCell.h"
#import "PSSubCategoryViewController.h"

@interface SubCategoryCollectionViewCell () {
    BOOL isLoading;
    Product_Category *sub_Category;
}

@end

@implementation SubCategoryCollectionViewCell

- (void)initCell {
    
    _bgView.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.2];
    [HelperClass addBorderForView:_bgView withHexCodeg:COLOR_HEX_LIGHT_GRAY andAlpha:0.5];
    
    _activity.hidesWhenStopped = YES;
}

- (void)loadSubCategory:(Product_Category *)subCategory {
    
    sub_Category = subCategory;
    [_activity setHidesWhenStopped:YES];
    [_activity setHidden:NO];
    [_activity startAnimating];

    
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

#pragma mark - Btn Action

- (IBAction)btnClicked:(id)sender {
    
    if (sub_Category) {
        [_callingControllerInstance categoryBtnClick:sub_Category];
    }
}

@end
