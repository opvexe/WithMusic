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

#endif /* LSThirdLibKeyDefines_h */
