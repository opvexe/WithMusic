//
//  LSWMTools.m
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMTools.h"

@implementation LSWMTools


+ (UIImage *)getImageWithColor:(UIColor *)color andHeight:(CGFloat)height {
    CGRect r = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
