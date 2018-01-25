//
//  LSWMLookQuestionModel.h
//  WithMusic
//
//  Created by Facebook on 2018/1/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ReplyQuestionMessageTypeIdentifier @"WM:LookMsg"
#define  ReplyQuestionMessageDisPlayContent @"[留言提问-导师查看提问题]"


typedef NS_ENUM(NSUInteger, QuestionType) {
    QuestionTypeVideo,
    QuestionTypeVoice,
};

@interface LSWMLookQuestionModel : RCMessageContent<NSCoding>
@property(nonatomic,assign)QuestionType type;
/*!
 消息名字
 */
@property(nonatomic, strong) NSString *tipTile;

/*!
 消息的内容
 */
@property(nonatomic, strong) NSString *content;
/*!
 图片的地址
 */
@property(nonatomic,strong)NSString *imageUrl;
/*!
 消息的附加信息
 */
@property(nonatomic, strong) NSString *extra;
/*!
 消息名字
 */
@property(nonatomic, strong) NSString *title;
/*!
 价格
 */
@property(nonatomic, strong) NSString *price;
/*!
 视频时长
 */
@property(nonatomic, assign) CGFloat duration;

/*!
 视频时长
 */
@property(nonatomic, strong) NSString *durationStr;
/*!
 问题ID
 */
@property(nonatomic, strong) NSString *questionId;
/*!
 
 */
@property(nonatomic, strong) NSString *receiveId;
/*!
 发送ID
 */
@property(nonatomic, strong) NSString *send_Id;

/*!
 fileUrl
 */
@property(nonatomic, strong) NSString *fileUrl;

/*!
 初始化消息
 
 */
+ (instancetype)messageWithContent:(NSDictionary *)content;

@end
