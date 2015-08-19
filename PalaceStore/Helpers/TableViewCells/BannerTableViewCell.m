//
//  BannerTableViewCell.m
//  PalaceStore
//
//  Created by Sreelal H on 04/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "BannerTableViewCell.h"
#import "AOScrollerView.h"
#import "HelperClass.h"


@interface BannerTableViewCell () {
    BOOL isPromotionImgLoading;
    BOOL isLatestArrivalImgLoading;
}
@end
@implementation BannerTableViewCell

- (void)awakeFromNib {
    
    [HelperClass addBorderForView:self.OfferBgView withHexCodeg:COLOR_HEX_LIGHT_GRAY andAlpha:0.5];
    [HelperClass addBorderForView:self.latestBgView withHexCodeg:COLOR_HEX_LIGHT_GRAY andAlpha:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadBannerImagesWith:(NSMutableArray*)bannerImages{
    
    if (bannerImages.count) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *removingView = [self viewWithTag:222];
            [removingView removeFromSuperview];
            
            AOScrollerView *aSV = [[AOScrollerView alloc]initWithNameArr:bannerImages
                                                                titleArr:nil
                                                                  height:_bannerContainer.frame.size.height
                                                                   width: _bannerContainer.frame.size.width];
           
            aSV.frame = CGRectMake(0, 0, _bannerContainer.frame.size.width, 120);
            aSV.tag = 222;
            
            [_bannerContainer addSubview:aSV];
            [_bannerActivity stopAnimating];
        });
    }
}

- (void)loadPromotion:(LatestArrivals_Promotions *)promotion {
    
    self.OfferLabel.text = promotion.name;
    
    [self.offerActivity setHidesWhenStopped:YES];
    [self.offerActivity setHidden:NO];
    [self.offerActivity startAnimating];
    
    NSString *imageURL = promotion.thumb_image_url;
    NSArray *urlSplits = [imageURL componentsSeparatedByString:@"/"];
    
    //NSLog(@"Image Name : %@", [urlSplits lastObject]);
    
    NSString *imageName = [urlSplits lastObject];
    
    if (imageURL) {
        [HelperClass getCachedImageWithName:imageName withCompletionBlock:^(UIImage *img) {
            if (img) {
                [self.offerActivity stopAnimating];
                self.OfferImgView.image = img;
                //NSLog(@"Cached Image Loaded for %@", imageName);
            }
            else if (!isPromotionImgLoading) {
                isPromotionImgLoading = YES;
                
                [HelperClass loadImageWithURL:imageURL andCompletionBlock:^(UIImage *img, NSData *imgData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.offerActivity stopAnimating];
                        if (img) self.OfferImgView.image = img;
                    });
                    
                    if (imgData) {
                        BOOL isImageCached = [HelperClass cacheImageWithData:imgData withName:imageName];
                        
                        if (isImageCached) NSLog(@"%@ Promotion Image Cached", imageName);
                        else NSLog(@"%@ Image Not Cached", imageName);
                    }
                    
                    isPromotionImgLoading = NO;
                }];
            }
        }];
    }
    else {
        self.OfferImgView.image = [UIImage imageNamed:@"no_image.png"];
    }
}

- (void)loadLatestArrival:(LatestArrivals_Promotions *)latestArrival {
    
    self.latestLabel.text = latestArrival.name;
    
    [self.latestActivity setHidesWhenStopped:YES];
    [self.latestActivity setHidden:NO];
    [self.latestActivity startAnimating];
    
    NSString *imageURL = latestArrival.thumb_image_url;
    NSArray *urlSplits = [imageURL componentsSeparatedByString:@"/"];
    
    //NSLog(@"Image Name : %@", [urlSplits lastObject]);
    
    NSString *imageName = [urlSplits lastObject];
    
    if (imageURL) {
        [HelperClass getCachedImageWithName:imageName withCompletionBlock:^(UIImage *img) {
            if (img) {
                [self.latestActivity stopAnimating];
                self.latestImgView.image = img;
                //NSLog(@"Cached Image Loaded for %@", imageName);
            }
            else if (!isLatestArrivalImgLoading) {
                isLatestArrivalImgLoading = YES;
                
                [HelperClass loadImageWithURL:imageURL andCompletionBlock:^(UIImage *img, NSData *imgData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.latestActivity stopAnimating];
                        if (img) self.latestImgView.image = img;
                    });
                    
                    if (imgData) {
                        BOOL isImageCached = [HelperClass cacheImageWithData:imgData withName:imageName];
                        
                        if (isImageCached) NSLog(@"%@ Latest Image Cached", imageName);
                        else NSLog(@"%@ Image Not Cached", imageName);
                    }
                    
                    isLatestArrivalImgLoading = NO;
                }];
            }
        }];
    }
    else {
        self.latestImgView.image = [UIImage imageNamed:@"no_image.png"];
    }
}

@end
