//
//  MyCartCell.m
//  PalaceStore
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "MyCartCell.h"

@implementation MyCartCell

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (IBAction)removeAction:(id)sender {
    
    NSLog(@"%s",__func__);
}

- (IBAction)placeOrderAction:(id)sender
{
        NSLog(@"%s",__func__);
}
@end
