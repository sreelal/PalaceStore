//
//  PSCartLoginView.h
//  PalaceStore
//
//  Created by Sreelal H on 17/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PSCartLoginViewDelegate <NSObject>

- (void)didSuccessLoginOption;
- (void)signupClicked;

@end

@interface PSCartLoginView : UIView <UITextFieldDelegate> {
    IBOutlet UITextField *txtUserName;
    IBOutlet UITextField *txtPwd;
}

@property(nonatomic,assign)id <PSCartLoginViewDelegate> loginDelegate;

@end
