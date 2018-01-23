//
//  AFHTTPSessionManager+Category.m
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "AFHTTPSessionManager+Category.h"

@implementation AFHTTPSessionManager (Category)

static AFHTTPSessionManager *manager = nil;

+(AFHTTPSessionManager *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [AFHTTPSessionManager manager];
            
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            manager.requestSerializer.timeoutInterval = 10.0f;
            manager.responseSerializer.stringEncoding = NSUTF8StringEncoding;
            
            AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
            securityPolicy.allowInvalidCertificates = YES;
            manager.securityPolicy = securityPolicy;
            [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml", @"image/*"]];

            manager.operationQueue.maxConcurrentOperationCount = 3;
        }
        
    });
    return manager;
}


@end

