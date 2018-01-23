//
//  LSWMGiftModel.m
//  WithMusic
//
//  Created by Facebook on 2018/1/22.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMGiftModel.h"

@implementation LSWMGiftModel

+ (instancetype)messageWithContent:(NSDictionary *)content {
    
    LSWMGiftModel *text = [[LSWMGiftModel alloc] init];
    if (text) {
        text.content =content[@"content"];
        text.imageUri =content[@"imageUri"];
        text.extra =content[@"extra"];
        text.giftname =content[@"giftname"];
        text.price =content[@"price"];
    }
    return text;
}

+ (RCMessagePersistent)persistentFlag {
    return (MessagePersistent_ISPERSISTED | MessagePersistent_ISCOUNTED);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.extra = [aDecoder decodeObjectForKey:@"extra"];
        self.imageUri = [aDecoder decodeObjectForKey:@"imageUri"];
        self.giftname = [aDecoder decodeObjectForKey:@"giftname"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.extra forKey:@"extra"];
    [aCoder encodeObject:self.imageUri forKey:@"imageUri"];
    [aCoder encodeObject:self.giftname forKey:@"giftname"];
    [aCoder encodeObject:self.price forKey:@"price"];
}

///将消息内容编码成json
- (NSData *)encode {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:self.content forKey:@"content"];
    [dataDict setObject:self.imageUri forKey:@"imageUri"];
    [dataDict setObject:self.price forKey:@"price"];
    [dataDict setObject:self.giftname forKey:@"giftname"];
    if (self.extra) {
        [dataDict setObject:self.extra forKey:@"extra"];
    }
    
    if (self.senderUserInfo) {
        NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] init];
        if (self.senderUserInfo.name) {
            [userInfoDic setObject:self.senderUserInfo.name
                 forKeyedSubscript:@"name"];
        }
        if (self.senderUserInfo.portraitUri) {
            [userInfoDic setObject:self.senderUserInfo.portraitUri
                 forKeyedSubscript:@"icon"];
        }
        if (self.senderUserInfo.userId) {
            [userInfoDic setObject:self.senderUserInfo.userId
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
            self.content = dictionary[@"content"];
            self.extra = dictionary[@"extra"];
            self.imageUri =dictionary[@"imageUri"];
            self.giftname =dictionary[@"giftname"];
            self.price =dictionary[@"price"];
            NSDictionary *userinfoDic = dictionary[@"user"];
            [self decodeUserInfo:userinfoDic];
        }
    }
}

/// 会话列表中显示的摘要
- (NSString *)conversationDigest {
    return self.content;
}

///消息的类型名
+ (NSString *)getObjectName {
    
    return APPGiftMessageTypeIdentifier;
}

@end

