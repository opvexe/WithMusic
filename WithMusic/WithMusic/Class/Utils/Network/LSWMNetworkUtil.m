//
//  LSWMNetworkUtil.m
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMNetworkUtil.h"

@implementation LSWMNetworkUtil



+(void)GetTokenWithUserID:(NSString *)userId username:(NSString *)username headurl:(NSString *)headurl success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:0];
    [parameters setValue:userId forKey:@"userId"];
    [parameters setValue:username forKey:@"username"];
    [parameters setValue:headurl forKey:@"headurl"];
    
    [[AFHTTPSessionManager shareManager] POST:GetTokentAuthenticationURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
