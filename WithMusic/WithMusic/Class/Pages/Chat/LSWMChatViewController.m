//
//  LSWMChatViewController.m
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMChatViewController.h"
#import "LSWMGiftTableViewCell.h"
#import "LSWMGiftModel.h"
@interface LSWMChatViewController ()

@end

@implementation LSWMChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customCell];
}

-(void)customCell{
    
    self.unReadMessageLabel.textColor = Maser_Color;
    [self.unReadButton setTitleColor:Maser_Color forState:UIControlStateNormal];
    [self.unReadButton setTitleColor:Maser_Color forState:UIControlStateHighlighted];
    [self.unReadButton setTitleColor:Maser_Color forState:UIControlStateSelected];
    [self.unReadButton setTitleColor:Maser_Color forState:UIControlStateDisabled];
    
    
    [self registerClass:[LSWMGiftTableViewCell class]
        forMessageClass:[LSWMGiftModel class]];
    
}

-(RCMessageBaseCell *)rcConversationCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RCMessageModel *model = self.conversationDataRepository[indexPath.row];
    
   LSWMGiftTableViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:APPGiftMessageTypeIdentifier forIndexPath:indexPath];
    
    [cell  setModel:model];
    
    return cell;
}


@end
