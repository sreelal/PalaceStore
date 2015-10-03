//
//  PSCheckoutBaseViewController.h
//  PalaceStore
//
//  Created by Sreelal H on 17/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSAddressListView.h"
#import "LeftMenuViewController.h"

@interface PSCheckoutBaseViewController : UIViewController {
    IBOutlet UIView *contView;
}

@property (assign, nonatomic) BOOL isLeftMenu;
@property (assign, nonatomic) LeftMenuViewController *leftMenuVC;

@end
