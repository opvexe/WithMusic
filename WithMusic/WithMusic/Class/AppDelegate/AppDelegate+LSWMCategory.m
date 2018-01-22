//
//  AppDelegate+LSWMCategory.m
//  WithMusic
//
//  Created by Facebook on 2018/1/22.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "AppDelegate+LSWMCategory.h"
#import <AudioToolbox/AudioToolbox.h>
#import "LSWMGiftModel.h"

@implementation AppDelegate (LSWMCategory)

/*!
 *  切换根视图
 */
-(void)switchRootController{
    
}

/*!
 *  注册第三方
 */
-(void)registrationThirdLib{
    
    [self configRCIM];
    
}

/*! 
 *  融云
 */
-(void)configRCIM{
    
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    
    [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(46, 46);
    
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    
    [RCIM sharedRCIM].userInfoDataSource  = UserDataSocure;
    
    [RCIM sharedRCIM].groupInfoDataSource  = UserDataSocure;
    
    [[RCIM sharedRCIM] setScheme:@"rongCloudRedPacket" forExtensionModule:@"JrmfPacketManager"];        ///红包scheme
    
    [RCIM sharedRCIM].enableTypingStatus = YES;
    
    [RCIM sharedRCIM].enabledReadReceiptConversationTypeList =
    @[ @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_GROUP) ];
    
    [RCIM sharedRCIM].enableSyncReadStatus = YES;
    
    [RCIM sharedRCIM].showUnkownMessage = YES;
    
    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
    
    [RCIM sharedRCIM].enableMessageMentioned = YES;
    
    [RCIM sharedRCIM].enableMessageRecall = YES;
    
    [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Info;
    
    /*！
     * 注册自定义消息
     */
    
    [[RCIM sharedRCIM] registerMessageType:[LSWMGiftModel class]];      ///礼物消息
    
    /*！
     * 登录
     */
    [[RCIM sharedRCIM] connectWithToken:@"偏好设置获取Token"
                                success:^(NSString *userId) {
                                    NSLog(@"主控制器");
                                    
                                } error:^(RCConnectErrorCode status) {
                                    NSLog(@"登录界面");
                                    
                                } tokenIncorrect:^{
                                    NSLog(@"登录界面");
                                    
                                }];
}

- (BOOL)application:(UIApplication *)application Options:(NSDictionary *)launchOptions{
    /**
     * 推送处理1
     */
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        //注册推送，用于iOS8之前的系统
        UIRemoteNotificationType myTypes =
        UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    /**
     * 统计推送打开率1
     */
    [[RCIMClient sharedRCIMClient] recordLaunchOptionsEvent:launchOptions];
    /**
     * 获取融云推送服务扩展字段1
     */
    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromLaunchOptions:launchOptions];
    if (pushServiceData) {
        NSLog(@"该启动事件包含来自融云的推送服务");
        for (id key in [pushServiceData allKeys]) {
            NSLog(@"%@", pushServiceData[key]);
        }
    } else {
        NSLog(@"该启动事件不包含来自融云的推送服务");
    }
    
    return  YES;
}

/**
 * 推送处理2
 */
//注册用户通知设置
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}



/**
 * 推送处理3
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""]
                        stringByReplacingOccurrencesOfString:@">"
                        withString:@""] stringByReplacingOccurrencesOfString:@" "
                       withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"获取DeviceToken失败！！！");
    NSLog(@"ERROR：%@", error);
}


/**
 * 推送处理4
 * userInfo内容请参考官网文档
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    /**
     * 统计推送打开率2
     */
    [[RCIMClient sharedRCIMClient] recordRemoteNotificationEvent:userInfo];
    /**
     * 获取融云推送服务扩展字段2
     */
    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromRemoteNotification:userInfo];
    if (pushServiceData) {
        NSLog(@"该远程推送包含来自融云的推送服务");
        for (id key in [pushServiceData allKeys]) {
            NSLog(@"key = %@, value = %@", key, pushServiceData[key]);
        }
    } else {
        NSLog(@"该远程推送不包含来自融云的推送服务");
    }
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    /**
     * 统计推送打开率3
     */
    [[RCIMClient sharedRCIMClient] recordLocalNotificationEvent:notification];
    
    //震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(1007);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    RCConnectionStatus status = [[RCIMClient sharedRCIMClient] getConnectionStatus];
    if (status != ConnectionStatus_SignUp) {
        int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                             @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE),
                                                                             @(ConversationType_PUBLICSERVICE), @(ConversationType_GROUP)
                                                                             ]];
        application.applicationIconBadgeNumber = unreadMsgCount;
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    RCConnectionStatus status = [[RCIMClient sharedRCIMClient] getConnectionStatus];
    if (status != ConnectionStatus_SignUp) {
        int unreadMsgCount        = [[RCIMClient sharedRCIMClient]
                                     getUnreadCount:@[
                                                      @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE),
                                                      @(ConversationType_PUBLICSERVICE), @(ConversationType_GROUP)
                                                      ]];
        application.applicationIconBadgeNumber = unreadMsgCount;
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    if ([[RCIM sharedRCIM] openExtensionModuleUrl:url]) {
        return YES;
    }
    return YES;
}

@end

