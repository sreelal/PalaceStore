//
//  CategoryTableViewCell.m
//  PalaceStore
//
//  Created by Sreelash S on 27/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "CategoryTableViewCell.h"
#import "HelperClass.h"
#import "UIColor+CustomColor.h"
#import "AOImageView.h"
#import "Product_Category.h"
#import "ItemView.h"

@interface CategoryTableViewCell ()

@property (nonatomic,retain)NSMutableArray *marqueeViewItems;

@end

@implementation CategoryTableViewCell

- (void)awakeFromNib {

    _swipeView.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.2];
    _topBar.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.5];
    _bottomBar.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.5];
    
    [HelperClass addBorderForView:_swipeView withHexCodeg:COLOR_HEX_LIGHT_GRAY andAlpha:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadCategories {
    
    [_swipeView reloadData];
}

#pragma mark - SwipeView Delegates

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    
    //generate 100 item views
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    
    NSInteger count = _categories.count;
    
    return count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    /*if (!view) {
     //load new item view instance from nib
     //control events are bound to view controller in nib file
     //note that it is only safe to use the reusingView if we return the same nib for each
     //item view, if different items have different contents, ignore the reusingView value
     
     
     }*/
    
    Product_Category *category = _categories[index];
    
    ItemView *itemView = [[NSBundle mainBundle] loadNibNamed:@"ItemView" owner:self options:nil][0];
    itemView.callingControllerInstance = _callingControllerInstance;
    itemView.frame = CGRectMake(itemView.frame.origin.x, itemView.frame.origin.y, itemView.frame.size.width, itemView.frame.size.height);
    [itemView loadCategory:category];
    
    view = itemView;
    
    return view;
}

#pragma mark - Marquee View Delegates

- (void)loadMarqueeControlWith:(NSMutableArray*)marqueeViews{
    
    _marqueeViewItems  = marqueeViews;
    
    _marqueeView.delegate = self;
    [_marqueeView setNeedsLayout];
    [_marqueeView drawMarqueeView];
    
}

- (NSInteger)numberOfItemsInMarqueeView{
    
    return [_marqueeViewItems count];
}

- (CGFloat) widthForItemsInMarqueeview{
    
    return 60;
}

- (CGFloat) horizontalSpaceBetweenViews{
    
    return 20;
}

- (id)viewForItemAtIndex:(NSInteger)index InMarqueeview:(SLMarqueeView*)marqueeView{
    
    AOImageView *_imageView = [[AOImageView alloc]initWithImageName:_marqueeViewItems[index]
                                                             title:@""
                                                                 x:0
                                                                 y:0
                                                            height:_marqueeView.frame.size.height
                                                             width:[self widthForItemsInMarqueeview]];
    return _imageView;
}

@end
