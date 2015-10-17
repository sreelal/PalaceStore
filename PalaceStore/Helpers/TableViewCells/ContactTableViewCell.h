//
//  ContactTableViewCell.h
//  PalaceStore
//
//  Created by Sreelash Sasikumar on 10/17/15.
//  Copyright © 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UITextField *txtEmail;
@property (nonatomic, weak) IBOutlet UITextField *txtFirstName;
@property (nonatomic, weak) IBOutlet UITextField *txtLastName;
@property (nonatomic, weak) IBOutlet UITextView  *txtEnquiry;

@end
