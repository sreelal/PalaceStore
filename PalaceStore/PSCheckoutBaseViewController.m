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

@interface PSCheckoutBaseViewController ()
@property (weak, nonatomic) IBOutlet SwipeView *swipeBaseview;
@property (assign, nonatomic)NSInteger viewIndex;

@property (weak, nonatomic)PSCartLoginView *cartLoginView;
@property (weak, nonatomic)PSCartAddressView *cartAddressView;
@property (weak, nonatomic)PSCartView *cartView;
@property (weak, nonatomic)PSCartPaymentView *cartPaymentview;

@end

@implementation PSCheckoutBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewIndex = 0;
    _swipeBaseview.scrollEnabled = NO;
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
            }
            targetView = _cartAddressView;
        }
            break;
            
            
        case 2:
        {
            if (!_cartView) {
                
                _cartView = [[[NSBundle mainBundle] loadNibNamed:@"PSCartView"
                                                           owner:self options:nil] firstObject];
            }
            targetView = _cartView;

        }
            break;
            
        case 3:
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
    [_swipeBaseview scrollToItemAtIndex:selectedButton.tag duration:0.2];
}


@end
