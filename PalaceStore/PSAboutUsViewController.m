//
//  PSAboutUsViewController.m
//  PalaceStore
//
//  Created by Sreelash Sasikumar on 10/17/15.
//  Copyright © 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSAboutUsViewController.h"
#import "AppDelegate.h"
#import "WebHandler.h"
#import "NSString+HTML.h"
#import "PSCartPaymentCell.h"
#import "AboutUsTableViewCell.h"

@interface PSAboutUsViewController ()<HeaderViewDelegate> {
    NSInteger selecetedSectionIndex;
    NSInteger lastSelectedIndex;
}

@property (nonatomic, strong) NSArray *aboutUsDetails;

@end

@implementation PSAboutUsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    selecetedSectionIndex = 0;
    
    _aboutTableView.rowHeight = UITableViewAutomaticDimension;
    _aboutTableView.estimatedRowHeight = 40.0;
    
    [self setupView];
    [self loadAboutUs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)loadAboutUs {
    
    [[AppDelegate instance] showBusyView:@"Loading..."];
    
    [WebHandler getAboutUsWithCallback:^(id object, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (object != nil) {
                _aboutUsDetails = (NSArray *)object;
                
                [self aboutTappedWithTag:0];
            }
            else {
                [HelperClass showAlertWithMessage:@"Failed to get About Us!"];
            }
            
            [[AppDelegate instance] hideBusyView];
        });
    }];
}

- (void)setupView {
    
    self.navigationItem.titleView = [[AppDelegate instance] getNavigationBarImageView];
    
    self.navigationItem.leftBarButtonItem = [HelperClass getMenuButtonItemWithTarget:self andAction:@selector(leftAction:)];
}

#pragma mark - Button Actions

-(IBAction)leftAction:(id)sender {
    
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _aboutUsDetails.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 200;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = 0;
    
    if (selecetedSectionIndex == section) {
        count = 1;
        lastSelectedIndex = selecetedSectionIndex;
    }
    
    //return count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

#pragma mark - Table View Delegates

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    PSCartPaymentHeaderview *paymentHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"PSCartPaymentHeaderView" owner:self options:nil] lastObject];
    paymentHeaderView.delegate = self;
    
    
    NSDictionary *aboutUsDict = _aboutUsDetails[section];
    NSString *title = aboutUsDict[@"title"];
    
    NSString *htmlString = [NSString decodeHtmlUnicodeCharactersToString:title];
    NSData *stringData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
    NSAttributedString *decodedString;
    decodedString = [[NSAttributedString alloc] initWithData:stringData
                                                     options:options
                                          documentAttributes:NULL
                                                       error:NULL];
    
    paymentHeaderView.txtLabel.attributedText = decodedString;
    
    paymentHeaderView.btnAboutUs.tag  = section;
    
    [paymentHeaderView.btn setHidden:YES];
    [paymentHeaderView.btnEdit setHidden:YES];
    
//    if (section == selecetedSectionIndex) {
//        [paymentHeaderView.btn setSelected:YES];
//    }
//    else {
//        [paymentHeaderView.btn setSelected:NO];
//    }
    
    return paymentHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *aboutUsDict = _aboutUsDetails[indexPath.section];
    NSString *title = aboutUsDict[@"description"];
    
    NSString *htmlString = [NSString decodeHtmlUnicodeCharactersToString:title];
    NSData *stringData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
    NSAttributedString *decodedString;
    decodedString = [[NSAttributedString alloc] initWithData:stringData
                                                     options:options
                                          documentAttributes:NULL
                                                       error:NULL];
    
    AboutUsTableViewCell *cell = (AboutUsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"AboutUsTableViewCell"];
    
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AboutUsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblAboutDescription.attributedText = decodedString;
    
    return cell;
}

#pragma mark - HeaderView Delegate

- (void)aboutTappedWithTag:(long)tag {
    
    //selecetedSectionIndex = tag;
    
    [_aboutTableView reloadData];
}

@end
