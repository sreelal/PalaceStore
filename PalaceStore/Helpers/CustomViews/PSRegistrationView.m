//
//  PSRegistrationView.m
//  PalaceStore
//
//  Created by Sreelash S on 26/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSRegistrationView.h"
#import "PSRegistrationCell.h"
#import "AppDelegate.h"

#define KeyBoardHeight_iPhone    216
#define verticalSpacing_constant 13
#define verticalSpacing_offset   68

typedef enum {
    psFirstName = 0,
    psLastName,
    psEmail,
    psTelephone,
    psPassword,
    psConfirmPassword
}field;

@interface PSRegistrationView ()<InputAccessoryDelegate> {
    NSArray *fields;
    NSMutableDictionary *dataDict;
    
    UITextField *activeTextField;
    NSIndexPath *activeIndexPath;
}

@end

@implementation PSRegistrationView

- (void)awakeFromNib {
    
    dataDict = [[NSMutableDictionary alloc] init];
    
    fields = [[NSArray alloc] initWithObjects:@"First Name", @"Last Name", @"Email", @"Telephone", @"Password", @"Confirm Password", nil];
    
    regTableView.scrollEnabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardDidShowNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:@"UIKeyboardWillHideNotification"
                                               object:nil];
}

#pragma mark - Table View Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return fields.count;
}

#pragma mark - Table View Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PSRegistrationCell *cell = (PSRegistrationCell*)[tableView dequeueReusableCellWithIdentifier:@"psRegistrationCell"];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PSRegistrationCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    InputAccessoryBar *inputAccessoryView = [[AppDelegate instance] getInputAccesory];
    inputAccessoryView.delegate = self;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.txtField.placeholder = fields[indexPath.row];
    cell.txtField.delegate = self;
    cell.txtField.tag = indexPath.row;
    cell.txtField.inputAccessoryView = inputAccessoryView;
    [cell.txtField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [cell.txtField setSpellCheckingType:UITextSpellCheckingTypeYes];
    
    NSString *dictKey = [NSString stringWithFormat:@"%ld", indexPath.row];
    NSString *txtValue = dataDict[dictKey];
    
    cell.txtField.text = txtValue;
    
    switch (indexPath.row) {
        case psFirstName:{
            
        }
        break;
            
        case psLastName:{
            
        }
        break;
            
        case psEmail:{
            
        }
        break;
            
        case psTelephone:{
            
        }
        break;
            
        case psPassword:{
            
        }
        break;
            
        case psConfirmPassword:{
            
        }
        break;
            
        default:
        break;
    }
    
    return cell;
}

#pragma mark - Buton Actions 

- (IBAction)nextAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIKeyboardWillShowNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIKeyboardWillHideNotification" object:nil];
}

#pragma mark - TextField Delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSString *dictKey = [NSString stringWithFormat:@"%ld", (long)textField.tag];
    [dataDict setValue:textField.text forKey:dictKey];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Input Accessory Delegate

- (void)doneAction {
    
    [activeTextField resignFirstResponder];
}

- (void)cancelAction {
    
    [activeTextField resignFirstResponder];
}

#pragma mark - KeyBoard Notification

- (void) keyboardWillShow:(NSNotification *)note {
    
    regTableView.scrollEnabled = YES;
    
    CGPoint txtFldPosition = [activeTextField convertPoint:CGPointZero toView:regTableView];
    NSIndexPath *indexPath = [regTableView indexPathForRowAtPoint:txtFldPosition];
    
    tableViewVerticalSpacing.constant = 220;
    [self setNeedsUpdateConstraints];
    
    [regTableView scrollToRowAtIndexPath:indexPath
                        atScrollPosition:UITableViewScrollPositionMiddle
                                animated:YES];
}

- (void) keyboardWillHide:(NSNotification *)note {
    
    regTableView.scrollEnabled = NO;
    
    tableViewVerticalSpacing.constant = 13;
    [self setNeedsUpdateConstraints];
}

@end
