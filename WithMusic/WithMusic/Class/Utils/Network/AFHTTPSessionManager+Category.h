//
//  AFHTTPSessionManager+Category.h
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSessionManager (Category)


/**
 AFHTTPSessionManager单例
 
 @return AFHTTPSessionManager
 */
+ (AFHTTPSessionManager *)shareManager;

@end
