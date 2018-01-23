//
//  AppDelegate+LSWMCategory.h
//  WithMusic
//
//  Created by Facebook on 2018/1/22.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (LSWMCategory)

/*!
 *  切换根视图
 */
-(void)switchRootController;

/*!
 *  注册第三方
 */
-(void)registrationThirdLib;

/*!
 *  注册推送通知
 */
- (BOOL)application:(UIApplication *)application Options:(NSDictionary *)launchOptions;
@end
