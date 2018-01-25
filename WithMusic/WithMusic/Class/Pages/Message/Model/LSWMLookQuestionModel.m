//
//  LSWMLookQuestionModel.m
//  WithMusic
//
//  Created by Facebook on 2018/1/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMLookQuestionModel.h"

@implementation LSWMLookQuestionModel
+ (instancetype)messageWithContent:(NSDictionary *)content {
    
    LSWMLookQuestionModel *text = [[LSWMLookQuestionModel alloc] init];
    if (text) {
        text.content =convertToString(content[@"content"]);
        text.imageUrl =convertToString(content[@"imageUrl"]);
        text.extra =convertToString(content[@"extra"]);
        text.title =convertToString(content[@"title"]);
        text.duration =convertToString(content[@"duration"]).floatValue;
        text.price =convertToString(content[@"price"]);
        text.type =[convertToString(content[@"type"])integerValue];
        text.durationStr =convertToString(content[@"durationStr"]);
        text.questionId =convertToString(content[@"questionId"]);
        text.receiveId =convertToString(content[@"receiveId"]);
        text.send_Id =convertToString(content[@"send_Id"]);
        text.fileUrl =convertToString(content[@"fileUrl"]);
        text.tipTile =convertToString(content[@"tipTile"]);
    }
    return text;
}

///消息是否存储，是否计入未读数
+ (RCMessagePersistent)persistentFlag {
    return (MessagePersistent_ISPERSISTED | MessagePersistent_ISCOUNTED);
}

/// NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.content = convertToString([aDecoder decodeObjectForKey:@"content"]);
        self.extra = convertToString([aDecoder decodeObjectForKey:@"extra"]);
        self.imageUrl = convertToString([aDecoder decodeObjectForKey:@"imageUrl"]);
        self.title = convertToString([aDecoder decodeObjectForKey:@"title"]);
        self.duration = convertToString([aDecoder decodeObjectForKey:@"duration"]).floatValue;
        self.price = convertToString([aDecoder decodeObjectForKey:@"price"]);
        self.type = [convertToString([aDecoder decodeObjectForKey:@"type"]) integerValue];
        
        self.durationStr = convertToString([aDecoder decodeObjectForKey:@"durationStr"]);
        self.questionId = convertToString([aDecoder decodeObjectForKey:@"questionId"]);
        self.receiveId = convertToString([aDecoder decodeObjectForKey:@"receiveId"]);
        self.send_Id = convertToString([aDecoder decodeObjectForKey:@"send_Id"]);
        self.fileUrl = convertToString([aDecoder decodeObjectForKey:@"fileUrl"]);
        self.tipTile = convertToString([aDecoder decodeObjectForKey:@"tipTile"]);
        
    }
    return self;
}

/// NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:convertToString(self.content) forKey:@"content"];
    [aCoder encodeObject:convertToString(self.tipTile) forKey:@"tipTile"];
    [aCoder encodeObject:convertToString(self.extra) forKey:@"extra"];
    [aCoder encodeObject:convertToString(self.imageUrl) forKey:@"imageUrl"];
    [aCoder encodeObject:convertToString(self.title) forKey:@"title"];
    [aCoder encodeObject:@(self.duration) forKey:@"duration"];
    [aCoder encodeObject:convertToString(self.price) forKey:@"price"];
    [aCoder encodeObject:@(self.type) forKey:@"type"];
    
    [aCoder encodeObject:convertToString(self.durationStr) forKey:@"durationStr"];
    [aCoder encodeObject:convertToString(self.questionId) forKey:@"questionId"];
    [aCoder encodeObject:convertToString(self.receiveId) forKey:@"receiveId"];
    [aCoder encodeObject:convertToString(self.send_Id) forKey:@"send_Id"];
    [aCoder encodeObject:convertToString(self.fileUrl) forKey:@"fileUrl"];
}

///将消息内容编码成json
- (NSData *)encode {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:convertToString(self.content) forKey:@"content"];
    [dataDict setObject:convertToString(self.imageUrl) forKey:@"imageUrl"];
    [dataDict setObject:convertToString(self.title) forKey:@"title"];
    [dataDict setObject:@(self.duration) forKey:@"duration"];
    [dataDict setObject:convertToString(self.price) forKey:@"price"];
    [dataDict setObject:@(self.type) forKey:@"type"];
    [dataDict setObject:convertToString(self.tipTile) forKey:@"tipTile"];
    [dataDict setObject:convertToString(self.durationStr) forKey:@"durationStr"];
    [dataDict setObject:convertToString(self.questionId) forKey:@"questionId"];
    [dataDict setObject:convertToString(self.receiveId) forKey:@"receiveId"];
    [dataDict setObject:convertToString(self.send_Id) forKey:@"send_Id"];
    [dataDict setObject:convertToString(self.fileUrl) forKey:@"fileUrl"];
    if (self.extra) {
        [dataDict setObject:convertToString(self.extra) forKey:@"extra"];
    }
    if (self.senderUserInfo) {
        NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] init];
        
        if (self.senderUserInfo.name) {
            [userInfoDic setObject:convertToString(self.senderUserInfo.name)
                 forKeyedSubscript:@"name"];
        }
        if (self.senderUserInfo.portraitUri) {
            [userInfoDic setObject:convertToString(self.senderUserInfo.portraitUri)
                 forKeyedSubscript:@"icon"];
        }
        if (self.senderUserInfo.userId) {
            [userInfoDic setObject:convertToString(self.senderUserInfo.userId)
                 forKeyedSubscript:@"id"];
        }
        [dataDict setObject:userInfoDic forKey:@"user"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataDict
                                                   options:kNilOptions
                                                     error:nil];
    return data;
}

///将json解码生成消息内容
- (void)decodeWithData:(NSData *)data {
    if (data) {
        __autoreleasing NSError *error = nil;
        
        NSDictionary *dictionary =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:kNilOptions
                                          error:&error];
        
        if (dictionary) {
            self.tipTile = convertToString(dictionary[@"tipTile"]);
            self.content = convertToString(dictionary[@"content"]);
            self.extra =convertToString( dictionary[@"extra"]);
            self.imageUrl =convertToString(dictionary[@"imageUrl"]);
            self.type =[convertToString(dictionary[@"type"]) integerValue];
            self.title =convertToString(dictionary[@"title"]);
            self.duration =[convertToString(dictionary[@"duration"]) floatValue];
            self.price =convertToString(dictionary[@"price"]);
            NSDictionary *userinfoDic = dictionary[@"user"];
            self.durationStr = convertToString(dictionary[@"durationStr"]);
            self.questionId =convertToString( dictionary[@"questionId"]);
            self.receiveId =convertToString(dictionary[@"receiveId"]);
            self.send_Id =convertToString(dictionary[@"send_Id"]);
            self.fileUrl =convertToString(dictionary[@"fileUrl"]);
            [self decodeUserInfo:userinfoDic];
        }
    }
}
/// 会话列表中显示的摘要
- (NSString *)conversationDigest {
    
    return ReplyQuestionMessageDisPlayContent;
}

///消息的类型名
+ (NSString *)getObjectName {
    return ReplyQuestionMessageTypeIdentifier;
}

@end
