//
//  ProfileCell.m
//  PalaceStore
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];


}

- (IBAction)deleteAction:(id)sender {
        NSLog(@"%s",__func__);
}

- (IBAction)purchaseAction:(id)sender {
        NSLog(@"%s",__func__);
}

- (IBAction)editAction:(id)sender {
        NSLog(@"%s",__func__);
}
@end
