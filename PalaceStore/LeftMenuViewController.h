//
//  LeftMenuViewController.h
//  Frankies
//
//  Created by Sreelal H on 13/06/15.
//  Copyright (c) 2015 Sreelal H. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LeftMenuViewControllerDelegate <NSObject>

- (void)didSelectMenuItemAtIndex:(NSInteger)indexValue;

@end

@interface LeftMenuViewController : UIViewController {
    IBOutlet NSLayoutConstraint *trailingPin;
    IBOutlet UIButton *loginBtn;
}

@property (nonatomic,assign) id <LeftMenuViewControllerDelegate> delegate;

- (void)changeLoginTitle;

@end
