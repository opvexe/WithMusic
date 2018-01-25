//
//  LSWMSmallVideoFileCell.m
//  WithMusic
//
//  Created by Facebook on 2018/1/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMSmallVideoFileCell.h"
#import "LSWMSmallVideoModel.h"

#define CellHeight 225

@interface LSWMSmallVideoFileCell ()

@property(nonatomic,strong)FLAnimatedImageView *playImageView;

@property(nonatomic,strong)FLAnimatedImageView *imageBaseView;

@property(nonatomic,strong)UILabel *videoDurtionLabel;
/*!
 背景View
 */
@property(nonatomic, strong) FLAnimatedImageView *bubbleBackgroundView;
@end
@implementation LSWMSmallVideoFileCell
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight {
    
    CGFloat __messagecontentview_height = CellHeight;
    
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
    
    self.bubbleBackgroundView = [[FLAnimatedImageView alloc] initWithFrame:CGRectZero];
    [self.messageContentView addSubview:self.bubbleBackgroundView];
    UITapGestureRecognizer *tipSmallTap = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tipSmallVideo:)];
    tipSmallTap.numberOfTapsRequired = 1;
    tipSmallTap.numberOfTouchesRequired = 1;
    [self.bubbleBackgroundView addGestureRecognizer:tipSmallTap];
    
    self.bubbleBackgroundView.userInteractionEnabled = YES;
    self.imageBaseView = [FLAnimatedImageView new];
    self.imageBaseView.contentMode =UIViewContentModeScaleAspectFill;
    [self.bubbleBackgroundView addSubview:self.imageBaseView];
    self.imageBaseView.layer.masksToBounds =YES;
    self.imageBaseView.layer.cornerRadius =(5);
    self.imageBaseView.userInteractionEnabled =YES;
    self.playImageView = [FLAnimatedImageView new];
    self.playImageView.image = [UIImage imageNamed:@"playVideo_Icon"];
    self.playImageView.contentMode =UIViewContentModeScaleAspectFill;
    [self.imageBaseView addSubview:self.playImageView];
    self.playImageView.layer.masksToBounds =YES;
    self.playImageView.layer.cornerRadius =(5);
    self.playImageView.userInteractionEnabled =YES;
    self.videoDurtionLabel = [UILabel new];
    self.videoDurtionLabel.font= [UIFont systemFontOfSize:12.0];
    self.videoDurtionLabel.textColor = UIColorFromRGB(0xffffff);
    [self.bubbleBackgroundView addSubview:self.videoDurtionLabel];
    
    [self updateConstraintsView];
}
- (void)tipSmallVideo:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(didTapMessageCell:)]) {
        [self.delegate didTapMessageCell:self.model];
    }
}
-(void)updateConstraintsView{
    
    [self.playImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((32), (32)));
        make.center.mas_equalTo(self.imageBaseView);
    }];
    [self.videoDurtionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageBaseView.mas_left).offset((5));
        make.right.mas_equalTo(self.imageBaseView.mas_right).offset(-5);
        make.bottom.mas_equalTo(self.imageBaseView.mas_bottom).offset((-5));
    }];
    
}
- (void)setDataModel:(RCMessageModel *)model {
    [super setDataModel:model];
    [self setAutoLayout];
}
- (void)setAutoLayout {
    CGRect messageContentViewRect = self.messageContentView.frame;
    LSWMSmallVideoModel *message = (LSWMSmallVideoModel *)self.model.content;
    if (message) {
        self.videoDurtionLabel.text = message.durationStr;
        [self.imageBaseView sd_setImageWithURL:URLFromString(message.imageUrl) placeholderImage:[UIImage imageNamed:@"2"]];
    }
    if (MessageDirection_RECEIVE == self.messageDirection) {
        UIImage *image = [RCKitUtility imageNamed:@"chat_from_bg_normal" ofBundle:@"RongCloud.bundle"];
        [self.bubbleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake((150), CellHeight));
        }];
        [self.imageBaseView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((8));
            make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).offset(-1);
            make.bottom.mas_equalTo((-1));
            make.top.mas_equalTo((1));
        }];
        [self.messageContentView  layoutIfNeeded];
        self.videoDurtionLabel.textAlignment =NSTextAlignmentLeft;
        messageContentViewRect.size =self.bubbleBackgroundView.frame.size;
        self.messageContentView.frame = messageContentViewRect;
        self.bubbleBackgroundView.image =
        [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.8, image.size.width * 0.8,
                                                            image.size.height * 0.2, image.size.width * 0.2)];
        
        
        
    } else {
        [self.imageBaseView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((1));
            make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).offset(-8);
            make.bottom.mas_equalTo((-1));
            make.top.mas_equalTo((1));
        }];
        [self.bubbleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake((150), CellHeight));
        }];
        self.videoDurtionLabel.textAlignment =NSTextAlignmentRight;
        [self.messageContentView  layoutIfNeeded];
        messageContentViewRect.size =self.bubbleBackgroundView.frame.size;
        messageContentViewRect.origin.x =
        self.baseContentView.bounds.size.width - (messageContentViewRect.size.width + HeadAndContentSpacing +
                                                  [RCIM sharedRCIM].globalMessagePortraitSize.width + 10);
        self.messageContentView.frame = messageContentViewRect;
        UIImage *image = [RCKitUtility imageNamed:@"chat_to_bg_normal" ofBundle:@"RongCloud.bundle"];
        self.bubbleBackgroundView.image =
        [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.8, image.size.width * 0.2,
                                                            image.size.height * 0.2, image.size.width * 0.8)];
    }
    
    
}
@end
