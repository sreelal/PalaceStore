//
//  NSString+HTML.h
//  PalaceStore
//
//  Created by Sreelash S on 28/07/15.
//  Copyright (c) 2015 Sreelal  Hamsavahanan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HTML)

+ (NSString *)stringByConvertingHTMLToPlainTextWith:(NSString *)string;
+ (NSString*) decodeHtmlUnicodeCharactersToString:(NSString*)str;

@end
