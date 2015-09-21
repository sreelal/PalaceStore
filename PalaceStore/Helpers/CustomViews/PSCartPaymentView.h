//
//  PSCartPaymentview.h
//  PalaceStore
//
//  Created by Sreelal H on 17/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Refresh.h"

@interface PSCartPaymentView : UIView <UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UITableView *payOptionsTableView;
}

- (IBAction)didSelectPaymentOption:(id)sender;

@end
