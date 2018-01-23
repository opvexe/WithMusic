//
//  LSWMUserDataSocure.h
//  WithMusic
//
//  Created by Facebook on 2018/1/22.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSWMModel.h"
#define UserDataSocure [LSWMUserDataSocure shareInstance]

@interface LSWMUserDataSocure : NSObject<RCIMUserInfoDataSource, RCIMGroupInfoDataSource, RCIMGroupUserInfoDataSource, RCIMGroupMemberDataSource>

/*  初始化
*
*  @return LSWMUserDataSocure
*/
+ (LSWMUserDataSocure *)shareInstance;

/**
 *  更新用户信息
 *
 *  @param userInfo 用户信息 json
 */
-(void)updateUserInfor:(id)userInfo;

/**
 *  获取本地用户信息
 *
 *  @return return 用户信息
 */
-(LSWMModel *)getInstance;

@end
