//
//  PSCartAddressView.m
//  PalaceStore
//
//  Created by Sreelal H on 17/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSCartAddressView.h"
#import "PSRegistrationCell.h"
#import "AppDelegate.h"
#import "WebHandler.h"
#import "DatabaseHandler.h"

#define KeyBoardHeight_iPhone    216
#define verticalSpacing_constant 13
#define verticalSpacing_offset   68

@interface PSCartAddressView ()<InputAccessoryDelegate> {
    NSArray *fields;
    NSMutableDictionary *dataDict;
    NSDictionary *addressDict;
    
    UITextField *activeTextField;
    NSIndexPath *activeIndexPath;
}
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;

@end
@implementation PSCartAddressView

- (void)awakeFromNib {
    
}

- (void)initView {
    
    dataDict = [[NSMutableDictionary alloc] init];
    
    fields = [[NSArray alloc] initWithObjects:@"First Name", @"Last Name", @"Company", @"Address", @"City", @"Postal Code", nil];
    
    addressTableView.scrollEnabled = NO;
    
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
    
    if (indexPath.row == fields.count - 1) {
        [cell.txtField setKeyboardType:UIKeyboardTypeNumberPad];
    }
    
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
    
    return cell;
}

#pragma mark - Private Methods

- (BOOL)validateData {
    
    NSString *fnKey = [NSString stringWithFormat:@"%d", 0];
    NSString *lnKey = [NSString stringWithFormat:@"%d", 1];
    NSString *comKey = [NSString stringWithFormat:@"%d", 2];
    NSString *add1Key = [NSString stringWithFormat:@"%d", 3];
    NSString *cityKey = [NSString stringWithFormat:@"%d", 4];
    NSString *postKey = [NSString stringWithFormat:@"%d", 5];
    
    NSString *firstName = dataDict[fnKey];
    NSString *lastName = dataDict[lnKey];
    NSString *company = dataDict[comKey];
    NSString *address1 = dataDict[add1Key];
    NSString *city = dataDict[cityKey];
    NSString *postCode = dataDict[postKey];
    
    addressDict = nil;
    addressDict = [NSDictionary dictionaryWithObjectsAndKeys:firstName, @"firstname", lastName, @"lastname", company, @"company", address1, @"address_1", city, @"city", postCode, @"postcode", [HelperClass getTimeStamp], @"address_id", nil];
    
    if ([[firstName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || firstName == nil) {
        [self showAlertWithMessage:@"First Name is missing!"];
        return NO;
    }
    else if ([[lastName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || lastName == nil) {
        [self showAlertWithMessage:@"Last Name is missing!"];
        return NO;
    }
    else if ([[company stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || company == nil) {
        [self showAlertWithMessage:@"Company is missing!"];
        return NO;
    }
    else if ([[address1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || address1 == nil) {
        [self showAlertWithMessage:@"Address 1 is missing!"];
        return NO;
    }
    else if ([[city stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || city == nil) {
        [self showAlertWithMessage:@"City is missing!"];
        return NO;
    }
    else if ([[postCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || postCode == nil) {
        [self showAlertWithMessage:@"Post code is missing!"];
        return NO;
    }
    
    return YES;
}

- (void)showAlertWithMessage:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Palace Stores" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

#pragma mark - Button Actions

- (IBAction)didSelectGender:(id)sender {
    
    _maleBtn.selected = NO;
    _femaleBtn.selected=NO;
    UIButton *_selectedBtn = (UIButton*)sender;
    _selectedBtn.selected = YES;
}

- (IBAction)didSelectnext:(id)sender {
    
    if (![self validateData]) {
        return;
    }
    
    [[AppDelegate instance] showBusyView:@"Adding Address..."];
    
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //NSString *userId = [userDefaults valueForKey:KEY_USER_INFO_CUSTOMER_ID];
    
    [DatabaseHandler addToAddressWithDict:addressDict];
    
    [[AppDelegate instance] hideBusyView];
    
    if (_cartAddressDelegate&&([_cartAddressDelegate respondsToSelector:@selector(didSuccessAddressOption)])) {
        
        [_cartAddressDelegate didSuccessAddressOption];
    }

    
//    [WebHandler addAddressWihDict:addressDict withUserId:userId withCallback:^(id object, NSError *error) {
//        
//    }];
    
//    [WebHandler signUpWihDict:signupDict withCallback:^(id object, NSError *error) {
//        NSDictionary *signUpRespDict = (NSDictionary *)object;
//        
//        if ([signUpRespDict[@"status"] isEqualToString:@"OK"] && signUpRespDict[@"user"] != nil) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [[AppDelegate instance] hideBusyView];
//                
//                [self showAlertWithMessage:@"Registration Successfull!"];
//                
//                if (_signupDelegate != nil && [_signupDelegate respondsToSelector:@selector(didSuccessSignUp)]) {
//                    [_signupDelegate didSuccessSignUp];
//                }
//            });
//            
//            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIKeyboardWillShowNotification" object:nil];
//            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIKeyboardWillHideNotification" object:nil];
//        }
//        else
//            [self showAlertWithMessage:@"Registration Failed!"];
//    }];
    
}

- (IBAction)didSelectBillingSameAddress:(id)sender {
    UIButton *_selectedBtn = (UIButton*)sender;
    _selectedBtn.selected = !_selectedBtn.selected;

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
    
    addressTableView.scrollEnabled = YES;
    
    CGPoint txtFldPosition = [activeTextField convertPoint:CGPointZero toView:addressTableView];
    NSIndexPath *indexPath = [addressTableView indexPathForRowAtPoint:txtFldPosition];
    
    tableViewVerticalSpacing.constant = 220;
    [self setNeedsUpdateConstraints];
    
    [addressTableView scrollToRowAtIndexPath:indexPath
                        atScrollPosition:UITableViewScrollPositionMiddle
                                animated:YES];
}

- (void) keyboardWillHide:(NSNotification *)note {
    
    addressTableView.scrollEnabled = NO;
    
    tableViewVerticalSpacing.constant = 13;
    [self setNeedsUpdateConstraints];
}

@end
