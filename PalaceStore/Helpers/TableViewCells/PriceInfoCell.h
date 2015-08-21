//
//  PriceInfoCell.h
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 06/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSStarRatingView.h"
#import "Products.h"

@interface PriceInfoCell : UITableViewCell

@property(nonatomic, strong) Products * currentProductObj
;
- (void)loadProductInformation:(Products*)productInfo;
@end
