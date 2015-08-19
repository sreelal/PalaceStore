//
//  ProductDescriptionCell.h
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 06/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product_Details.h"

@interface ProductDescriptionCell : UITableViewCell

- (void)loadProductDescription:(Product_Details*)productDetails;
@end
