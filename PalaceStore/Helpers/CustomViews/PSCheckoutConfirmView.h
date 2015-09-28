//
//  PSCheckoutConfirmView.h
//  PalaceStore
//
//  Created by Sreelash S on 28/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCartCell.h"

@protocol PSConfirmViewDelegate <NSObject>

- (void)didSuccessCheckout;

@end

@interface PSCheckoutConfirmView : UIView {
    IBOutlet UITableView *orderConfirmTableView;
}

@property(nonatomic,assign)id <PSConfirmViewDelegate> confirmViewDelegate;

- (void)initView;
- (IBAction)orderViewEditAction:(id)sender;

@end
