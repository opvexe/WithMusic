//
//  AppDelegate.m
//  WithMusic
//
//  Created by Facebook on 2018/1/22.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+LSWMCategory.h"
#import "LSWMModel.h"

@interface AppDelegate ()<RCIMConnectionStatusDelegate,RCIMUserInfoDataSource,RCIMReceiveMessageDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]init];
    
    self.window.frame = [UIScreen mainScreen].bounds;
    
    [self switchRootController];
    
    [self.window makeKeyAndVisible];
    
    application.statusBarHidden = NO;
    
    
    [self registrationThirdLib];
    [self application:application Options:launchOptions];
    
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveMessageNotification:) name:RCKitDispatchMessageNotification object:nil];
    
    return YES;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    NSNumber *left = [notification.userInfo objectForKey:@"left"];
    if ([RCIMClient sharedRCIMClient].sdkRunningMode == RCSDKRunningMode_Background && 0 == left.integerValue) {
        int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                             @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE),
                                                                             @(ConversationType_PUBLICSERVICE), @(ConversationType_GROUP)
                                                                             ]];
        dispatch_async(dispatch_get_main_queue(),^{
            [UIApplication sharedApplication].applicationIconBadgeNumber = unreadMsgCount;
        });
    }
}

#pragma mark - RCIMConnectionStatusDelegate
/*!
 * 获取用户信息
 */
-(void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    NSLog(@"请求自己服务器获取用户信息");
    LSWMModel *model = [[LSWMModel alloc]init];
    RCUserInfo *user = [[RCUserInfo alloc] initWithUserId:model.ID name:model.nickname portrait:model.head_img];
    [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:user.userId];
}

- (BOOL)onRCIMCustomLocalNotification:(RCMessage *)message withSenderName:(NSString *)senderName {
    //群组通知不弹本地通知
    if ([message.content isKindOfClass:[RCGroupNotificationMessage class]]) {
        return YES;
    }
    if ([[message.content.class getObjectName] isEqualToString:@"RCJrmf:RpOpendMsg"]) {
        return YES;
    }
    return NO;
}

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:
                              @"您的帐号在别的设备上登录，"
                              @"您被迫下线！"
                              delegate:nil
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
        [[RCIM sharedRCIM] disconnect:YES];
        
    } else if (status == ConnectionStatus_TOKEN_INCORRECT) {
        
        
    } else if (status == ConnectionStatus_DISCONN_EXCEPTION) {
        [[RCIMClient sharedRCIMClient] disconnect];
        
        NSLog(@"您的帐号被封禁");
    }
}

- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    if ([message.content isMemberOfClass:[RCInformationNotificationMessage class]]) {
        RCInformationNotificationMessage *msg = (RCInformationNotificationMessage *)message.content;
        if ([msg.message rangeOfString:@"你已添加了"].location != NSNotFound) {
            
        }
    } else if ([message.content isMemberOfClass:[RCContactNotificationMessage class]]) {
        RCContactNotificationMessage *msg = (RCContactNotificationMessage *)message.content;
        if ([msg.operation isEqualToString:ContactNotificationMessage_ContactOperationAcceptResponse]) {
            
        }
    } else if ([message.content isMemberOfClass:[RCGroupNotificationMessage class]]) {
        RCGroupNotificationMessage *msg = (RCGroupNotificationMessage *)message.content;
        if ([msg.operation isEqualToString:@"Dismiss"] &&
            [msg.operatorUserId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {
            [[RCIMClient sharedRCIMClient]clearRemoteHistoryMessages:ConversationType_GROUP
                                                            targetId:message.targetId
                                                          recordTime:message.sentTime
                                                             success:^{
                                                                 [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_GROUP targetId:message.targetId];
                                                             }
                                                               error:nil
             ];
            [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_GROUP targetId:message.targetId];
        } else if ([msg.operation isEqualToString:@"Quit"] || [msg.operation isEqualToString:@"Add"] ||
                   [msg.operation isEqualToString:@"Kicked"] || [msg.operation isEqualToString:@"Rename"]) {
            if (![msg.operation isEqualToString:@"Rename"]) {
                
            }
        }
    }
}

//设置群组通知消息没有提示音
- (BOOL)onRCIMCustomAlertSound:(RCMessage *)message {
    //当应用处于前台运行，收到消息不会有提示音。
    if ([message.content isMemberOfClass:[RCGroupNotificationMessage class]]) {
        return YES;
    }
    return NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RCKitDispatchMessageNotification object:nil];
}

@end

