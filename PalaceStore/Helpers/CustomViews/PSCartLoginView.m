//
//  PSCartLoginView.m
//  PalaceStore
//
//  Created by Sreelal H on 17/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSCartLoginView.h"

@interface PSCartLoginView ()
@property (weak, nonatomic) IBOutlet UIButton *rememberPassword;

@end

@implementation PSCartLoginView

- (void)awakeFromNib{
    
    [_rememberPassword setBackgroundImage:[UIImage imageNamed:@"radio-normal.png"] forState:UIControlStateNormal];

}
- (IBAction)didSelectRemember:(id)sender {
    
    UIButton *selectedBtn = (UIButton*)sender;
    selectedBtn.selected = !selectedBtn.selected;
}
- (IBAction)didSelectLogin:(id)sender {
    
    if (_loginDelegate!=nil &&([_loginDelegate respondsToSelector:@selector(didSuccessLoginOption)])) {
        
        [_loginDelegate didSuccessLoginOption];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
