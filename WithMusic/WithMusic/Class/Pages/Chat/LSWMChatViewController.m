//
//  LSWMChatViewController.m
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMChatViewController.h"
#import "LSWMGiftTableViewCell.h"
#import "LSWMLookQuestionModel.h"
#import "LSWMSmallVideoModel.h"
#import "LSWMGiftModel.h"
#import "LSWMLookQuestionTipCell.h"
#import "LSWMSmallVideoFileCell.h"

#import <ZLPhotoActionSheet.h>
#import <ZLPhotoConfiguration.h>
#import <ZLPhotoManager.h>
#import <Photos/Photos.h>
#import "ZLCustomCamera.h"

@interface LSWMChatViewController ()
@property(nonatomic,strong)  ZLPhotoActionSheet *photoActionSheetView;
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
    [self.chatSessionInputBarControl.pluginBoardView removeItemWithTag:PLUGIN_BOARD_ITEM_LOCATION_TAG];
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"Chat_Video_Icon"] title:@"小视频" tag:PLUGIN_BOARD_ITEM_SmallVide_TAG];
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"Chat_Rectangle_Icon"] title:@"向ta提问" tag:PLUGIN_BOARD_ITEM_AskTa_TAG];
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"Chat_Call_Video_Icon"] title:@"找ta上课" tag:PLUGIN_BOARD_ITEM_FindClasss_TAG];
    [self.chatSessionInputBarControl.pluginBoardView updateItemWithTag:PLUGIN_BOARD_ITEM_ALBUM_TAG image:[UIImage imageNamed:@"Album_Icon"] title:@"相册"];
    [self.chatSessionInputBarControl.pluginBoardView updateItemWithTag:PLUGIN_BOARD_ITEM_CAMERA_TAG image:[UIImage imageNamed:@"Chat_Video_Icon"] title:@"相机"];
    
    
    NSMutableDictionary *contentPamra = [NSMutableDictionary dictionaryWithCapacity:0];
    [contentPamra setValue:@"我这只是一个测试" forKey:@"content"];
    [contentPamra setValue:@"您有一个问题已被导师查看" forKey:@"title"];
    [contentPamra setValue:@"http://img0.imgtn.bdimg.com/it/u=2069423848,1745692628&fm=27&gp=0.jpg" forKey:@"imageUrl"];
    [contentPamra setValue:@"88" forKey:@"price"];
    NSString *durationStr =@"12:20";
    CGFloat duration  = 0.0;
    NSString *fileUrl = @"";
    [contentPamra setValue:durationStr forKey:@"durationStr"];
    [contentPamra setValue:fileUrl forKey:@"fileUrl"];
    [contentPamra setValue:@(duration) forKey:@"duration"];
    [contentPamra setValue:@"32" forKey:@"questionId"];
    [contentPamra setValue:self.targetId forKey:@"receiveId"];
    [contentPamra setValue:@(88888) forKey:@"send_Id"];
    [contentPamra setValue:@(0) forKey:@"type"];
    LSWMLookQuestionModel *contentd=[LSWMLookQuestionModel messageWithContent:contentPamra];
    [self sendMessage:contentd pushContent:ReplyQuestionMessageDisPlayContent];
    
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
    [self registerClass:[LSWMLookQuestionTipCell class] forMessageClass:[LSWMLookQuestionModel class]];
    [self registerClass:[LSWMSmallVideoFileCell class] forMessageClass:[LSWMSmallVideoModel class]];
}

/*!
 * 返回
 */
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)showVideoFile{
    self.photoActionSheetView = [[ZLPhotoActionSheet alloc] init];
    ZLPhotoConfiguration *configuration = [ZLPhotoConfiguration defaultPhotoConfiguration];
    configuration.sortAscending = YES;
    configuration.allowSelectImage = NO;
    configuration.allowSelectGif = NO;
    configuration.allowSelectVideo = YES;
    configuration.allowSelectLivePhoto = NO;
    configuration.allowForceTouch = YES;
    configuration.allowEditImage = NO;
    configuration.allowEditVideo = YES;
    configuration.allowSlideSelect = NO;
    configuration.allowDragSelect = NO;
    //设置相册内部显示拍照按钮
    configuration.allowTakePhotoInLibrary = NO;
    //设置在内部拍照按钮上实时显示相机俘获画面
    configuration.showCaptureImageOnTakePhotoBtn = NO;
    //设置照片最大预览数
    configuration.maxPreviewCount = 100;
    //设置照片最大选择数
    configuration.maxSelectCount = 1;
    configuration.maxVideoDuration  = 999999;
    //单选模式是否显示选择按钮
    configuration.showSelectBtn = YES;
    //是否在选择图片后直接进入编辑界面
    configuration.editAfterSelectThumbnailImage = NO;
    //是否在已选择照片上显示遮罩层
    configuration.showSelectedMask = NO;
    //颜色，状态栏样式
    configuration.selectedMaskColor = UIColorFromRGB(0xFF758C);
    configuration.navBarColor =  UIColorFromRGB(0xffffff);
    configuration.navTitleColor = MainTitle_Color;
    configuration.bottomBtnsNormalTitleColor =  UIColorFromRGB(0xFF758C);
    configuration.bottomBtnsDisableBgColor =  UIColorFromRGB(0xFF758C);
    configuration.bottomViewBgColor =  UIColorFromRGB(0xffffff);
    configuration.statusBarStyle = UIStatusBarStyleDefault;
    //是否允许框架解析图片
    configuration.shouldAnialysisAsset = YES;
    configuration.exportVideoType = ZLExportVideoTypeMp4;
    self.photoActionSheetView.configuration = configuration;
    self.photoActionSheetView.sender = self;
    WS(weakSelf)
    [self.photoActionSheetView setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        PHAsset *asset = assets.firstObject;
        [ZLPhotoManager requestVideoForAsset:assets.firstObject completion:^(AVPlayerItem *item, NSDictionary *info) {
            NSString *filePath = [info valueForKey:@"PHImageFileSandboxExtensionTokenKey"];
            if (filePath && filePath.length > 0) {
                NSArray *lyricArr = [filePath componentsSeparatedByString:@";"];
                NSString *privatePath = [lyricArr lastObject];
                NSMutableDictionary *contentPamra3 = [NSMutableDictionary dictionaryWithCapacity:0];
                [contentPamra3 setValue:@"我这只是一个测试" forKey:@"content"];
                [contentPamra3 setValue:@"我" forKey:@"title"];
                [contentPamra3 setValue:@"http://img0.imgtn.bdimg.com/it/u=2069423848,1745692628&fm=27&gp=0.jpg" forKey:@"imageUrl"];
                [contentPamra3 setValue:@"88" forKey:@"price"];
                [contentPamra3 setValue:[ZLPhotoManager getDuration:asset] forKey:@"durationStr"];
                [contentPamra3 setValue:@(asset.duration) forKey:@"duration"];
                [contentPamra3 setValue:@"32" forKey:@"questionId"];
                [contentPamra3 setValue:weakSelf.targetId forKey:@"receiveId"];
                [contentPamra3 setValue:@(88888) forKey:@"send_Id"];
                [contentPamra3 setValue:privatePath forKey:@"fileUrl"];
                [contentPamra3 setValue:privatePath forKey:@"locationFileUrl"];
                LSWMSmallVideoModel *addcontentd2=[LSWMSmallVideoModel messageWithContent:contentPamra3];
                [weakSelf sendMessage:addcontentd2 pushContent:SmallVideoDisPlayContent];
            }
            
        }];
    }];
    [self.photoActionSheetView showPhotoLibrary];
}



