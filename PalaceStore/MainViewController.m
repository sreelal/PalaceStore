//
//  ViewController.m
//  PalaceStore
//
//  Created by Sreelal  Hamsavahanan on 02/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import "PSHomeViewController.h"

@interface MainViewController ()<LeftMenuViewControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)awakeFromNib
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeNavigationVC"];
    
    LeftMenuViewController *_leftmenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"leftMenuVC"];
    _leftmenuVC.delegate = self;
    self.leftMenuViewController = _leftmenuVC;
    
    self.scaleContentView = NO;
    self.scaleMenuView = NO;
    self.fadeMenuView = YES;
    self.parallaxEnabled = NO;
}

#pragma mark - Left Menu Delegate

- (void)didSelectMenuItemAtIndex:(NSInteger)indexValue{
    
    
}

@end
