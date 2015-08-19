//
//  ProductImageCell.m
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 06/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "ProductImageCell.h"
#import "HelperClass.h"

@interface ProductImageCell (){
    BOOL isLoading;
}
@property (weak, nonatomic) IBOutlet UIImageView *mainImageContainer;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end

@implementation ProductImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadProductImage:(NSString*)productURL{
    
    NSArray *urlSplits = [productURL componentsSeparatedByString:@"/"];
    NSString *imageName = [urlSplits lastObject];
    
    if (productURL) {
        [HelperClass getCachedImageWithName:imageName withCompletionBlock:^(UIImage *img) {
            if (img) {
                [_activity stopAnimating];
                _mainImageContainer.image = img;
            }
            else if (!isLoading) {
                isLoading = YES;
                
                [HelperClass loadImageWithURL:productURL andCompletionBlock:^(UIImage *img, NSData *imgData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_activity stopAnimating];
                        if (img) _mainImageContainer.image = img;
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
        _mainImageContainer.image = [UIImage imageNamed:@"no_image.png"];
    }
}

@end
