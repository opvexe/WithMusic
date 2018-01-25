//
//  NSString+LSWM.h
//  WithMusic
//
//  Created by Facebook on 2018/1/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LSWM)

/**
 *  判断是否为空对象
 *
 *  @param object 对象
 *
 *
 */
BOOL is_null(id object);
/**
 *  根据对象转化字符串
 *
 *  @param object object description
 *
 *  @return return value description
 */
NSString *convertToString(id object);

@end
