//
//  LSWMGiftTableViewCell.h
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSWMAnimationLabel.h"

@interface LSWMGiftTableViewCell : RCMessageCell

@property(nonatomic, strong) FLAnimatedImageView *gifImageView;

@property(nonatomic,strong)UILabel *contenLabel;

@property(nonatomic,strong)LSWMAnimationLabel *tipLabel;
@end
