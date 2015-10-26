//
//  DatabaseHandler.m
//  PalaceStore
//
//  Created by Sreelash S on 26/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import "DatabaseHandler.h"
#import "Constants.h"
#import "NSString+HTML.h"

#import "Banner_Images.h"
#import "LatestArrivals_Promotions.h"
#import "Product_Category.h"
#import "Products.h"
#import "Cart.h"
#import "Product_Details.h"
#import "Product_Attributes.h"
#import "NSNull+Empty.h"
#import "NSString+Empty.h"
#import "Address.h"

@implementation DatabaseHandler

+ (void)insertBannerImages:(NSArray *)bannerImages {
    
    NSManagedObjectContext *privateMOC = [[DatabaseManager sharedInstance] privateManagedObjectContext];
    
    for (NSDictionary *dict in bannerImages) {
        @autoreleasepool {
            Banner_Images *bannerImage = nil;
            
            bannerImage = [NSEntityDescription insertNewObjectForEntityForName:TABLE_BANNER_IMAGES inManagedObjectContext:privateMOC];
            
            bannerImage.title = dict[KEY_TITLE];
            bannerImage.image_url = dict[KEY_BANNER_IMAGE_URL];
        }
    }
    
    if ([privateMOC hasChanges]) {
        [privateMOC performBlockAndWait:^{
            NSError *error = nil;
            
            if (![privateMOC save:&error]) {
                NSLog(@"Error %@", [error localizedDescription]);
            }
            else {
                NSLog(@"Sucessfully Saved Banner Images");
            }
        }];
    }
}

+ (void)insertLogoImages:(NSArray *)logoImages {
    
    NSManagedObjectContext *privateMOC = [[DatabaseManager sharedInstance] privateManagedObjectContext];
    
    for (NSDictionary *dict in logoImages) {
        @autoreleasepool {
            Banner_Images *bannerImage = nil;
            
            bannerImage = [NSEntityDescription insertNewObjectForEntityForName:TABLE_BANNER_IMAGES inManagedObjectContext:privateMOC];
            
            bannerImage.title = dict[KEY_TITLE];
            bannerImage.image_url = dict[KEY_BANNER_IMAGE_URL];
            bannerImage.isBrands =  [NSNumber numberWithBool:YES];
        }
    }
    
    if ([privateMOC hasChanges]) {
        [privateMOC performBlockAndWait:^{
            NSError *error = nil;
            
            if (![privateMOC save:&error]) {
                NSLog(@"Error %@", [error localizedDescription]);
            }
            else {
                NSLog(@"Sucessfully Saved Banner Images");
            }
        }];
    }
}


+ (void)insertLatestArrivals:(NSArray *)latestArrivals andPromotions:(NSArray *)promotions {
    
    NSManagedObjectContext *privateMOC = [[DatabaseManager sharedInstance] privateManagedObjectContext];
    
    for (NSDictionary *dict in latestArrivals) {
        @autoreleasepool {
            LatestArrivals_Promotions *latestArrival = nil;
            
            latestArrival = [NSEntityDescription insertNewObjectForEntityForName:TABLE_LATEST_ARRIVALS_PROMOTIONS inManagedObjectContext:privateMOC];
            
            latestArrival.product_description = dict[KEY_PROD_DESCRIPTION];
            latestArrival.product_id = [NSNumber numberWithInt:[dict[KEY_PROD_ID] intValue]];
            latestArrival.name = [NSString stringByConvertingHTMLToPlainTextWith:dict[KEY_NAME]];
            latestArrival.price = [dict[KEY_PRICE] stringByReplacingOccurrencesOfString:@"GHs" withString:@""];
            latestArrival.raing = dict[KEY_RATING];
            latestArrival.tax = dict[KEY_TAX];
            latestArrival.thumb_image_url = dict[KEY_THUMB_URL];
            latestArrival.is_latest = [NSNumber numberWithBool:1];
        }
    }
    
    for (NSDictionary *dict in promotions) {
        @autoreleasepool {
            LatestArrivals_Promotions *promotion = nil;
            
            promotion = [NSEntityDescription insertNewObjectForEntityForName:TABLE_LATEST_ARRIVALS_PROMOTIONS inManagedObjectContext:privateMOC];
            
            promotion.product_description = dict[KEY_PROD_DESCRIPTION];
            promotion.product_id = [NSNumber numberWithInt:[dict[KEY_PROD_ID] intValue]];
            promotion.name = [NSString stringByConvertingHTMLToPlainTextWith:dict[KEY_NAME]];
            promotion.price = [dict[KEY_PRICE] stringByReplacingOccurrencesOfString:@"GHs" withString:@""];
            promotion.raing = dict[KEY_RATING];
            promotion.tax = dict[KEY_TAX];
            promotion.thumb_image_url = dict[KEY_THUMB_URL];
            promotion.is_promotion = [NSNumber numberWithBool:1];
        }
    }
    
    if ([privateMOC hasChanges]) {
        [privateMOC performBlockAndWait:^{
            NSError *error = nil;
            
            if (![privateMOC save:&error]) {
                NSLog(@"Error %@", [error localizedDescription]);
            }
            else {
                NSLog(@"Sucessfully Saved Banner Images");
            }
        }];
    }
}

