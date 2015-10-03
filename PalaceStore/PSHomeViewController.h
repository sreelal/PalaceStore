//
//  PSHomeViewController.h
//  PalaceStore
//
//  Created by Sreelal  Hamsavahanan on 02/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DatabaseManager.h"
#import "DatabaseHandler.h"

#import "Banner_Images.h"
#import "LatestArrivals_Promotions.h"
#import "Product_Category.h"
#import "AppDelegate.h"

@interface PSHomeViewController : UIViewController

- (void)categoryBtnClick:(Product_Category *)category;
- (void)promotionLatestItemBtnActionWithObj:(LatestArrivals_Promotions *)item;

@end