-(void)showVideoRecord{
    ZLCustomCamera  *customCamra= [[ ZLCustomCamera alloc ] init];
    customCamra.allowRecordVideo = YES;
    customCamra.videoType  = ZLExportVideoTypeMp4;
    customCamra.allowRecordVideo = NO;
    customCamra.maxRecordDuration = 360;
    customCamra.sessionPreset = ZLCaptureSessionPreset1280x720;
    customCamra.circleProgressColor = Maser_Color;
    customCamra.doneBlock = ^(UIImage *image, NSURL *videoUrl) {
        WS(weakSelf)
        [ZLPhotoManager saveVideoToAblum:videoUrl completion:^(BOOL suc, PHAsset *asset) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (suc) {
                    
                    [ZLPhotoManager requestVideoForAsset:asset completion:^(AVPlayerItem *item, NSDictionary *info) {
                        NSString *filePath = [info valueForKey:@"PHImageFileSandboxExtensionTokenKey"];
                        if (filePath && filePath.length > 0) {
                            NSArray *lyricArr = [filePath componentsSeparatedByString:@";"];
                            NSString *privatePath = [lyricArr lastObject];
                            NSMutableDictionary *contentPamra3 = [NSMutableDictionary dictionaryWithCapacity:0];
                            [contentPamra3 setValue:@"我这只是一个测试" forKey:@"content"];
                            [contentPamra3 setValue:@"我" forKey:@"title"];
                            [contentPamra3 setValue:@"http://img0.imgtn.bdimg.com/it/u=2069423848,1745692628&fm=27&gp=0.jpg" forKey:@"imageUrl"];
                            [contentPamra3 setValue:@"88" forKey:@"price"];
                            [contentPamra3 setValue:[ZLPhotoManager getDuration:asset] forKey:@"durationStr"];
                            [contentPamra3 setValue:@(asset.duration) forKey:@"duration"];
                            [contentPamra3 setValue:@"32" forKey:@"questionId"];
                            [contentPamra3 setValue:weakSelf.targetId forKey:@"receiveId"];
                            [contentPamra3 setValue:@(88888) forKey:@"send_Id"];
                            [contentPamra3 setValue:privatePath forKey:@"fileUrl"];
                            [contentPamra3 setValue:privatePath forKey:@"locationFileUrl"];
                            LSWMSmallVideoModel *addcontentd2=[LSWMSmallVideoModel messageWithContent:contentPamra3];
                            [weakSelf sendMessage:addcontentd2 pushContent:SmallVideoDisPlayContent];
                        }
                        
                    }];
                }
            });
        }];
    };
    [self presentViewController:customCamra animated:YES completion:nil];
}


#pragma mark RCPluginBoardViewDelegate

- (void)pluginBoardView:(RCPluginBoardView *)pluginBoardView clickedItemWithTag:(NSInteger)tag {
    
    
    switch (tag) {
        case PLUGIN_BOARD_ITEM_SmallVide_TAG: {
            
            
            
            break;
        }
            
        case PLUGIN_BOARD_ITEM_AskTa_TAG: {
            
            
            
            break;
        }
        case PLUGIN_BOARD_ITEM_FindClasss_TAG: {
            
            break;
        }
        default:
            [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
            break;
    }
    
    
}

/*!
 * 用户信息
 */
- (void)didTapCellPortrait:(NSString *)userId{
    
    
    
}

/*!
 * 点击分享
 */
-(void)didTapShareActionMessageCell:(RCMessageModel *)model{
    
    
}

/*!
 * 点击消息
 */
-(void)didTapMessageCell:(RCMessageModel *)model{
    
    if ([model.content isMemberOfClass:[LSWMLookQuestionModel class]]) {
        
        
    }else if ([model.content isMemberOfClass:[LSWMSmallVideoModel class]]) {
        
        
    }else{
        [super didTapMessageCell:model];
    }
}

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

