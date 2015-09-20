//
//  PSCartAddressView.m
//  PalaceStore
//
//  Created by Sreelal H on 17/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSCartAddressView.h"

@interface PSCartAddressView ()
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;

@end
@implementation PSCartAddressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)didSelectGender:(id)sender {
    
    _maleBtn.selected = NO;
    _femaleBtn.selected=NO;
    UIButton *_selectedBtn = (UIButton*)sender;
    _selectedBtn.selected = YES;
}
- (IBAction)didSelectnext:(id)sender {
    
    if (_cartAddressDelegate&&([_cartAddressDelegate respondsToSelector:@selector(didSuccessAddressOption)])) {
        
        
        [_cartAddressDelegate didSuccessAddressOption];
    }
}
- (IBAction)didSelectBillingSameAddress:(id)sender {
    UIButton *_selectedBtn = (UIButton*)sender;
    _selectedBtn.selected = !_selectedBtn.selected;

}

@end
