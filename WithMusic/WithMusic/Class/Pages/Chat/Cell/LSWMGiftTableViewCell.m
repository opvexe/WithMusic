//
//  LSWMGiftTableViewCell.m
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMGiftTableViewCell.h"
#import "LSWMGiftModel.h"
@interface LSWMGiftTableViewCell()

@end

#define GIFWIDTH           90
#define ContentHeight      20

@implementation LSWMGiftTableViewCell

+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight {
    
    CGFloat __messagecontentview_height = GIFWIDTH+ContentHeight;
    
    return CGSizeMake(collectionViewWidth,__messagecontentview_height+extraHeight );
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.gifImageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectZero];
    [self.messageContentView addSubview:self.gifImageView];
    self.gifImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.baseContentView.userInteractionEnabled = YES;
    self.contenLabel  = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contenLabel.font = [UIFont systemFontOfSize:12.0];
    self.contenLabel.textAlignment = NSTextAlignmentCenter;
    self.contenLabel.textColor = Maser_Color;
    [self.messageContentView addSubview:self.contenLabel];
    
    
    
    UITapGestureRecognizer *longPress =
    [[UITapGestureRecognizer alloc]
     initWithTarget:self
     action:@selector(longPressed:)];
    [self.messageContentView addGestureRecognizer:longPress];
    
    UITapGestureRecognizer *gifTap = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self
                                      action:@selector(gifPress:)];
    gifTap.numberOfTapsRequired = 1;
    gifTap.numberOfTouchesRequired = 1;
    [self.gifImageView addGestureRecognizer:gifTap];
    self.gifImageView.userInteractionEnabled = YES;
}

- (void)gifPress:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(didTapMessageCell:)]) {
        [self.delegate didTapMessageCell:self.model];
    }
}

- (void)longPressed:(id)sender {
    UILongPressGestureRecognizer *press = (UILongPressGestureRecognizer *)sender;
    if (press.state == UIGestureRecognizerStateEnded) {
        return;
    } else if (press.state == UIGestureRecognizerStateBegan) {
        [self.delegate didLongTouchMessageCell:self.model
                                        inView:self.gifImageView];
    }
}
+ (CGSize)getTextLabelSize:(LSWMGiftModel *)message {
    if ([message.price length] > 0) {
        float maxWidth =
        [UIScreen mainScreen].bounds.size.width -
        (10 + [RCIM sharedRCIM].globalMessagePortraitSize.width + 10) * 2 - 5 -
        35;
        CGRect textRect = [message.content
                           boundingRectWithSize:CGSizeMake(maxWidth, 8000)
                           options:(NSStringDrawingTruncatesLastVisibleLine |
                                    NSStringDrawingUsesLineFragmentOrigin |
                                    NSStringDrawingUsesFontLeading)
                           attributes:@{
                                        NSFontAttributeName :
                                            [UIFont systemFontOfSize:12.0]
                                        }
                           context:nil];
        textRect.size.height = ceilf(textRect.size.height);
        textRect.size.width = ceilf(textRect.size.width);
        return CGSizeMake(textRect.size.width + 10, textRect.size.height + 10);
    } else {
        return CGSizeZero;
    }
}

- (void)setDataModel:(RCMessageModel *)model {
    [super setDataModel:model];
    [self setAutoLayout];
}

- (void)setAutoLayout {
    
    
    
    
    
}

@end
