//
//  PSProductDetailsViewController.h
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 06/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Products.h"
#import "LatestArrivals_Promotions.h"
#import "AppDelegate.h"

@interface PSProductDetailsViewController : UIViewController

@property (nonatomic,strong)LatestArrivals_Promotions *latestArrivalPromotion;
@property (nonatomic,strong)Products *selectedProduct;
@property (nonatomic, assign) BOOL isFromMenu;

@end
