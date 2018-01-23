//
//  LSWMChatViewController.h
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSWMChatViewController : RCConversationViewController

/*!
 *  会话数据模型
 */
@property(strong, nonatomic) RCConversationModel *conversation;
@end
