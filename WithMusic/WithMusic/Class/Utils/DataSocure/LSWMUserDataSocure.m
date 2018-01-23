//
//  LSWMUserDataSocure.m
//  WithMusic
//
//  Created by Facebook on 2018/1/22.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMUserDataSocure.h"

#define WithMusicLoginUserID     @"WithMusicLoginUserID"
#define  LSWMUserDefaults        [NSUserDefaults standardUserDefaults]

@implementation LSWMUserDataSocure

+ (LSWMUserDataSocure *)shareInstance {
    static LSWMUserDataSocure *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        
    });
    return instance;
}

/**
 *  更新用户信息
 *
 *  @param userInfo 用户信息 json
 */
-(void)updateUserInfor:(id)userInfo{
    if (userInfo) {
        [LSWMUserDefaults setValue:userInfo forKey:WithMusicLoginUserID];
        [LSWMUserDefaults synchronize];
    }
}

/**
 *  获取本地用户信息
 *
 *  @return return 用户信息
 */
-(LSWMModel *)getInstance{
    return [LSWMModel mj_objectWithKeyValues:[LSWMUserDefaults valueForKey:WithMusicLoginUserID]];
}

#pragma mark  RCIMUserInfoDataSource  RCIMGroupInfoDataSource RCIMGroupUserInfoDataSource  RCIMGroupMemberDataSource

/*!
 *  获取用户信息
 */

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
      if ([userId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]  ) {
           NSLog(@"开发者调用自己服务器 根据 userId 请求数据");
          RCUserInfo *userInor=  [[RCUserInfo alloc] initWithUserId:userId name:[NSString stringWithFormat:@"name_%@",userId] portrait:@"http://img2.woyaogexing.com/2017/09/08/6eb31784dc036adf%21600x600.jpg"];
          completion(userInor);
      }else{
          NSLog(@"开发者调用自己服务器 根据 userId 请求数据");
          RCUserInfo *userInor=  [[RCUserInfo alloc] initWithUserId:userId name:[NSString stringWithFormat:@"name_%@",userId] portrait:@"http://pic26.photophoto.cn/20130323/0005018467298586_b.jpg"];
          completion(userInor);
      }
}

/*!
 *  获取用户在群组中的群名片信息
 */
-(void)getUserInfoWithUserId:(NSString *)userId inGroup:(NSString *)groupId completion:(void (^)(RCUserInfo *))completion{
    if ([groupId isEqualToString:@"22"] && [userId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
        completion([[RCUserInfo alloc] initWithUserId:[RCIMClient sharedRCIMClient].currentUserInfo.userId name:@"我在22群中的名片" portrait:nil]);
    } else {
        completion(nil); //融云demo中暂时没有实现，以后会添加上该功能。app也可以自己实现该功能。
    }
}

/*!
 * 获取群组信息
 */
-(void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion{
    if ([groupId length] == 0) {
        return;
    }
    NSLog(@"开发者调用自己服务器 根据 groupId 请求数据");
}

/*!
 *  获取当前群组成员列表的回调
 */
-(void)getAllMembersOfGroup:(NSString *)groupId result:(void (^)(NSArray<NSString *> *))resultBlock{
    
    NSLog(@"App 发起请求 - 自己服务器 -- 访问融云服务器 - 融云服务器回调 ");
}


@end
