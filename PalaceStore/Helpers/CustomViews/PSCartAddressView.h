//
//  PSCartAddressView.h
//  PalaceStore
//
//  Created by Sreelal H on 17/09/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PSCartAddressViewDelegate <NSObject>

- (void)didSuccessAddressOption;

@end

@interface PSCartAddressView : UIView{
    
    
}

@property(nonatomic,assign)id <PSCartAddressViewDelegate> cartAddressDelegate;

@end
