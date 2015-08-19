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

@interface LeftMenuViewController : UIViewController

@property (nonatomic,assign) id <LeftMenuViewControllerDelegate> delegate;
@end
