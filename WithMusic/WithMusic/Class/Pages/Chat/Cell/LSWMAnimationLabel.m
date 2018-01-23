//
//  LSWMAnimationLabel.m
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMAnimationLabel.h"

@implementation LSWMAnimationLabel

-(instancetype)init{
    
    self =[super init];
    
    if (self) {
        
        [self StartWithDuration: 1.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self StopWithDuration: 1.5];
            
        });
        
    }
    return self;
    
}

-(void)StartWithDuration: (NSTimeInterval) duringTime{
    
    __weak typeof(self) weakSelf = self;
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration: duringTime delay: 0.4 options: 0 animations: ^{
        
        [UIView addKeyframeWithRelativeStartTime: 0
                                relativeDuration: 1 / 3.0
                                      animations: ^{
                                          typeof(self) strongSelf = weakSelf;
                                          strongSelf.transform = CGAffineTransformMakeScale(1.5, 1.5);
                                      }];
        [UIView addKeyframeWithRelativeStartTime: 1 / 3.0
                                relativeDuration: 1 / 3.0
                                      animations: ^{
                                          typeof(self) strongSelf = weakSelf;
                                          strongSelf.transform = CGAffineTransformMakeScale(0.8, 0.8);
                                      }];
        [UIView addKeyframeWithRelativeStartTime: 2 / 3.0
                                relativeDuration: 1 / 3.0
                                      animations: ^{
                                          typeof(self) strongSelf = weakSelf;
                                          strongSelf.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                      }];
    } completion: ^(BOOL finished) {
        
    }];
    
    
}
- (void) StopWithDuration: (NSTimeInterval) duringTime {
    __weak typeof(self) weakSelf = self;
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration: duringTime delay: 0.5 options: 0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime: 0
                                relativeDuration: 1 / 2.0
                                      animations: ^{
                                          typeof(self) strongSelf = weakSelf;
                                          strongSelf.transform = CGAffineTransformMakeScale(0.8, 0.8);
                                      }];
        [UIView addKeyframeWithRelativeStartTime: 1 / 2.0
                                relativeDuration: 1 / 2.0
                                      animations: ^{
                                          typeof(self) strongSelf = weakSelf;
                                          strongSelf.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                      }];
    } completion: ^(BOOL finished) {
        
    }];
    
}

@end
