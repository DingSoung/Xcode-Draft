//
//  Vendors-Header.h
//  Test
//
//  Created by Alex D. on 11/25/15.
//  Copyright © 2015 ifnil. All rights reserved.
//

#ifndef Vendors_Header_h
#define Vendors_Header_h

#ifdef  USE_AFNETWORKING
#import <AFNetworking/AFNetworking.h>
#endif

#ifdef  USE_REACTIVECOCOA
#import <ReactiveCocoa/ReactiveCocoa.h>
#endif

#ifdef  USE_SDWEBIMAGE
#import "SDWebImageManager.h"   //need ImageIO.framework MapKit.framework
#import "UIImageView+WebCache.h"
#endif

#ifdef  USE_WECHAT
#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WXApiObject.h"
#endif

#ifdef  USE_QINIU
#import <Qiniu/QiniuSDK.h>
#endif

#ifdef  USE_DDXML
#import "DDXML.h"                        //header search path add ${SDK_DIR}/usr/include/libxml2
#import "DDXMLElementAdditions.h"
#endif

#ifdef  USE_UMSOCIAL
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import <CoreLocation/CoreLocation.h>
//SystemConfiguration.framework CoreTelephony.framework libsqlite3.dylib ，libz.dylib, libc++.dylib
#endif

#ifdef  USE_UMANALYTICS
#import "MobClick.h"
#endif

//UICKeyChainStore

#endif /* Vendors_Header_h */
