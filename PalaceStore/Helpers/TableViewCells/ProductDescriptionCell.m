//
//  ProductDescriptionCell.m
//  PalaceStore
//
//  Created by Sreelal Hamsavahanan on 06/08/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "ProductDescriptionCell.h"
#import "Product_Details.h"
#import "NSString+HTML.h"

@interface ProductDescriptionCell (){

}
@property (weak, nonatomic) IBOutlet UILabel *stockStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *productDescriptionLabel;

//@property (weak, nonatomic) IBOutlet UIWebView *webContent;
@property (weak, nonatomic) IBOutlet UILabel *deliveryStatusLabel;
@end

@implementation ProductDescriptionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadProductDescription:(Product_Details*)productDetails{
    
    if ([productDetails.stock_status isEqualToString:@"Out Of Stock"]) {
        
        _stockStatusLabel.textColor = [UIColor colorWithRed:(234.0f/255.0f) green:(40.0f/255.0f) blue:(50.0f/255.0f) alpha:1.0f];
        _stockStatusLabel.text = productDetails.stock_status;
        _deliveryStatusLabel.hidden = YES;

    }
    else{
        
        _stockStatusLabel.textColor = [UIColor colorWithRed:(78.0f/255.0f) green:(172.0f/255.0f) blue:(74.0f/255.0f) alpha:1.0f];
        _stockStatusLabel.text = @"In Stock";
        _deliveryStatusLabel.hidden = NO;
        _deliveryStatusLabel.text = [NSString stringWithFormat:@"Delivered in %@",productDetails.stock_status];
    }
    

    //_productDescriptionLabel.text = [NSString stringByConvertingHTMLToPlainTextWith:[productDetails.detailedInfo stringByRemovingPercentEncoding]];
    if(productDetails.detailedInfo){
    
        NSString *htmlString = [NSString decodeHtmlUnicodeCharactersToString:productDetails.detailedInfo];
        NSData *stringData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
        NSAttributedString *decodedString;
        decodedString = [[NSAttributedString alloc] initWithData:stringData
                                                         options:options
                                              documentAttributes:NULL
                                                           error:NULL];
        
       // [_webContent loadHTMLString:str  baseURL:nil];
        _productDescriptionLabel.attributedText = decodedString;
    }
}


@end
