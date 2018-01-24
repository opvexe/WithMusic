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
    [self scrollToBottomAnimated:YES];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
}
/*!
 * 配置
 */
-(void)configView{
    
     self.enableSaveNewPhotoToLocalSystem = YES;
    
    
}
/*!
 * 自定义Cell
 */
-(void)customCell{
    
    self.unReadMessageLabel.textColor = Maser_Color;
    [self.unReadButton setTitleColor:Maser_Color forState:UIControlStateNormal];
    [self.unReadButton setTitleColor:Maser_Color forState:UIControlStateHighlighted];
    [self.unReadButton setTitleColor:Maser_Color forState:UIControlStateSelected];
    [self.unReadButton setTitleColor:Maser_Color forState:UIControlStateDisabled];
    
    [self registerClass:[LSWMGiftTableViewCell class] forMessageClass:[LSWMGiftModel class]];
}

/*!
 * 返回
 */
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark RCPluginBoardViewDelegate



/*!
 * 显示
 */
- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell
                   atIndexPath:(NSIndexPath *)indexPath{
    
    cell.isDisplayReadStatus =NO;
    if ([cell isMemberOfClass:[RCTextMessageCell class]])
    {
        RCTextMessageCell *textMessage = (RCTextMessageCell*)cell;
        
        textMessage.textLabel.font =[UIFont systemFontOfSize:15.0];
        if (textMessage.model.messageDirection ==MessageDirection_SEND) {
            
            textMessage.textLabel.textColor =UIColorFromRGB(0XFFFFFF);
            
        }else{
            textMessage.textLabel.textColor =UIColorFromRGB(0x646464);
            
            
        }
        
    }else if ([cell isMemberOfClass:[RCVoiceMessageCell class]]){
        RCVoiceMessageCell *textMessage = (RCVoiceMessageCell*)cell;
        textMessage.voiceDurationLabel.font = [UIFont systemFontOfSize:15.0];
        if (textMessage.messageDirection ==MessageDirection_SEND) {
            
            textMessage.voiceDurationLabel.textColor =UIColorFromRGB(0XFFFFFF);
            textMessage.voiceDurationLabel.font = [UIFont systemFontOfSize:15.0];
            
        }else{
            
            textMessage.voiceDurationLabel.textColor =UIColorFromRGB(0x646464);
            
        }
        
    }else if ([cell isMemberOfClass:[RCRichContentMessageCell class]]){
        
        RCRichContentMessageCell *textMessage = (RCRichContentMessageCell*)cell;
        textMessage.titleLabel.font = [UIFont systemFontOfSize:15.0];
        textMessage.digestLabel.font = [UIFont systemFontOfSize:15.0];
        
        if (textMessage.messageDirection ==MessageDirection_SEND) {
            textMessage.digestLabel.textColor =UIColorFromRGB(0XFFFFFF);
            textMessage.titleLabel.textColor =UIColorFromRGB(0XFFFFFF);
            
        }else{
            textMessage.digestLabel.textColor =UIColorFromRGB(0x646464);
            textMessage.titleLabel.textColor =UIColorFromRGB(0x646464);
            
        }
    }else if ([cell isMemberOfClass:[RCLocationMessageCell class]]) {
        RCLocationMessageCell *textMessage = (RCLocationMessageCell*)cell;
        textMessage.locationNameLabel.font = [UIFont systemFontOfSize:15.0];
        if (textMessage.messageDirection ==MessageDirection_SEND) {
            textMessage.locationNameLabel.textColor =UIColorFromRGB(0XFFFFFF);
        }else{
            
            textMessage.locationNameLabel.textColor =UIColorFromRGB(0XFFFFFF);
            
        }
        
    }
    [super willDisplayMessageCell:cell atIndexPath:indexPath];
}

/*!
 地理位置选择完成之后的回调
 @param location       位置的二维坐标
 @param locationName   位置的名称
 @param mapScreenShot  位置在地图中的缩略图
 */
- (void)locationDidSelect:(CLLocationCoordinate2D)location locationName:(NSString *)locationName mapScreenShot:(UIImage *)mapScreenShot{
    
    
    RCLocationMessage *message = [RCLocationMessage messageWithLocationImage:mapScreenShot location:location locationName:locationName];
    [self sendMessage:message pushContent:nil];
    
}
- (void)locationPicker:(RCLocationPickerViewController *)locationPicker
     didSelectLocation:(CLLocationCoordinate2D)location
          locationName:(NSString *)locationName
         mapScreenShot:(UIImage *)mapScreenShot{
    RCLocationMessage *message = [RCLocationMessage messageWithLocationImage:mapScreenShot location:location locationName:locationName];
    [self sendMessage:message pushContent:nil];
    
}


- (void)keyboardWillShowNotification:(NSNotification *)notification {
    if(!self.chatSessionInputBarControl.inputTextView.isFirstResponder)
    {
        [self.chatSessionInputBarControl.inputTextView becomeFirstResponder];
    }
}


- (void)figureOutAllConversationDataRepository {
    for (int i = 0; i < self.conversationDataRepository.count; i++) {
        RCMessageModel *model = [self.conversationDataRepository objectAtIndex:i];
        if (0 == i) {
            model.isDisplayMessageTime = YES;
        } else if (i > 0) {
            RCMessageModel *pre_model = [self.conversationDataRepository objectAtIndex:i - 1];
            
            long long previous_time = pre_model.sentTime;
            
            long long current_time = model.sentTime;
            
            long long interval =
            current_time - previous_time > 0 ? current_time - previous_time : previous_time - current_time;
            if (interval / 1000 <= 3 * 60) {
                if (model.isDisplayMessageTime && model.cellSize.height > 0) {
                    CGSize size = model.cellSize;
                    size.height = model.cellSize.height - 45;
                    model.cellSize = size;
                }
                model.isDisplayMessageTime = NO;
            } else if (![[[model.content class] getObjectName] isEqualToString:@"RC:OldMsgNtf"]) {
                if (!model.isDisplayMessageTime && model.cellSize.height > 0) {
                    CGSize size = model.cellSize;
                    size.height = model.cellSize.height + 45;
                    model.cellSize = size;
                }
                model.isDisplayMessageTime = YES;
            }
        }
        if ([[[model.content class] getObjectName] isEqualToString:@"RC:OldMsgNtf"]) {
            model.isDisplayMessageTime = NO;
        }
    }
}

@end
