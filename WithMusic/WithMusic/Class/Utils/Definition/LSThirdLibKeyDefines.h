//
//  LSThirdLibKeyDefines.h
//  WithMusic
//
//  Created by Facebook on 2018/1/22.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#ifndef LSThirdLibKeyDefines_h
#define LSThirdLibKeyDefines_h

#define RONGCLOUD_IM_APPKEY @"cpj2xarlc1qqn"


#define  PLUGIN_BOARD_ITEM_SmallVide_TAG 77777

#define  PLUGIN_BOARD_ITEM_AskTa_TAG 888888

#define  PLUGIN_BOARD_ITEM_FindClasss_TAG 99999
/**
 URL
 */
#define URLFromString(str)                      [NSURL URLWithString:str]

/**
 字符
 */
#define FormatString(string, args...)       [NSString stringWithFormat:string, args]

/**
 HOST
 */
#define HOST_API_URL @"http://47.97.7.23:8090"
/**
 验证tokent
 */
#define GetTokentAuthenticationURL      FormatString(@"%@/authentication",HOST_API_URL)


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define WSSTRONG(strongSelf) __strong typeof(weakSelf) strongSelf = weakSelf;



#define   Maser_Color  UIColorFromRGB(0xFF758C)
#define   ButtonBGColor UIColorFromRGB(0x9367ff)
#define   MainTitle_Color  UIColorFromRGB(0X323232)
#endif /* LSThirdLibKeyDefines_h */
