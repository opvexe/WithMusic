//
//  LSWMAnimationLabel.h
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSWMAnimationLabel : UILabel

/*!
 * 开始动画
 */
-(void)StartWithDuration: (NSTimeInterval) duringTime;
/*!
 * 结束动画
 */
- (void) StopWithDuration: (NSTimeInterval) duringTime;

@end
