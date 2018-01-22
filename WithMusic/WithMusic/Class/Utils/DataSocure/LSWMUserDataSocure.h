//
//  LSWMUserDataSocure.h
//  WithMusic
//
//  Created by Facebook on 2018/1/22.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UserDataSocure [LSWMUserDataSocure shareInstance]

@interface LSWMUserDataSocure : NSObject<RCIMUserInfoDataSource, RCIMGroupInfoDataSource, RCIMGroupUserInfoDataSource, RCIMGroupMemberDataSource>

/*  初始化
*
*  @return LSWMUserDataSocure
*/
+ (LSWMUserDataSocure *)shareInstance;

@end
