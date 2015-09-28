//
//  CartTableViewController.h
//  PalaceStore
//
//  Created by Teja Swaroop on 21/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UITableView *cartTableView;
    IBOutlet UILabel *total;
    
    IBOutlet NSLayoutConstraint *topConstraint;
}

@property(nonatomic, strong)NSArray * cartArray;
@property (nonatomic, assign) BOOL isFromMenu;
@property (nonatomic, assign) BOOL isFromMenuAndInnerView;
@property (nonatomic, assign) BOOL isRerendering;
@end
