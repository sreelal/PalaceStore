//
//  PSRegistrationView.h
//  PalaceStore
//
//  Created by Sreelash S on 26/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSRegistrationView : UIView <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    
    IBOutlet UITableView *regTableView;
    IBOutlet NSLayoutConstraint *tableViewVerticalSpacing;
}

@end
