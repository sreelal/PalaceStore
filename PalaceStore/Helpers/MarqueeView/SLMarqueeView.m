//
//  SLMarqueeView.m
//  MarqueeView
//
//  Created by Sreelal  Hamsavahanan on 01/04/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "SLMarqueeView.h"

#define MARQUEE_TAG_START   198
#define DEFAULT_SPEED       30

@interface SLMarqueeView (){
    
    NSTimer *scrollTimer;
}

@property (nonatomic,assign) NSInteger numberOfItems;
@property (nonatomic,assign) CGFloat widthForItems;
@property (nonatomic,assign) CGFloat horizontalSpacing;
@property (nonatomic,strong) NSMutableArray *itemsAdded;
@property (nonatomic,strong) NSMutableArray *itemsRemoved;
@property (nonatomic,strong) UIScrollView *scrollItems;

@end

@implementation SLMarqueeView

@synthesize numberOfItems = _numberOfItems;

- (void)awakeFromNib{
    
    _speedFactor = DEFAULT_SPEED;

}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _speedFactor = DEFAULT_SPEED;
    }
    return self;
}

/**
 * To draw a marquee control
 *
 */
- (void)drawMarqueeView{
    
    if (self.delegate!=nil) {
        
        if ([self.delegate respondsToSelector:@selector(numberOfItemsInMarqueeView)]) {
            
            
            if (_scrollItems) {
                [_scrollItems.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [_scrollItems removeFromSuperview];
            }
            self.numberOfItems = [self.delegate numberOfItemsInMarqueeView];
        }
    }
}

/**
 * getter to return number of items
 */

- (NSInteger)numberOfItems{
    
    return _numberOfItems;
}

/**
 * To set the number of items in Marquee view,which also starts drawing the initial set of items in Marquee view
 * @param numberOfItems number of items
 */

- (void)setNumberOfItems:(NSInteger)numberOfItems{
    
    _numberOfItems = numberOfItems;
    if (_numberOfItems>0) {
        
        _itemsAdded = [[NSMutableArray alloc] init];
        _itemsRemoved = [[NSMutableArray alloc] init];
        _scrollItems = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollItems.userInteractionEnabled = NO;
        [self addSubview:_scrollItems];
        
        if ([self.delegate respondsToSelector:@selector(widthForItemsInMarqueeview)]) {
            
            _widthForItems = [self.delegate widthForItemsInMarqueeview];
        }
        
        if ([self.delegate respondsToSelector:@selector(widthForItemsInMarqueeview)]) {
            
            _horizontalSpacing = [self.delegate horizontalSpaceBetweenViews];
        }
        
        //Now start drawing
        float xPosition = 5;
        for (int iIndex = 0; iIndex<_numberOfItems; iIndex++) {
            
            if ([self.delegate respondsToSelector:@selector(viewForItemAtIndex:InMarqueeview:)]) {
                
                xPosition = ((iIndex+1)*_horizontalSpacing)+(iIndex*_widthForItems);
                
                if ((xPosition>self.frame.size.width)) {
                    
                    //Not visible so no need to add,just add tag to remove array
                    [_itemsRemoved addObject:[NSNumber numberWithInt:MARQUEE_TAG_START+iIndex]];
                }
                else{
                    //frame is visible,so add to the scrollview
                    UIView *viewToAdd = [self.delegate viewForItemAtIndex:iIndex InMarqueeview:self];
                    viewToAdd.tag = MARQUEE_TAG_START+iIndex;
                    viewToAdd.frame = CGRectMake(xPosition, 0, _widthForItems, self.frame.size.height);
                    
                    //Add tag to the items arrray
                    [_itemsAdded addObject:[NSNumber numberWithInt:MARQUEE_TAG_START+iIndex]];
                    [_scrollItems addSubview:viewToAdd];
                }
            }
        }
        
        float contentWidth = (_widthForItems*_numberOfItems)+((_numberOfItems+1)*_horizontalSpacing);
        _scrollItems.contentSize = CGSizeMake(contentWidth, 0);
        
        if (scrollTimer) {
            [scrollTimer invalidate];
        }
        
        //Now start the scrolling
       scrollTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(performScroll) userInfo:nil repeats:YES];

    }
}

