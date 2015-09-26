//
//  PSAddressListView.h
//  PalaceStore
//
//  Created by Anamika on 9/24/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSAddressListView : UIView <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *addressTableView;
}

@end
