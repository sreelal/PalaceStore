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
#import "WebHandler.h"

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
    NSDictionary *signupDict;
    
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
    
    switch (indexPath.row) {
        case psTelephone:{
            [cell.txtField setKeyboardType:UIKeyboardTypeNumberPad];
        }
        break;
            
        case psPassword:{
            cell.txtField.secureTextEntry = YES;
        }
        break;
            
        case psConfirmPassword:{
            cell.txtField.secureTextEntry = YES;
        }
        break;
            
        default:
        break;
    }
    
    NSString *dictKey = [NSString stringWithFormat:@"%ld", indexPath.row];
    NSString *txtValue = dataDict[dictKey];
    
    cell.txtField.text = txtValue;
    
    return cell;
}

#pragma mark - Private Methods

- (BOOL)validateData {
    
    NSString *fnKey = [NSString stringWithFormat:@"%d", psFirstName];
    NSString *lnKey = [NSString stringWithFormat:@"%d", psLastName];
    NSString *emKey = [NSString stringWithFormat:@"%d", psEmail];
    NSString *phKey = [NSString stringWithFormat:@"%d", psTelephone];
    NSString *pwKey = [NSString stringWithFormat:@"%d", psPassword];
    NSString *cpKey = [NSString stringWithFormat:@"%d", psConfirmPassword];
    
    NSString *firstName = dataDict[fnKey];
    NSString *lastName = dataDict[lnKey];
    NSString *email = dataDict[emKey];
    NSString *telephone = dataDict[phKey];
    NSString *password = dataDict[pwKey];
    NSString *confPassword = dataDict[cpKey];
    
    signupDict = nil;
    signupDict = [NSDictionary dictionaryWithObjectsAndKeys:firstName, @"firstname", lastName, @"lastname", email, @"email", telephone, @"telephone", password, @"password", nil];
    
    if ([[firstName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || firstName == nil) {
        [self showAlertWithMessage:@"First Name is missing!"];
        return NO;
    }
    else if ([[lastName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || lastName == nil) {
        [self showAlertWithMessage:@"Last Name is missing!"];
        return NO;
    }
    else if ([[email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || email == nil || ![self validateEmailWithString:email]) {
        [self showAlertWithMessage:@"Invalid Email ID!"];
        return NO;
    }
    else if ([[telephone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || telephone == nil) {
        [self showAlertWithMessage:@"Telephone Number is missing!"];
        return NO;
    }
    else if (![[password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:[confPassword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] || password == nil || confPassword == nil) {
        [self showAlertWithMessage:@"Password & Confirm Password are not matching!"];
        return NO;
    }
    
    return YES;
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)showAlertWithMessage:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Palace Stores" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

#pragma mark - Button Actions

- (IBAction)signUpAction:(id)sender {
    
    if (![self validateData]) {
        return;
    }
    
    [[AppDelegate instance] showBusyView:@"Signing up..."];
    
    [WebHandler signUpWihDict:signupDict withCallback:^(id object, NSError *error) {
        NSDictionary *signUpRespDict = (NSDictionary *)object;
        
        if ([signUpRespDict[@"status"] isEqualToString:@"OK"] && signUpRespDict[@"user"] != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate instance] hideBusyView];
                
                [self showAlertWithMessage:@"Registration Successfull!"];
                
                if (_signupDelegate != nil && [_signupDelegate respondsToSelector:@selector(didSuccessSignUp)]) {
                    [_signupDelegate didSuccessSignUp];
                }
            });
            
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIKeyboardWillShowNotification" object:nil];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIKeyboardWillHideNotification" object:nil];
        }
        else
            [self showAlertWithMessage:@"Registration Failed!"];
    }];
    
    
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
    
    [self signUpAction:nil];
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
