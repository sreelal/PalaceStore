//
//  Constants.h
//  DeviceGH
//
//  Created by Sreelash S on 15/12/14.
//  Copyright (c) 2014 Sreelal H. All rights reserved.
//

#ifndef DeviceGH_Constants_h
#define DeviceGH_Constants_h


#endif

//------------------Webservice----------------------
//#define SERVICE_URL_ROOT     @"http://ezcomdesign.com/demo/palace/index.php?route=service/"
#define SERVICE_URL_ROOT     @"http://www.palacestores.com/index.php?route=service/"
#define SERVICE_HOME         @"home"
#define SERVICE_CATEGORY     @"category"
#define SERVICE_SUB_CATEGORY @"category&category="
#define SERVICE_PRODUCT      @"product&category="
#define SERVICE_PRODUCT_INFO @"product/info&product="
#define SERVICE_BANNER       @"banner&banner=7"
#define SERVICE_POST_TOKEN   @"device/register"
#define SERVICE_NOTIFICATION @"notification"
#define SERVICE_ENQUIRY      @"enquiry/submit"
#define SEARCH_PRODUCT       @"product/search&search="
#define SERVICE_FOOTER_TXT   @"status/text"
#define SERVICE_PRODUCT_DETAIL  @"product/detail&product="
//--------------------------------------------------

//-----------------CoreData Model---------------------
#define TABLE_BANNER_IMAGES @"Banner_Images"
#define TABLE_LATEST_ARRIVALS_PROMOTIONS @"LatestArrivals_Promotions"
#define TABLE_PRODUCT_CATEGORY @"Product_Category"
#define TABLE_PRODUCTS @"Products"
#define TABLE_CART @"Cart"
#define TABLE_PRODUCTS_DETAILS @"Product_Details"
#define TABLE_PRODUCTS_ATTRIBUTES @"Product_Attributes"


//----------------------------------------------------

//------------------Dictionary Keys-----------------
#define KEY_BANNER_IMAGES @"banner_images"
#define KEY_LATEST_ARRIVALS @"latest"
#define KEY_PROMOIONS @"promotions"
#define KEY_CATEGORIES @"categories"

#define KEY_BANNER_IMAGE_URL @"image"
#define KEY_TITLE @"title"

#define KEY_PROD_DESCRIPTION @"description"
#define KEY_PROD_ID @"product_id"
#define KEY_NAME @"name"
#define KEY_PRICE @"price"
#define KEY_RATING @"rating"
#define KEY_TAX @"tax"
#define KEY_THUMB_URL @"thumb"

#define CATEGORY_ID @"category_id"
#define NAME @"name"
#define CHILDREN @"children"
#define IMAGE @"image"
#define SORT_ORDER @"sort_order"
#define KEY_ENQUIRE_PRODUCTS @"enquire_products"
#define KEY_DEVICE_TOKEN     @"DeviceToken"
#define KEY_FOOTER           @"Footer"
//--------------------------------------------------

//-----------------Soryboard Ids--------------------
#define STORYBOARD_ID_MENUVC @"leftMenuViewController"
//--------------------------------------------------


//-----------------Notification Names---------------
#define NOTIFICATION_REFRESH_MENU @"refresh left menu"
//--------------------------------------------------

//-----------------TableViewCell Identifiers----------
#define CELL_ID_MENU_HEADER   @"MenuHeader"
#define CELL_ID_SUB_MENU      @"SubMenu"
#define CELL_ID_NOTIFICATION  @"NotificationCell"
//----------------------------------------------------

//-----------------Helper Class Constants-------------
#define CACHE_ID_HOME         @"Home"
#define CACHE_ID_SUB_CATEGORY @"Category_"
#define CACHE_ID_CATEGORY_PRO @"Category_Product_"
#define CACHE_ID_PRODUCT      @"Product_"
#define CACHE_ID_CATEGORY     @"Category.json"
#define CACHE_ID_NOTIFICA     @"Notification.json"
#define CACHE_ID_BANNER       @"Banner.json"
#define CACHE_ID_EXTENSION    @".json"
#define CACHE_ID_FOOTER       @"Footer.txt"
//----------------------------------------------------

//-----------------------Alert Messages---------------
#define ALERT_OK @"OK"
#define ALERT_INTERNET_FAILURE @"Network not available."
#define ALERT_NO_SEARCH_RESULT @"No products found with the given search key."
//----------------------------------------------------

//-----------------------View Titles------------------
#define VIEW_TITLE_ABOUT   @"About Us"
#define VIEW_TITLE_WEEKLY  @"Weekly Promotions"
#define VIEW_TITLE_MONTHLY @"Monthly Promotions"
//----------------------------------------------------

//---------------------Color hex Code-----------------
#define COLOR_HEX_LIGHT_GRAY @"#e9e9e9"
//----------------------------------------------------

#define CacheDirectory     [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]