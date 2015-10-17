//
//  PSBranchesTableViewCell.h
//  PalaceStore
//
//  Created by Sreelal H on 17/10/15.
//  Copyright © 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSBranchesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;

@end
