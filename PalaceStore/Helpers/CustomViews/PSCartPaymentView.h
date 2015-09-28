//
//  PSCartPaymentview.h
//  PalaceStore
//
//  Created by Sreelal H on 17/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Refresh.h"

@protocol PSPaymentViewDelegate <NSObject>

- (void)paymentNextAction;

@end

@interface PSCartPaymentView : UIView <UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UITableView *payOptionsTableView;
}

@property(nonatomic,assign)id <PSPaymentViewDelegate> paymentViewDelegate;

- (IBAction)didSelectPaymentOption:(id)sender;

@end
