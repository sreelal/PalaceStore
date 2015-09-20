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

@interface PSCheckoutBaseViewController ()<PSCartLoginViewDelegate,PSCartAddressViewDelegate>
@property (weak, nonatomic) IBOutlet SwipeView *swipeBaseview;
@property (assign, nonatomic)NSInteger viewIndex;

@property (weak, nonatomic)PSCartLoginView *cartLoginView;
@property (weak, nonatomic)PSCartAddressView *cartAddressView;
@property (weak, nonatomic)PSCartView *cartView;
@property (weak, nonatomic)PSCartPaymentView *cartPaymentview;
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
    [self setSelectedPropertyForButton:_loginBtn];
    _selectedIndex = _loginBtn.tag;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - SwipeView Delegates

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView{
    
    return 4;
}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    UIView *targetView = nil;
    switch (index) {
        case 0:
        {
            if (!_cartLoginView) {
                
                _cartLoginView = [[[NSBundle mainBundle] loadNibNamed:@"PSCartLoginView" owner:self options:nil] firstObject];
                _cartLoginView.loginDelegate = self;
                //[ setTranslatesAutoresizingMaskIntoConstraints:NO];
            }
            targetView = _cartLoginView;
        }
            break;
            
        case 1:
        {
            if (!_cartAddressView) {
                
                _cartAddressView = [[[NSBundle mainBundle] loadNibNamed:@"PSCartAddressView"
                                                                  owner:self options:nil] firstObject];
                _cartAddressView.cartAddressDelegate = self;
            }
            targetView = _cartAddressView;
        }
            break;
            
            
        case 2:
        {
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

#pragma mark - Navigation button Actins

- (IBAction)didSelectNavigationButtonItem:(id)sender {
    
    UIButton *selectedButton = (UIButton*)sender;
    [self setSelectedPropertyForButton:selectedButton];
    [_swipeBaseview scrollToItemAtIndex:selectedButton.tag duration:0.2];
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

#pragma mark - Login Delegate


- (void)didSuccessLoginOption{
    
    [self setSelectedPropertyForButton:_addressBtn];
    [_swipeBaseview scrollToItemAtIndex:_addressBtn.tag duration:0.2];

}

- (void)didSuccessAddressOption{
    
    [self setSelectedPropertyForButton:_paymentBtn];
    [_swipeBaseview scrollToItemAtIndex:_paymentBtn.tag duration:0.2];
}



@end
