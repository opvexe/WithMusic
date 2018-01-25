//
//  NSString+LSWM.m
//  WithMusic
//
//  Created by Facebook on 2018/1/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NSString+LSWM.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (LSWM)

BOOL is_null(id object) {
    
    return (nil == object || [@"" isEqual:object] || [object isKindOfClass:[NSNull class]]);
}


NSString *convertToString(id object){
    if ([object isKindOfClass:[NSNull class]]) {
        return @"";
    }else if(!object){
        return @"";
    }else if([object isKindOfClass:[NSNumber class]]) {
        return [object stringValue];
    }else{
        return [NSString stringWithFormat:@"%@",object];
    }
}

@end
