//
//  PSContactUsViewController.m
//  PalaceStore
//
//  Created by Sreelash Sasikumar on 10/17/15.
//  Copyright © 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSContactUsViewController.h"
#import "AppDelegate.h"
#import "ContactTableViewCell.h"

@interface PSContactUsViewController () <UITextFieldDelegate, UITextViewDelegate, InputAccessoryDelegate> {
    UITextView *enquiryTextView;
}

@property (nonatomic, strong) NSMutableDictionary *dataDict;

@end

@implementation PSContactUsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dataDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"", KEY_NAME, @"", KEY_EMAIL, @"", KEY_ENQUIRY, @"", KEY_FIRST_NAME, @"", KEY_LAST_NAME, nil];
    
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (BOOL)validateData {
    
    NSString *firstName = _dataDict[KEY_FIRST_NAME];
    NSString *lastName = _dataDict[KEY_LAST_NAME];
    NSString *email = _dataDict[KEY_EMAIL];
    NSString *name = _dataDict[KEY_NAME];
    NSString *enquiry = _dataDict[KEY_ENQUIRY];
    
    if ([[firstName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || firstName == nil) {
        [HelperClass showAlertWithMessage:@"First Name is missing!"];
        return NO;
    }
    else if ([[lastName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || lastName == nil) {
        [HelperClass showAlertWithMessage:@"Last Name is missing!"];
        return NO;
    }
    else if ([[email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || email == nil || ![self validateEmailWithString:email]) {
        [HelperClass showAlertWithMessage:@"Invalid Email ID!"];
        return NO;
    }
    else if ([[enquiry stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || enquiry == nil) {
        [HelperClass showAlertWithMessage:@"Enquiry is missing!"];
        return NO;
    }
    
    name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    [_dataDict setValue:name forKey:KEY_NAME];
    
    return YES;
}

- (BOOL)validateEmailWithString:(NSString*)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)setupView {
    
    self.navigationItem.titleView = [[AppDelegate instance] getNavigationBarImageView];
    
    self.navigationItem.leftBarButtonItem = [HelperClass getMenuButtonItemWithTarget:self andAction:@selector(leftAction:)];
}

#pragma mark - Button Actions

- (IBAction)submitEnquiryAction:(id)sender {
    
    if (![self validateData]) {
        return;
    }
    
    [[AppDelegate instance] showBusyView:@"Sending Enquiry..."];

    [WebHandler sendEnquiryWihDict:_dataDict withCallback:^(id object, NSError *error) {
        NSDictionary *enquiryRespDict = (NSDictionary *)object;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate instance] hideBusyView];
        });
        
        /*if ([enquiryRespDict[@"result"][@"status"] isEqualToString:@"success"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate instance] hideBusyView];
                [HelperClass showAlertWithMessage:@"Registration Successfull!"];
                
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
        else {
            NSString *errorMessage = signUpRespDict[@"result"][@"message"];
            
            if (!errorMessage)
                errorMessage = @"Registration Failed!";
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate instance] hideBusyView];
                [UtilClass showAlertWithMessage:errorMessage];
            });
        }*/
    }];
}

-(IBAction)leftAction:(id)sender {
    
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark - Table View Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 240;
    
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

#pragma mark - Table View Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"ContactCell";
    
    ContactTableViewCell *cell = (ContactTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ContactTableViewCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
        cell.txtEmail.delegate           = self;
        cell.txtFirstName.delegate       = self;
        cell.txtLastName.delegate        = self;
        cell.txtEnquiry.delegate         = self;
        
        cell.txtEmail.text               = _dataDict[KEY_EMAIL];
        cell.txtFirstName.text           = _dataDict[KEY_FIRST_NAME];
        cell.txtLastName.text            = _dataDict[KEY_LAST_NAME];
        cell.txtEnquiry.text             = _dataDict[KEY_ENQUIRY];
        
        InputAccessoryBar *inputAccessoryView = [[AppDelegate instance] getInputAccesory];
        inputAccessoryView.delegate = self;
        
        cell.txtEnquiry.inputAccessoryView = inputAccessoryView;
        enquiryTextView = cell.txtEnquiry;
        [HelperClass addBorderForView:cell.txtEnquiry withHexCodeg:COLOR_HEX_LIGHT_GRAY andAlpha:1.0];
    }
    
    return cell;
}

#pragma mark - Textfield Delegates

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    switch (textField.tag) {
        case 0:
            [_dataDict setValue:textField.text forKey:KEY_EMAIL];
            break;
            
        case 1:
            [_dataDict setValue:textField.text forKey:KEY_FIRST_NAME];
            break;
            
        case 2:
            [_dataDict setValue:textField.text forKey:KEY_LAST_NAME];
            break;
            
        case 3:
            [_dataDict setValue:textField.text forKey:KEY_ENQUIRY];
            break;
            
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Input Accessory Delegate

- (void)doneAction {
    
    [_dataDict setValue:enquiryTextView.text forKey:KEY_ENQUIRY];
    
    [enquiryTextView resignFirstResponder];
}

- (void)cancelAction {
    
    [enquiryTextView resignFirstResponder];
    //[activeTextField resignFirstResponder];
}

@end
