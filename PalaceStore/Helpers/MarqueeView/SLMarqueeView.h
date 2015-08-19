//
//  SLMarqueeView.h
//  MarqueeView
//
//  Created by Sreelal  Hamsavahanan on 01/04/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLMarqueeView;
@protocol SLMarqueeViewDelegate <NSObject>

- (NSInteger)numberOfItemsInMarqueeView;
- (CGFloat) widthForItemsInMarqueeview;
- (CGFloat) horizontalSpaceBetweenViews;
- (id)viewForItemAtIndex:(NSInteger)index InMarqueeview:(SLMarqueeView*)marqueeView;

@end

@interface SLMarqueeView : UIView{
    
    
}
- (void)drawMarqueeView;
- (void)unloadMarqueeView;
- (id)viewAtIndex:(NSInteger)indexValue;
- (BOOL)isViewVisibleAtIndex:(NSInteger)indexValue;

@property (nonatomic, assign) id<SLMarqueeViewDelegate> delegate;
@property (nonatomic,assign) NSInteger speedFactor; //Decides the speed level of items scroll

@end
