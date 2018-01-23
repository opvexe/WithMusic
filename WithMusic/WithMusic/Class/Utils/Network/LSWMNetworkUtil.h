//
//  LSWMNetworkUtil.h
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager+Category.h"

@interface LSWMNetworkUtil : NSObject

/*！
 * 获取融云Token
 */
+(void)GetTokenWithUserID:(NSString *)userId username:(NSString *)username headurl:(NSString *)headurl success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
