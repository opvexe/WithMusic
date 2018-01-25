//
//  LSWMLookQuestionTipCell.m
//  WithMusic
//
//  Created by Facebook on 2018/1/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMLookQuestionTipCell.h"
#import "LSWMLookQuestionModel.h"

#define  ReplyQuestionHeight      110

@interface LSWMLookQuestionTipCell()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,strong)UILabel *contentTitleLabel;

@property(nonatomic,strong)FLAnimatedImageView *imageBaseView;

@property(nonatomic, strong) FLAnimatedImageView *bubbleBackgroundView;
@end

@implementation LSWMLookQuestionTipCell

+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight {
    
    CGFloat __messagecontentview_height = ReplyQuestionHeight;
    
    __messagecontentview_height += extraHeight;
    
    return CGSizeMake(collectionViewWidth, __messagecontentview_height);
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
    self.bubbleBackgroundView.backgroundColor =[UIColor whiteColor];
    self.bubbleBackgroundView.layer.masksToBounds =YES;
    self.bubbleBackgroundView.userInteractionEnabled =YES;
    self.bubbleBackgroundView.layer.cornerRadius =5;
    [self.baseContentView addSubview:self.bubbleBackgroundView];
    UITapGestureRecognizer *tipSmallTap = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tipSmallVideo:)];
    tipSmallTap.numberOfTapsRequired = 1;
    tipSmallTap.numberOfTouchesRequired = 1;
    [self.bubbleBackgroundView addGestureRecognizer:tipSmallTap];
    self.imageBaseView = [FLAnimatedImageView new];
    self.imageBaseView.contentMode =UIViewContentModeScaleAspectFill;
    [self.bubbleBackgroundView addSubview:self.imageBaseView];
    self.imageBaseView.layer.masksToBounds =YES;
    self.imageBaseView.layer.cornerRadius =5;
    self.imageBaseView.userInteractionEnabled =YES;
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font= [UIFont systemFontOfSize:14.0];
    self.titleLabel.textColor = UIColorFromRGB(0x323232);
    [self.bubbleBackgroundView addSubview:self.titleLabel];
    
    self.contentTitleLabel = [UILabel new];
    self.contentTitleLabel.font= [UIFont systemFontOfSize:12.0];
    self.contentTitleLabel.textColor = UIColorFromRGB(0x323232);
    [self.bubbleBackgroundView addSubview:self.contentTitleLabel];
    
    
    self.contentLabel = [UILabel new];
    self.contentLabel.font=  [UIFont systemFontOfSize:12.0];
    self.contentLabel.textColor = UIColorFromRGB(0x323232);
    [self.bubbleBackgroundView addSubview:self.contentLabel];
    
    [self updateConstraintsView];
}
- (void)tipSmallVideo:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(didTapMessageCell:)]) {
        [self.delegate didTapMessageCell:self.model];
    }
}
-(void)updateConstraintsView{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bubbleBackgroundView.mas_left).offset(13);
        make.right.mas_equalTo(self.bubbleBackgroundView.mas_right).offset(-13);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(self.bubbleBackgroundView.mas_top).offset(10);
    }];
    [self.imageBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    
    [self.contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageBaseView.mas_right).offset((8));
        make.right.mas_equalTo(self.titleLabel.mas_right);
        make.top.mas_equalTo(self.imageBaseView.mas_top);
        make.height.mas_equalTo(self.titleLabel);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageBaseView.mas_right).offset((8));
        make.right.mas_equalTo(self.titleLabel.mas_right);
        make.top.mas_equalTo(self.contentTitleLabel.mas_bottom).offset((5));
    }];
}
- (void)setDataModel:(RCMessageModel *)model {
    [super setDataModel:model];
    [self setAutoLayout];
}
- (void)setAutoLayout {
    LSWMLookQuestionModel *message = (LSWMLookQuestionModel *)self.model.content;
    if (message) {
        self.titleLabel.text = message.title;
        self.contentLabel.text = message.content;
        self.contentTitleLabel.text = message.content;
        [self.imageBaseView sd_setImageWithURL:URLFromString(message.imageUrl) placeholderImage:[UIImage imageNamed:@"2"]];
    }
    [self.bubbleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.baseContentView);
        make.size.mas_equalTo(CGSizeMake((342),ReplyQuestionHeight));
    }];
}

@end
