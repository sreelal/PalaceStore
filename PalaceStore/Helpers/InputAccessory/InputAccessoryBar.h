//
//  SFInputAccessoryBar.h
//  Samsfirma
//
//  Created by Sreelash S on 26/04/15.
//  Copyright (c) 2015 Sreelal H. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputAccessoryDelegate <NSObject>
@optional
- (void)doneAction;
- (void)cancelAction;

@end

@interface InputAccessoryBar : UIView {
    IBOutlet UIButton *cancelBtn;
    IBOutlet UIButton *doneBtn;
}

@property (nonatomic, weak) id <InputAccessoryDelegate> delegate;

@end
