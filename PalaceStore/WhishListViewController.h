//
//  WhishListViewController.h
//  PalaceStore
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhishListViewController : UITableViewController

@property (nonatomic, strong) NSArray * whishListArray;
@property (nonatomic, assign) BOOL isFromMenu;

@end
