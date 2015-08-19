//
//  PSProductSpecificationsViewController.m
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 10/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "PSProductSpecificationsViewController.h"
#import "Product_Details.h"
#import "Product_Attributes.h"

@interface PSProductSpecificationsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *productSpecificationsTable;
@property (strong, nonatomic)NSMutableDictionary *specificationsData;

@end


@implementation PSProductSpecificationsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareSpecificationsData];
}


- (void)prepareSpecificationsData{
    
    _specificationsData = [NSMutableDictionary dictionary];
    NSMutableDictionary *_fixedSpecifications = [NSMutableDictionary dictionary];
    _fixedSpecifications[@"Manufacturer"] = _selectedProduct.relationship.manufacturer;
    _fixedSpecifications[@"Model"] = _selectedProduct.model;
    
    _fixedSpecifications[@"Points"] = [NSString stringWithFormat:@"%d",[_selectedProduct.points intValue]];
   _fixedSpecifications[@"Weight"] = [NSString stringWithFormat:@"%0.1f g",[_selectedProduct.weight doubleValue]];
   _fixedSpecifications[@"Dimension"] = [NSString stringWithFormat:@"%0.1f x %0.1f x %0.1f",[_selectedProduct.length doubleValue],[_selectedProduct.width doubleValue],[_selectedProduct.height doubleValue]];
   _specificationsData[@"Product Details"] = _fixedSpecifications;
    
    
    NSSet *attributesCollection = _selectedProduct.relationship.relationship;
    if (attributesCollection.count>0) {
        
       // _specifications[]
        for (Product_Attributes *prod_Attributes in attributesCollection) {
            
            NSMutableDictionary *_attributesDictionary = [NSMutableDictionary dictionary];
            _attributesDictionary[prod_Attributes.attributeKey] = prod_Attributes.attributeValue;
            _specificationsData[prod_Attributes.attributeName] = _attributesDictionary;
        }
    }
}

#pragma mark -  Tableview delegates


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_specificationsData.allKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDictionary *subSpecifications = _specificationsData[_specificationsData.allKeys[section]];
    return [subSpecifications.allKeys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"specifications"];
    NSMutableDictionary *sectionData = _specificationsData[_specificationsData.allKeys[indexPath.section]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@",sectionData.allKeys[indexPath.row],sectionData.allValues[indexPath.row]];
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    NSString *headerLabel = _specificationsData.allKeys[section];
//    if ([headerLabel isEqualToString:@"fixedSpecifications"]) {
//        
//        headerLabel = @"";
//    }
//    return headerLabel;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
     NSString *headerLabel = _specificationsData.allKeys[section];
     if ([headerLabel isEqualToString:@"fixedSpecifications"]) {
    
            headerLabel = @"";
    }
    UILabel *sectionHeader = [[UILabel alloc] init];
    sectionHeader.backgroundColor = [UIColor groupTableViewBackgroundColor];
    sectionHeader.textAlignment = NSTextAlignmentLeft;
    sectionHeader.font = [UIFont boldSystemFontOfSize:15];
    sectionHeader.textColor = [UIColor darkGrayColor];
    sectionHeader.text = headerLabel;
    return sectionHeader;
}


@end
