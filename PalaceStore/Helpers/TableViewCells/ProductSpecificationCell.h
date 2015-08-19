//
//  ProductSpecificationCell.h
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 07/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Products.h"

@interface ProductSpecificationCell : UITableViewCell

- (void)loadSpecifications:(Products*)productDetails;
@end
