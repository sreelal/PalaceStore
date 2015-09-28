//
//  PSCheckoutBaseViewController.m
//  PalaceStore
//
//  Created by Sreelal H on 17/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSCheckoutBaseViewController.h"
#import "SwipeView.h"
#import "PSCartLoginView.h"
#import "PSCartAddressView.h"
#import "PSCartPaymentView.h"
#import "PSCartView.h"
#import "HelperClass.h"
#import "UIColor+CustomColor.h"
#import "PSRegistrationView.h"
#import "AppDelegate.h"
#import "WebHandler.h"
#import "DatabaseHandler.h"
#import "PSAddressListView.h"

@interface PSCheckoutBaseViewController ()<PSCartLoginViewDelegate,PSCartAddressViewDelegate, PSSignUpDelegate, PSAddressListViewDelegate> {
    BOOL isSignUp;
    BOOL isAddAddress;
}
@property (weak, nonatomic) IBOutlet SwipeView *swipeBaseview;
@property (assign, nonatomic)NSInteger viewIndex;

@property (weak, nonatomic)PSCartLoginView *cartLoginView;
@property (weak, nonatomic)PSCartAddressView *cartAddressView;
@property (weak, nonatomic)PSCartView *cartView;
@property (weak, nonatomic)PSCartPaymentView *cartPaymentview;
@property (weak, nonatomic)PSAddressListView *addressListView;
@property (weak, nonatomic)PSRegistrationView *registrationView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *paymentBtn;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressLeftContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *paymentLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeftConstraint;
@property (assign, nonatomic) NSInteger selectedIndex;

@end

@implementation PSCheckoutBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewIndex = 0;
    _swipeBaseview.scrollEnabled = NO;
    //[self setSelectedPropertyForButton:_loginBtn];
    _selectedIndex = _loginBtn.tag;
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
    
    [HelperClass addBorderForView:contView withHexCodeg:COLOR_HEX_LIGHT_GRAY andAlpha:0.5];
    
    _loginBtn.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:1];
    _addressBtn.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.4];
    _paymentBtn.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.4];
    
    UIBarButtonItem *leftBarItem = [HelperClass getBackButtonItemWithTarget:self andAction:@selector(navgationBackClicked:)];
    leftBarItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIBarButtonItem *rightBarButtonItem = [[AppDelegate instance] getHomeBarButtonItemWithTarget:self andSelector:@selector(homeAction:)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

    _loginBtn.tag = 0;
    _addressBtn.tag = 1;
    _paymentBtn.tag = 2;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userId = [userDefaults valueForKey:KEY_USER_INFO_CUSTOMER_ID];
    
    if (userId != nil) {
        NSArray *addresses = [DatabaseHandler fetchItemsFromTable:TABLE_ADDRESS withPredicate:nil];
        
        if (addresses.count) isAddAddress = NO;
        else isAddAddress = YES;
        
        [self didSelectNavigationButtonItem:_addressBtn];
        
        //[[AppDelegate instance] showBusyView:@"Loading Addresses..."];
        
//        [WebHandler getAllAddressWithUserId:userId withCallback:^(id object, NSError *error) {
//            
//        }];
    }
    
//    self.navigationItem.rightBarButtonItem.badgeValue = @"2";
//    
//    [self sortBtnAction:_azBtn];
}

