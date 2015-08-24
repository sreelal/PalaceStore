//
//  ProfileCell.h
//  PalaceStore
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profile;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

- (IBAction)deleteAction:(id)sender;
- (IBAction)purchaseAction:(id)sender;
- (IBAction)editAction:(id)sender;

@end
