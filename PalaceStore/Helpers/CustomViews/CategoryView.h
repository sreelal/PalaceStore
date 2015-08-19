//
//  CategoryView.h
//  PalaceStore
//
//  Created by Sreelash S on 06/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryView : UIView {
    IBOutlet UIImageView *imgView;
    
    IBOutlet UILabel *label;
}

@property (weak, nonatomic) IBOutlet UIImageView *rightBorder;

- (void)updateUIWithDict:(NSDictionary *)dict;

@end
