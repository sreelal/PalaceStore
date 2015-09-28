//
//  PSAddressCell.h
//  PalaceStore
//
//  Created by Anamika on 9/24/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblFN;
@property (weak, nonatomic) IBOutlet UILabel *lblLN;

@property (weak, nonatomic) IBOutlet UITextView *txtAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblPostCode;

@end