+ (void)insertProductCategories:(NSArray *)categories {
    
    NSManagedObjectContext *privateMOC = [[DatabaseManager sharedInstance] privateManagedObjectContext];
    
    for (NSDictionary *dict in categories) {
        @autoreleasepool {
            Product_Category *category = nil;
            
            category = [NSEntityDescription insertNewObjectForEntityForName:TABLE_PRODUCT_CATEGORY inManagedObjectContext:privateMOC];
            
            category.category_id = [NSNumber numberWithInt:[dict[@"category_id"] intValue]];
            category.subcategory_count = [NSNumber numberWithInt:[dict[@"categories"] intValue]];
            category.image_url = dict[@"image"];
            category.name = [NSString stringByConvertingHTMLToPlainTextWith:dict[KEY_NAME]];
            category.product_count = [NSNumber numberWithInt:[dict[@"products"] intValue]];
        }
    }
    
    if ([privateMOC hasChanges]) {
        [privateMOC performBlockAndWait:^{
            NSError *error = nil;
            
            if (![privateMOC save:&error]) {
                NSLog(@"Error %@", [error localizedDescription]);
            }
            else {
                NSLog(@"Sucessfully Saved Banner Images");
            }
        }];
    }
}

+ (void)insertSubCategories:(NSArray *)subCategories forParentCategoryId:(NSNumber *)parentCategoryId {
    
    NSManagedObjectContext *moc = [[DatabaseManager sharedInstance] managedObjectContext];
    
    for (NSDictionary *dict in subCategories) {
        @autoreleasepool {
            Product_Category *subCategory = nil;
            
            subCategory = [NSEntityDescription insertNewObjectForEntityForName:TABLE_PRODUCT_CATEGORY inManagedObjectContext:moc];
            
            subCategory.parent_category_id = parentCategoryId;
            subCategory.category_id = [NSNumber numberWithInt:[dict[@"category_id"] intValue]];
            subCategory.subcategory_count = [NSNumber numberWithInt:[dict[@"categories"] intValue]];
            subCategory.image_url = dict[@"image"];
            subCategory.name = [NSString stringByConvertingHTMLToPlainTextWith:dict[KEY_NAME]];
            subCategory.product_count = [NSNumber numberWithInt:[dict[@"products"] intValue]];
        }
    }
    
    NSError *error = nil;
    
    if (![moc save:&error]) {
        NSLog(@"Error %@", [error localizedDescription]);
    }
    else {
        NSLog(@"Sucessfully Saved Sub Categories");
    }
}

+ (void)insertAddresses:(NSDictionary *)addressesDict {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *userId = [f numberFromString:[userDefaults valueForKey:KEY_USER_INFO_CUSTOMER_ID]];
    
    NSManagedObjectContext *moc = [[DatabaseManager sharedInstance] managedObjectContext];
    
    for (NSString *key in addressesDict) {
        NSDictionary *addressDict = addressesDict[key];
        
        if ([addressDict[@"address_1"] isEqualToString:@""]) continue;
        
        @autoreleasepool {
            Address *address = nil;
            
            address = [NSEntityDescription insertNewObjectForEntityForName:TABLE_ADDRESS inManagedObjectContext:moc];
            address.firstname = addressDict[@"firstname"];
            address.lastname = addressDict[@"lastname"];
            address.address_1 = addressDict[@"address_1"];
            address.address_id = [NSString stringWithFormat:@"%@", addressDict[@"address_id"]];
            address.company = addressDict[@"company"];
            address.postcode = addressDict[@"postcode"];
            address.city = addressDict[@"city"];
            address.user_id = userId;
        }
    }
    
    NSError *error = nil;
    
    if (![moc save:&error]) {
        NSLog(@"Error %@", [error localizedDescription]);
    }
    else {
        NSLog(@"Sucessfully Saved Sub Categories");
    }
}

