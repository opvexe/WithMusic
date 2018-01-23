//
//  LSWMGiftTableViewCell.m
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMGiftTableViewCell.h"
#import "LSWMGiftModel.h"

#define GIFWIDTH           90
#define ContentHeight      20
#define URLFromString(str)                      [NSURL URLWithString:str]

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
    
    self.tipLabel = [[LSWMAnimationLabel alloc] init];
    self.tipLabel.textColor = ButtonBGColor;
    self.tipLabel.font = [UIFont systemFontOfSize:12.0];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.hidden =YES;
    [self.messageContentView addSubview:self.tipLabel];
    
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
    
    CGRect messageContentViewRect = self.messageContentView.frame;
    
    LSWMGiftModel *testMessage = (LSWMGiftModel *)self.model.content;
    CGSize textLabelSize = [[self class] getTextLabelSize:testMessage];
    NSString *title =@"";
    NSString *tip  =@"";
    if (MessageDirection_RECEIVE == self.messageDirection) {
        self.gifImageView.frame =
        CGRectMake(0,0,GIFWIDTH , GIFWIDTH);
        self.contenLabel.frame =CGRectMake(0,CGRectGetMaxY(self.gifImageView.frame),GIFWIDTH , ContentHeight);
        self.tipLabel.frame =CGRectMake(CGRectGetWidth(self.gifImageView.frame),CGRectGetMidY(self.gifImageView.frame),textLabelSize.width+20, textLabelSize.height);
        messageContentViewRect.size.width = self.gifImageView.frame.size.width+self.tipLabel.frame.size.width;
        self.messageContentView.frame = messageContentViewRect;
        title =@"您收到";
        tip = @"+";
    } else {
        self.gifImageView.frame =
        CGRectMake(0,0,GIFWIDTH , GIFWIDTH);
        self.contenLabel.frame =CGRectMake(0,CGRectGetMaxY(self.gifImageView.frame),GIFWIDTH , ContentHeight);
        self.tipLabel.frame =CGRectMake(0,CGRectGetMidY(self.gifImageView.frame),textLabelSize.width+20 , textLabelSize.height);
        messageContentViewRect.size.width = self.gifImageView.frame.size.width;
        messageContentViewRect.size.height = CGRectGetMaxY(self.contenLabel.frame);
        messageContentViewRect.origin.x =
        self.baseContentView.bounds.size.width -
        (messageContentViewRect.size.width + HeadAndContentSpacing +
         [RCIM sharedRCIM].globalMessagePortraitSize.width);
        self.messageContentView.frame = messageContentViewRect;
        title =@"您赠送";
        tip = @"-";
    }
    if (testMessage) {
        [self.gifImageView sd_setImageWithURL:URLFromString(testMessage.imageUri)];
        self.contenLabel.text =FormatString(@"%@%@",title,testMessage.giftname);
        self.tipLabel.text =FormatString(@"%@%@",tip,testMessage.price);
        [self.tipLabel StartWithDuration: 2.0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tipLabel StopWithDuration: 2.0];
        });
    }
}

@end
