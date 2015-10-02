//
//  PSCartLoginView.m
//  PalaceStore
//
//  Created by Sreelal H on 17/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSCartLoginView.h"
#import "WebHandler.h"
#import "AppDelegate.h"

@interface PSCartLoginView ()

@property (weak, nonatomic) IBOutlet UIButton *rememberPassword;

@end

@implementation PSCartLoginView

- (void)awakeFromNib{
    
    NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
    NSLog(@"USerDefaults : %@", [userDefalts dictionaryRepresentation]);
    NSLog(@"USerInfo : %@", [userDefalts objectForKey:KEY_USER_INFO]);
    
    BOOL isRememberMe = [userDefalts boolForKey:KEY_REMEMBER_ME];
    
    if (isRememberMe) {
        [_rememberPassword setSelected:YES];
        txtUserName.text = [userDefalts valueForKey:KEY_USER_NAME];
        txtPwd.text = [userDefalts valueForKey:KEY_PASSWORD];
    }
    
    //[_rememberPassword setBackgroundImage:[UIImage imageNamed:@"radio-normal.png"] forState:UIControlStateNormal];
}

#pragma mark - Private Methods

- (BOOL)validateData {
    
    NSString *userName = [txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwd = [txtPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([userName isEqualToString:@""] || userName == nil) {
        [self showAlertWithMessage:@"Enter Email ID!"];
        return NO;
    }
    else if ([pwd isEqualToString:@""] || pwd == nil) {
        [self showAlertWithMessage:@"Enter Password!"];
        return NO;
    }
    
    return YES;
}

- (void)showAlertWithMessage:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Palace Stores" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)saveUserInfoWithDict:(NSDictionary *)userDict {
    
    NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
    
    [userDefalts setValue:userDict[KEY_USER_INFO_ADDRESS_ID] forKey:KEY_USER_INFO_ADDRESS_ID];
    [userDefalts setValue:userDict[KEY_USER_INFO_FIRST_NAME] forKey:KEY_USER_INFO_FIRST_NAME];
    [userDefalts setValue:userDict[KEY_USER_INFO_LAST_NAME] forKey:KEY_USER_INFO_LAST_NAME];
    [userDefalts setValue:userDict[KEY_USER_INFO_TELE] forKey:KEY_USER_INFO_TELE];
    [userDefalts setValue:userDict[KEY_USER_INFO_CUSTOMER_ID] forKey:KEY_USER_INFO_CUSTOMER_ID];
    
    [userDefalts synchronize];
}

#pragma mark - Button Actions

- (IBAction)didSelectRemember:(id)sender {
    
    UIButton *selectedBtn = (UIButton*)sender;
    selectedBtn.selected = !selectedBtn.selected;
}

- (IBAction)didSelectLogin:(id)sender {
    
    if (![self validateData]) {
        return;
    }
    
    NSDictionary *loginDataDict = [NSDictionary dictionaryWithObjectsAndKeys:txtUserName.text, @"email", txtPwd.text, @"password", nil];
    
    [[AppDelegate instance] showBusyView:@"Signing In..."];
    
    [WebHandler loginWihDict:loginDataDict withCallback:^(id object, NSError *error) {
        
        NSDictionary *loginDict = (NSDictionary *)object;
        
        if ([loginDict[@"status"] isEqualToString:@"OK"] && loginDict[@"user"] != nil) {
            
            [self saveUserInfoWithDict:loginDict[@"user"]];
            
            NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
            
            if ([_rememberPassword isSelected]) {
                [userDefalts setValue:loginDataDict[@"email"] forKey:KEY_USER_NAME];
                [userDefalts setValue:loginDataDict[@"password"] forKey:KEY_PASSWORD];
                [userDefalts setBool:[NSNumber numberWithBool:1] forKey:KEY_REMEMBER_ME];
            }
            else {
                [userDefalts removeObjectForKey:KEY_USER_NAME];
                [userDefalts removeObjectForKey:KEY_PASSWORD];
                [userDefalts removeObjectForKey:KEY_REMEMBER_ME];
            }
            
            [userDefalts synchronize];
            
            NSLog(@"USerDefaults : %@", [userDefalts dictionaryRepresentation]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate instance] hideBusyView];
                
                if (_loginDelegate != nil && [_loginDelegate respondsToSelector:@selector(didSuccessLoginOption)]) {
                    [_loginDelegate didSuccessLoginOption];
                }
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate instance] hideBusyView];
                [self showAlertWithMessage:@"Login Failed!"];
            });
        }
    }];
}

- (IBAction)signupAction:(id)sender {
    
    if (_loginDelegate!=nil &&([_loginDelegate respondsToSelector:@selector(signupClicked)])) {
        
        [_loginDelegate signupClicked];
    }
}


@end
