//
//  CategoryView.m
//  PalaceStore
//
//  Created by Sreelash S on 06/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "CategoryView.h"

@implementation CategoryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)updateUIWithDict:(NSDictionary *)dict {
    
    imgView.image = [UIImage imageNamed:dict[@"image"]];
    label.text = dict[@"name"];
}

@end
