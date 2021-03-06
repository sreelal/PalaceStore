//
//  MyCartCell.m
//  PalaceStore
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "MyCartCell.h"
#import "DatabaseHandler.h"
#import "UIViewController+Refresh.h"

@interface MyCartCell () {
    BOOL isLoading;
}

@end

@implementation MyCartCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

- (void)loadProductImage:(NSString*)productURL {
    
    if (_cart == nil) _btnDelete.hidden = YES;
    else _btnDelete.hidden = NO;
    
    NSArray *urlSplits = [productURL componentsSeparatedByString:@"/"];
    NSString *imageName = [urlSplits lastObject];
    
    [_activity setHidesWhenStopped:YES];
    [_activity setHidden:NO];
    [_activity startAnimating];
    
    if (productURL) {
        [HelperClass getCachedImageWithName:imageName withCompletionBlock:^(UIImage *img) {
            if (img) {
                [_activity stopAnimating];
                _cartImage.image = img;
            }
            else if (!isLoading) {
                isLoading = YES;
                
                [HelperClass loadImageWithURL:productURL andCompletionBlock:^(UIImage *img, NSData *imgData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_activity stopAnimating];
                        if (img) _cartImage.image = img;
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
        _cartImage.image = [UIImage imageNamed:@"no_image.png"];
    }
}

- (IBAction)removeAction:(id)sender {
    
    if (_cart) {
        [_callingController removeCartItemAtIndex:_cartItemIndex];
    }
}


- (IBAction)addSelectedForDeletion:(id)sender {
    
    if (_cart) {
        [_callingController updateDeleteCartList:_cartItemIndex];
    }
}

- (IBAction)placeOrderAction:(id)sender
{
        NSLog(@"%s",__func__);
}

- (void)setSelectedForDeletion:(BOOL)bStatus{
    
    [_btnSelect setSelected:bStatus];
}
@end