/**
 * To start the scrollong of items,
 *
 */

- (void) performScroll {
    CGFloat currentOffset = _scrollItems.contentOffset.x;
    CGFloat newOffset = currentOffset + _speedFactor;
    [_scrollItems setContentOffset:CGPointMake(newOffset,0.0) animated:YES];
    //get first item
    
    if (_itemsAdded.count>0) {
        
        int tagOfViewAdded = [[_itemsAdded firstObject] intValue];
        int tagOfLastViewAdded = [[_itemsAdded lastObject] intValue];

        UIView *viewAdded = (UIView*)[_scrollItems viewWithTag:tagOfViewAdded];
        UIView *lastViewAdded = (UIView*)[_scrollItems viewWithTag:tagOfLastViewAdded];

        if ((_horizontalSpacing+viewAdded.frame.origin.x+viewAdded.frame.size.width)-newOffset<=0) {
            
            //NSLog(@"Remove view with tag : %ld",(long)viewAdded.tag);
            [viewAdded removeFromSuperview];
            viewAdded = nil;
            [_itemsRemoved addObject:[NSNumber numberWithInt:tagOfViewAdded]];
            [_itemsAdded removeObject:[NSNumber numberWithInt:tagOfViewAdded]];
        }
        if (lastViewAdded.frame.origin.x+lastViewAdded.frame.size.width+_horizontalSpacing-newOffset<self.frame.size.width) {
            
            //Add new view
            //get the view for index and layout it
            int tagOfViewToAddAgain = [[_itemsRemoved firstObject] intValue];
            UIView *viewToAddAgain = [self.delegate viewForItemAtIndex:tagOfViewToAddAgain-MARQUEE_TAG_START InMarqueeview:self];
            viewToAddAgain.tag = tagOfViewToAddAgain;
            

          //  NSLog(@"Adding view with tag : %ld",(long)viewToAddAgain.tag);

            viewToAddAgain.frame = CGRectMake(lastViewAdded.frame.origin.x+lastViewAdded.frame.size.width+_horizontalSpacing, 0, _widthForItems, self.frame.size.height);
            [_scrollItems addSubview:viewToAddAgain];
            [_itemsAdded addObject:[NSNumber numberWithInt:tagOfViewToAddAgain]];
            [_itemsRemoved removeObject:[NSNumber numberWithInt:tagOfViewToAddAgain]];
        }
    }
}

/**
 * To check the visibility of item at the given index
 * @param indexValue is the index of the item
 */

- (BOOL)isViewVisibleAtIndex:(NSInteger)indexValue{
    
    NSInteger tagOfView = (int)MARQUEE_TAG_START+indexValue;
    if ([_itemsAdded containsObject:[NSNumber numberWithInteger:tagOfView]]) {
        
        return YES;
    }
    return NO;
}

/**
 * To return item at the given index
 * @param indexValue is the index of the item
 */


- (id)viewAtIndex:(NSInteger)indexValue{
    
    NSInteger tagOfView = (int)MARQUEE_TAG_START+indexValue;
    if ([_itemsAdded containsObject:[NSNumber numberWithInteger:tagOfView]]) {
        
        UIView *viewAdded = (UIView*)[_scrollItems viewWithTag:tagOfView];
        return viewAdded;
    }
    return nil;
}

/**
 * To unload all the items in marqueeview for memory mamangement
 */

- (void)unloadMarqueeView{
    
    if (scrollTimer) {
        [scrollTimer invalidate];
    }
    self.scrollItems = nil;
    self.itemsAdded = nil;
    self.itemsRemoved = nil;
}



@end
