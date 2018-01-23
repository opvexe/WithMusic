//
//  LSWMModel.h
//  WithMusic
//
//  Created by Facebook on 2018/1/22.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SexType) {
    /*！
     男
     */
    SexTypeMan = 1,
    /*！
     女
     */
    SexTypeWoman = 2,
};


@interface LSWMModel : NSObject

/**
 ID
 */
@property (nonatomic,copy) NSString *ID;

/**
 昵称
 */
@property (nonatomic,copy) NSString *nickname;

/**
 头像
 */
@property (nonatomic,copy) NSString *head_img;

/**
 年龄
 */
@property (nonatomic,copy) NSString *age;

/**
 性别 1：男  2：女
 */
@property (nonatomic,assign) SexType sex;
@end

