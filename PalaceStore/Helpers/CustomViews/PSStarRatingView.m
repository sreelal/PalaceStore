//
//  PSStarRatingView.m
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 06/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSStarRatingView.h"
#define MAX_RATING 5.0f
@interface PSStarRatingView()

@property (nonatomic,strong) CALayer* tintLayer;

@end
@implementation PSStarRatingView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}


- (void)drawRect:(CGRect)rect {



}

- (void)setRatingValue:(int)ratingValue{
    
    _ratingValue = ratingValue;
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self refreshValue];
}


- (void)refreshValue{
    
    self.opaque = NO;
    [self layoutIfNeeded];
    
    CALayer* starBackground = [CALayer layer];
    starBackground.contents = (__bridge id)([UIImage imageNamed:@"5starsgray"].CGImage);
    starBackground.frame = self.bounds;
    [self.layer addSublayer:starBackground];
    
    _tintLayer = [CALayer layer];
    _tintLayer.frame = CGRectMake(0, 0, 0, self.bounds.size.height);
    float barWitdhPercentage = (_ratingValue/MAX_RATING) *  (self.bounds.size.width);
    _tintLayer.frame = CGRectMake(0, 0, barWitdhPercentage, self.frame.size.height);
    [_tintLayer setBackgroundColor:[UIColor yellowColor].CGColor];
    [self.layer addSublayer:_tintLayer];
    
    CALayer* starMask = [CALayer layer];
    starMask.contents = (__bridge id)([UIImage imageNamed:@"5starsgray"].CGImage);
    starMask.frame = self.bounds;;
    [self.layer addSublayer:starMask];
    _tintLayer.mask = starMask;
}

@end
