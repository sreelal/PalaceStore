//
//  PSAddressListView.h
//  PalaceStore
//
//  Created by Anamika on 9/24/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PSAddressListViewDelegate <NSObject>

- (void)addressListViewNextAction;
- (void)addAddress;

@end

@interface PSAddressListView : UIView <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet NSLayoutConstraint *tableViewVerticalSpacing;
    IBOutlet UITableView *addressTableView;
}

@property(nonatomic,assign)id <PSAddressListViewDelegate> addressListViewDelegate;

- (void)loadAddresses;

@end
