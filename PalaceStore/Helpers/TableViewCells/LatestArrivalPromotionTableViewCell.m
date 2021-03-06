//
//  HomeBottomTableViewCell.m
//  PalaceStore
//
//  Created by Sreelash S on 05/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "LatestArrivalPromotionTableViewCell.h"
#import "ItemView.h"
#import "CategoryView.h"
#import "HelperClass.h"
#import "UIColor+CustomColor.h"

#import "LatestArrivals_Promotions.h"

@interface LatestArrivalPromotionTableViewCell ()

@property (assign, nonatomic) BOOL isLatestArrival;

@end

@implementation LatestArrivalPromotionTableViewCell

- (void)awakeFromNib {
    
    _promotionBottonImageView.hidden = YES;
    _containerView.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.2];
    _seperatorLabel.backgroundColor = [UIColor getUIColorObjectFromHexString:COLOR_HEX_LIGHT_GRAY alpha:0.5];
    
    [HelperClass addBorderForView:_swipeView withHexCodeg:COLOR_HEX_LIGHT_GRAY andAlpha:0.5];
        
    _swipeView.alignment = SwipeViewAlignmentEdge;
    _swipeView.pagingEnabled = YES;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadItems {
    
    /*_arrivalView.alignment = SwipeViewAlignmentEdge;
    _arrivalView.pagingEnabled = YES;
    _arrivalView.itemsPerPage = 1;
    _arrivalView.truncateFinalPage = YES;
    _arrivalView.tag = 111;
    
    _promotionalItemView.alignment = SwipeViewAlignmentEdge;
    _promotionalItemView.pagingEnabled = YES;
    _promotionalItemView.itemsPerPage = 1;
    _promotionalItemView.truncateFinalPage = NO;
    _promotionalItemView.tag = 222;
    
    _categoryItemView.alignment = SwipeViewAlignmentEdge;
    _categoryItemView.pagingEnabled = YES;
    _categoryItemView.itemsPerPage = 1;
    _categoryItemView.truncateFinalPage = NO;
    _categoryItemView.tag = 333;*/
}

#pragma mark - Button Actions

- (IBAction)loadLatestArrivals:(id)sender {
    _isLatestArrival = YES;
    
    _latestBottonImageView.hidden = NO;
    _promotionBottonImageView.hidden = YES;
    
    [_swipeView reloadData];
}

- (IBAction)loadPromotionalItems:(id)sender {
    _isLatestArrival = NO;
    
    _latestBottonImageView.hidden = YES;
    _promotionBottonImageView.hidden = NO;
    
    [_swipeView reloadData];
}

#pragma mark - SwipeView Delegates

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    
    //generate 100 item views
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    
    NSInteger count = 0;
    
    if (_isLatestArrival)
        count = _latestArrivals.count;
    else
        count = _promotionalItems.count;
    
//    if (swipeView.tag == 111) count = _nwArrivals.count;
//    else if (swipeView.tag == 222) count = _promotionalItems.count;
//    else count = _categories.count;
    
    return count;
}

- (BOOL)swipeView:(SwipeView *)swipeView shouldSelectItemAtIndex:(NSInteger)index {
    
    return NO;
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"index : %ld", index);
    
    LatestArrivals_Promotions *latestArrivalPromotion = nil;
    
    if (_isLatestArrival)
        latestArrivalPromotion = _latestArrivals[index];
    else
        latestArrivalPromotion = _promotionalItems[index];
    
    [_callingController promotionLatestItemBtnActionWithObj:latestArrivalPromotion];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    /*if (!view) {
     //load new item view instance from nib
     //control events are bound to view controller in nib file
     //note that it is only safe to use the reusingView if we return the same nib for each
     //item view, if different items have different contents, ignore the reusingView value
     
     
     }*/
    
    LatestArrivals_Promotions *latestArrivalPromotion = nil;
    
    if (_isLatestArrival)
        latestArrivalPromotion = _latestArrivals[index];
    else
        latestArrivalPromotion = _promotionalItems[index];
    
    ItemView *itemView = [[NSBundle mainBundle] loadNibNamed:@"ItemView" owner:self options:nil][0];
    itemView.callingControllerInstance = _callingController;
    itemView.islatestPromotionItem = YES;
    
    itemView.frame = CGRectMake(itemView.frame.origin.x, itemView.frame.origin.y, itemView.frame.size.width, itemView.frame.size.height);
    [itemView loadItem:latestArrivalPromotion];
    
    view = itemView;
    
    /*if (swipeView.tag == 111) {
        NSDictionary *newArrDict = self.nwArrivals[index];
        
        NSLog(@"Tag : %ld", swipeView.tag);
        
        ItemView *newArrivalItem = [[NSBundle mainBundle] loadNibNamed:@"ItemView" owner:self options:nil][0];
        newArrivalItem.frame = CGRectMake(newArrivalItem.frame.origin.x, newArrivalItem.frame.origin.y, newArrivalItem.frame.size.width, newArrivalItem.frame.size.height);
        [newArrivalItem updateNewArrivalItemWithDict:newArrDict];
        
        view = newArrivalItem;
    }
    else if (swipeView.tag == 222) {
        NSDictionary *promotionalDict = self.promotionalItems[index];
        
        NSLog(@"Tag : %ld", swipeView.tag);
        
        ItemView *promotionalItem = [[NSBundle mainBundle] loadNibNamed:@"ItemView" owner:self options:nil][0];
        promotionalItem.frame = CGRectMake(promotionalItem.frame.origin.x, promotionalItem.frame.origin.y, promotionalItem.frame.size.width, promotionalItem.frame.size.height);
        
        [promotionalItem updateNewArrivalItemWithDict:promotionalDict];
        
        view = promotionalItem;
    }
    else if (swipeView.tag == 333) {
        NSDictionary *categoryDict = self.categories[index];
        
        NSLog(@"Tag : %ld", swipeView.tag);
        
        CategoryView *categoryView = [[NSBundle mainBundle] loadNibNamed:@"CategoryView" owner:self options:nil][0];
        categoryView.frame = CGRectMake(categoryView.frame.origin.x, categoryView.frame.origin.y, categoryView.frame.size.width, categoryView.frame.size.height);
        
        if (index == _categories.count - 1) {
            categoryView.rightBorder.hidden = YES;
        }
        
        [categoryView updateUIWithDict:categoryDict];
        
        view = categoryView;
    }*/
    
    return view;
}

@end