#pragma mark - SwipeView Delegates

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView{
    
    return 3;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    UIView *targetView = nil;
    switch (index) {
        case 0:{
            if (isSignUp) {
                if (!_registrationView) {
                    _registrationView = [[[NSBundle mainBundle] loadNibNamed:@"PSRegistrationView"
                                                                       owner:self options:nil] firstObject];
                    _registrationView.signupDelegate = self;
                }
                targetView = _registrationView;
            }
            else {
                if (!_cartLoginView) {
                    _cartLoginView = [[[NSBundle mainBundle] loadNibNamed:@"PSCartLoginView" owner:self options:nil] firstObject];
                    _cartLoginView.loginDelegate = self;
                }
                targetView = _cartLoginView;
            }
        }
        break;
            
        case 1:{
            if (isAddAddress) {
                if (!_cartAddressView) {
                    
                    _cartAddressView = [[[NSBundle mainBundle] loadNibNamed:@"PSCartAddressView"
                                                                      owner:self options:nil] firstObject];
                    _cartAddressView.cartAddressDelegate = self;
                }
                targetView = _cartAddressView;
            }
            else {
                if (!_addressListView) {
                    
                    _addressListView = [[[NSBundle mainBundle] loadNibNamed:@"PSAddressListView"
                                                                      owner:self options:nil] firstObject];
                    _addressListView.addressListViewDelegate = self;
                }
                [_addressListView loadAddresses];
                targetView = _addressListView;
            }
        }
        break;
            
        case 2:{
            if (!_cartPaymentview) {
                
                _cartPaymentview = [[[NSBundle mainBundle] loadNibNamed:@"PSCartPaymentView"
                                                                  owner:self options:nil] firstObject];
            }
            targetView = _cartPaymentview;
        }
            break;
            
            
        default:
            break;
    }
    [targetView setTranslatesAutoresizingMaskIntoConstraints:YES];
    targetView.frame = _swipeBaseview.bounds;
    [targetView layoutIfNeeded];
    return targetView;
}

#pragma mark - Button Actions

- (IBAction)navgationBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)homeAction:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Navigation button Actins


- (IBAction)didSelectNavigationButtonItem:(id)sender {
    
    UIButton *selectedButton = (UIButton*)sender;
    //[self setSelectedPropertyForButton:selectedButton];
    [_swipeBaseview scrollToItemAtIndex:selectedButton.tag duration:0];
}

- (void)setSelectedPropertyForButton:(UIButton*)btnSelected{
    
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"gray_arrow.png"] forState:UIControlStateNormal];
    _loginBtn.titleLabel.textColor = [UIColor darkGrayColor];

    [_addressBtn setBackgroundImage:[UIImage imageNamed:@"gray_arrow.png"] forState:UIControlStateNormal];
    _addressBtn.titleLabel.textColor = [UIColor darkGrayColor];

    [_paymentBtn setBackgroundImage:[UIImage imageNamed:@"gray_arrow.png"] forState:UIControlStateNormal];
    _paymentBtn.titleLabel.textColor = [UIColor darkGrayColor];

    [btnSelected setBackgroundImage:[UIImage imageNamed:@"red_arrow.png"] forState:UIControlStateNormal];
    btnSelected.titleLabel.textColor = [UIColor whiteColor];
}

#pragma mark - Checkout Delegate


- (void)didSuccessLoginOption{
    
    //[self setSelectedPropertyForButton:_addressBtn];
    isAddAddress = YES;
    [_swipeBaseview scrollToItemAtIndex:_addressBtn.tag duration:0];

}

- (void)didSuccessAddressOption{
    isAddAddress = NO;
    [_swipeBaseview reloadData];
    [_swipeBaseview scrollToItemAtIndex:_addressBtn.tag duration:0];
    [_swipeBaseview reloadData];

    //
    //[self setSelectedPropertyForButton:_paymentBtn];
}

- (void)signupClicked {
    [_loginBtn setTitle:@"Sign Up" forState:UIControlStateNormal];
    isSignUp = YES;
    [_swipeBaseview reloadData];
}

- (void)didSuccessSignUp {
    isSignUp = NO;
    [_swipeBaseview reloadData];
    //[self didSelectNavigationButtonItem:_addressBtn];
}

- (void)addAddress {
    isAddAddress = YES;
    [_swipeBaseview reloadData];
}

- (void)addressListViewNextAction {
    
    [self didSelectNavigationButtonItem:_paymentBtn];
}

@end