+ (NSArray *)fetchItemsFromTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate {
    
    NSManagedObjectContext *moc = [[DatabaseManager sharedInstance] managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:moc];
    [request setEntity:entity];
    
    if (predicate != nil) [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *items = [moc executeFetchRequest:request error:&error];
    
    return items;
}

+ (void)deleteItemsFromTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate {
    
    
    NSManagedObjectContext *mainMOC = [[DatabaseManager sharedInstance] mainManagedObjectContext];
    NSArray *items = [self fetchItemsFromTable:tableName withPredicate:predicate];
    
    for (NSManagedObject *object in items) {
        [mainMOC deleteObject:object];
    }
    
    [mainMOC performBlockAndWait:^{
        
        NSError *error = nil;
        
        if (![mainMOC save:&error]) {
            NSLog(@"Error %@", [error localizedDescription]);
        }
        else {
            NSLog(@"Sucessfully Deleted items");
        }
    }];
}

+ (void)deleteItemsFromTableWithDictionary:(NSDictionary *)dictionaryObj {
    
    NSString *tableName = dictionaryObj[@"tableName"];
    NSPredicate *predicate = dictionaryObj[@"predicate"];
    
    NSManagedObjectContext *mainMOC = [[DatabaseManager sharedInstance] mainManagedObjectContext];
    NSArray *items = [self fetchItemsFromTable:tableName withPredicate:predicate];
    
    for (NSManagedObject *object in items) {
        [mainMOC deleteObject:object];
    }
    
    [mainMOC performBlockAndWait:^{
        
        NSError *error = nil;
        
        if (![mainMOC save:&error]) {
            NSLog(@"Error %@", [error localizedDescription]);
        }
        else {
            NSLog(@"Sucessfully Deleted items");
        }
    }];
}

+ (void)insertProductsDetails:(NSArray*)productsCollection forParentCategory:(NSNumber *)parentCategoryId{
    
    NSManagedObjectContext *privateMOC = [[DatabaseManager sharedInstance] privateManagedObjectContext];
    
    for (NSDictionary *dict in productsCollection) {
        @autoreleasepool {
            Products *products = nil;
            
            products = [NSEntityDescription insertNewObjectForEntityForName:TABLE_PRODUCTS inManagedObjectContext:privateMOC];
            
            products.category_id = parentCategoryId;
            products.ean = dict[@"ean"];
            products.height = [NSNumber numberWithDouble: [dict[@"height"] doubleValue]];
            products.thumb_image_url = dict[@"image"];
            products.jan = dict[@"jan"];
            products.isbn = dict[@"isbn"];
            products.location = dict[@"location"];
            products.model = dict[@"model"];
            products.mpn = dict[@"mpn"];
            products.name = dict[@"name"];
            products.sku = dict[@"sku"];
            products.upc = dict[@"upc"];
            
            products.points = [NSNumber numberWithInt:[dict[@"points"] intValue]];
            products.product_id = [NSNumber numberWithInt:[dict[@"product_id"] intValue]];
            products.viewed = [NSNumber numberWithInt:[dict[@"viewed"] intValue]];
            
            products.length = [NSNumber numberWithDouble: [dict[@"length"] doubleValue]];
            products.weight = [NSNumber numberWithDouble: [dict[@"weight"] doubleValue]];
            products.width = [NSNumber numberWithDouble: [dict[@"width"] doubleValue]];
            products.price = [NSNumber numberWithDouble: [dict[@"price"] doubleValue]];
        }
    }
    
    if ([privateMOC hasChanges]) {
        [privateMOC performBlockAndWait:^{
            NSError *error = nil;
            
            if (![privateMOC save:&error]) {
                NSLog(@"Error %@", [error localizedDescription]);
            }
            else {
                NSLog(@"Sucessfully Saved Banner Images");
            }
        }];
    }
}

+ (void)updateProductDetailswithProductID:(int)productID
                       andIsLatestArrival:(BOOL)latestArrival
                            andCategoryID:(int)categoryID withData:(NSDictionary*)dictionaryData{
    
    NSManagedObjectContext *moc = [[DatabaseManager sharedInstance] managedObjectContext];
    NSPredicate *predicate;
    NSString *tableName=@"";
    if (latestArrival) {
        
        predicate = [NSPredicate predicateWithFormat:@"product_id == %@", [NSNumber numberWithInt:productID]];
        tableName = TABLE_LATEST_ARRIVALS_PROMOTIONS;

    }
    else {
        predicate = [NSPredicate predicateWithFormat:@"category_id == %@ && product_id == %@", [NSNumber numberWithInt:categoryID], [NSNumber numberWithInt:productID]];

        tableName = TABLE_PRODUCTS;

    }
    NSArray *results = [DatabaseHandler fetchItemsFromTable:tableName withPredicate:predicate];
    Products* products = (Products*)[results lastObject];
    if (products) {
        
        @autoreleasepool {
            
            Product_Details *prodDetails = [NSEntityDescription insertNewObjectForEntityForName:TABLE_PRODUCTS_DETAILS inManagedObjectContext:moc];
            prodDetails.date_available = [NSString getActualValue:dictionaryData[@"date_available"]];
            prodDetails.detailedInfo = [NSString getActualValue:dictionaryData[@"description"]];
            prodDetails.image = [NSString getActualValue:dictionaryData[@"image"]];
            prodDetails.manufacturer = [NSString getActualValue:dictionaryData[@"manufacturer"]];
            prodDetails.quantity =[NSNumber numberWithInt:[dictionaryData[@"quantity"] intValue]];
            prodDetails.rating =[NSNumber numberWithInt:[dictionaryData[@"rating"] intValue]];
            prodDetails.reviews = [NSNumber numberWithInt:[dictionaryData[@"reviews"] intValue]];
            prodDetails.reward = [NSNumber numberWithInt:[dictionaryData[@"reward"] intValue]];
            prodDetails.stock_status = [NSString getActualValue:dictionaryData[@"stock_status"]];

            NSArray *_attributes = dictionaryData[@"attributes"];
            if ([_attributes count]>0) {
                
                for (NSDictionary *attributeInfo in _attributes) {
                    
                    Product_Attributes *product_attribute = [NSEntityDescription insertNewObjectForEntityForName:TABLE_PRODUCTS_ATTRIBUTES inManagedObjectContext:moc];
                    product_attribute.attributeName = attributeInfo[@"name"];
                    product_attribute.attributeKey =[attributeInfo[@"attribute"] lastObject][@"name"];
                    product_attribute.attributeValue =[attributeInfo[@"attribute"] lastObject][@"text"];
                    [prodDetails removeRelationshipObject:product_attribute];
                    [prodDetails addRelationshipObject:product_attribute];
                }
            }
            products.relationship = prodDetails;
        }
        
        [moc performBlockAndWait:^{
            NSError *error = nil;
            
            if (![moc save:&error]) {
                NSLog(@"Error %@", [error localizedDescription]);
            }
            else {
                NSLog(@"Sucessfully Saved Products");
            }
        }];
    }
}

+ (void)addToCartWithObj:(id)item {
    
    NSManagedObjectContext *moc = [[DatabaseManager sharedInstance] managedObjectContext];
    NSPredicate *predicate;
    LatestArrivals_Promotions *latestArrivals=nil;
    Products *product=nil;
    if ([item isKindOfClass:[Products class]]) {
    
        product = (Products*)item;
        predicate = [NSPredicate predicateWithFormat:@"category_id == %@ && product_id == %@", product.category_id, product.product_id];
        

    }
    else {
        
        latestArrivals = (LatestArrivals_Promotions*)item;
        predicate = [NSPredicate predicateWithFormat:@"product_id == %@", latestArrivals.product_id];
        

    }

    NSArray *cartItems = [DatabaseHandler fetchItemsFromTable:TABLE_CART withPredicate:predicate];
    Cart *cart = nil;
    
    if ([cartItems count]) {
        cart = [cartItems lastObject];
        int count = [cart.count intValue] + 1;
        cart.count = [NSNumber numberWithInt:count];
    }
    else {
        cart = [NSEntityDescription insertNewObjectForEntityForName:TABLE_CART inManagedObjectContext:[[DatabaseManager sharedInstance] managedObjectContext]];
        
        cart.category_id = product?product.category_id:0;
        cart.price = product?product.price:[HelperClass getNSNumberFromString:latestArrivals.price];
        cart.product_id = product?product.product_id:latestArrivals.product_id;
        cart.model = product?product.model:latestArrivals.model;
        cart.name = product?product.name:latestArrivals.name;
        cart.thumb_image_url = product?product.thumb_image_url:latestArrivals.thumb_image_url;;
        cart.count = [NSNumber numberWithInt:1];
    }
    
    NSError *error = nil;
    
    if (![moc save:&error]) {
        NSLog(@"Error %@", [error localizedDescription]);
    }
    else {
        NSLog(@"Sucessfully Saved Products");
    }
}

+ (void)addToAddressWithDict:(NSMutableDictionary *)addressDict {
    
    NSManagedObjectContext *moc = [[DatabaseManager sharedInstance] managedObjectContext];
    
    Address *address = nil;
    address = [NSEntityDescription insertNewObjectForEntityForName:TABLE_ADDRESS inManagedObjectContext:moc];
    
    address.firstname = addressDict[@"firstname"];
    address.lastname = addressDict[@"lastname"];
    address.company = addressDict[@"company"];
    address.address_1 = addressDict[@"address_1"];
    address.address_2 = addressDict[@"address_2"];
    address.city = addressDict[@"city"];
    address.postcode = addressDict[@"postcode"];
    address.is_billingaddress = addressDict[@""];
    address.user_id = addressDict[@""];
    address.address_id = addressDict[@"address_id"];
    
    NSError *error = nil;
    
    if (![moc save:&error]) {
        NSLog(@"Error %@", [error localizedDescription]);
    }
    else {
        NSLog(@"Sucessfully Saved Products");
    }
}

@end
