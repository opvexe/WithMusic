//
//  LSWMGiftModel.h
//  WithMusic
//
//  Created by Facebook on 2018/1/22.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 * 自定义礼物消息
 */
#define APPGiftMessageTypeIdentifier @"APP:GiftMsg"

@interface LSWMGiftModel :  RCMessageContent<NSCoding>

/*!
 消息的内容
 */
@property(nonatomic, strong) NSString *content;
/*!
 图片的地址
 */
@property(nonatomic,strong)NSString *imageUri;
/*!
 消息的附加信息
 */
@property(nonatomic, strong) NSString *extra;
/*!
 消息名字
 */
@property(nonatomic, strong) NSString *giftname;

/*!
 消息价格
 */
@property(nonatomic, strong) NSString *price;
/*!
 初始化消息
 
 */
+ (instancetype)messageWithContent:(NSDictionary *)content;
@end

