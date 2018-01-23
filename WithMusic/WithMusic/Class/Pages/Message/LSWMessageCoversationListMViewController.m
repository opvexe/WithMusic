//
//  LSWMessageCoversationListMViewController.m
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMessageCoversationListMViewController.h"
#import "LSWMSearchBar.h"
#import "CommonMenuView.h"
#import "LSWMChatViewController.h"


@interface LSWMessageCoversationListMViewController ()<UISearchBarDelegate>
@property(nonatomic, strong) UINavigationController *searchNavigationController;
@property(nonatomic, strong) LSWMSearchBar *searchBar;
@property(nonatomic, strong) UIView *headerView;
@property(nonatomic, assign) NSUInteger index;
@property (nonatomic,assign) BOOL flag;
@end

@implementation LSWMessageCoversationListMViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //设置要显示的会话类型
        [self setDisplayConversationTypes:@[
                                            @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE),
                                            @(ConversationType_PUBLICSERVICE), @(ConversationType_GROUP), @(ConversationType_SYSTEM)
                                            ]];
        //聚合会话类型
        [self setCollectionConversationType:@[ @(ConversationType_SYSTEM) ]];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        //设置要显示的会话类型
        [self setDisplayConversationTypes:@[
                                            @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE),
                                            @(ConversationType_PUBLICSERVICE), @(ConversationType_GROUP), @(ConversationType_SYSTEM)
                                            ]];
        
        //聚合会话类型
        [self setCollectionConversationType:@[ @(ConversationType_SYSTEM) ]];
    }
    return self;
}


/*!
 * 搜索框
 */
- (LSWMSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[LSWMSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.conversationListTableView.frame.size.width, 44)];
    }
    return _searchBar;
}

/*!
 * 区头
 */
- (UIView *)headerView {
    if (!_headerView) {
        _headerView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.conversationListTableView.frame.size.width, 44)];
    }
    return _headerView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title =@"消息";
    
    self.searchBar.delegate = self;
    [self.headerView addSubview:self.searchBar];
    self.conversationListTableView.tableHeaderView = self.headerView;
    self.conversationListTableView.separatorColor =UIColorFromRGB(0xdfdfdf);
    self.showConnectingStatusOnNavigatorBar = YES;
    self.conversationListTableView.tableFooterView = [UIView new];
    
    self.index = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(GotoNextCoversation)
                                                 name:@"GotoNextCoversation"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateForSharedMessageInsertSuccess)
                                                 name:@"RCDSharedMessageInsertSuccess"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshCell:)
                                                 name:@"RefreshConversationList"
                                               object:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Add_Icon"] style:UIBarButtonItemStylePlain target:self action:@selector(ShowMenu)];
    self.flag = YES;
    NSDictionary *dict1 = @{
                            @"itemName" : @"加好友"
                            };
    NSDictionary *dict2 = @{
                            @"itemName" : @"创建群聊"
                            };
    NSDictionary *dict3 = @{
                            @"itemName" : @"通讯录"
                            };
    NSArray *dataArray = @[dict1,dict2,dict3];
    WS(weakSelf)
    [CommonMenuView createMenuWithFrame:CGRectZero target:self dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
        [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag];
    } backViewTap:^{
        weakSelf.flag = YES;
    }];
}

/*!
 * 菜单按钮
 */
-(void)ShowMenu{
    [self popMenu:CGPointMake(self.navigationController.view.frame.size.width -40,50)];
}

- (void)popMenu:(CGPoint)point{
    if (self.flag) {
        [CommonMenuView showMenuAtPoint:point];
        self.flag = NO;
    }else{
        [CommonMenuView hidden];
        self.flag = YES;
    }
}
- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    
    NSLog(@"ShowMenu:%@_%ld",str,tag);
    
    switch (tag) {
        case 1:
        {
            /*!
             *  添加好友
             */
        }
            break;
            
        case 2:
        {
            /*!
             *  创建群聊
             */
        }
            break;
            
        case 3:
        {
            /*!
             *  通讯录
             */
        }
            break;
        default:
            break;
    }
    self.flag = YES;
    [CommonMenuView hidden];
}

#pragma mark  | 通知 |GotoNextCoversation |updateForSharedMessageInsertSuccess |refreshCell
- (void)GotoNextCoversation {
    NSUInteger i;
    //设置contentInset是为了滚动到底部的时候，避免conversationListTableView自动回滚。
    self.conversationListTableView.contentInset =
    UIEdgeInsetsMake(0, 0, self.conversationListTableView.frame.size.height, 0);
    for (i = self.index + 1; i < self.conversationListDataSource.count; i++) {
        RCConversationModel *model = self.conversationListDataSource[i];
        if (model.unreadMessageCount > 0) {
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
            self.index = i;
            [self.conversationListTableView scrollToRowAtIndexPath:scrollIndexPath
                                                  atScrollPosition:UITableViewScrollPositionTop
                                                          animated:YES];
            break;
        }
    }
    //滚动到起始位置
    if (i >= self.conversationListDataSource.count) {
        //    self.conversationListTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        for (i = 0; i < self.conversationListDataSource.count; i++) {
            RCConversationModel *model = self.conversationListDataSource[i];
            if (model.unreadMessageCount > 0) {
                NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                self.index = i;
                [self.conversationListTableView scrollToRowAtIndexPath:scrollIndexPath
                                                      atScrollPosition:UITableViewScrollPositionTop
                                                              animated:YES];
                break;
            }
        }
    }
}


- (void)updateForSharedMessageInsertSuccess {
    [self refreshConversationTableViewIfNeeded];
}

- (void)refreshCell:(NSNotification *)notify {
    [self refreshConversationTableViewIfNeeded];
}

//左滑删除
- (void)rcConversationListTableView:(UITableView *)tableView
                 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                  forRowAtIndexPath:(NSIndexPath *)indexPath {
    //可以从数据库删除数据
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_SYSTEM targetId:model.targetId];
    [self.conversationListDataSource removeObjectAtIndex:indexPath.row];
    [self.conversationListTableView reloadData];
}

//自定义Cell
//- (RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView
//                                  cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//}

//收到消息监听
- (void)didReceiveMessageNotification:(NSNotification *)notification {
    
    
}

//自定义Model
- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource {
    for (int i = 0; i < dataSource.count; i++) {
        RCConversationModel *model = dataSource[i];
        //筛选请求添加好友的系统消息，用于生成自定义会话类型的cell
        if (model.conversationType == ConversationType_SYSTEM &&
            [model.lastestMessage isMemberOfClass:[RCContactNotificationMessage class]]) {
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        }
        if ([model.lastestMessage isKindOfClass:[RCGroupNotificationMessage class]]) {
            RCGroupNotificationMessage *groupNotification = (RCGroupNotificationMessage *)model.lastestMessage;
            if ([groupNotification.operation isEqualToString:@"Quit"]) {        /// Quit 有成员退出群组的通知
                NSData *jsonData = [groupNotification.data dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dictionary =
                [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                NSDictionary *data =
                [dictionary[@"data"] isKindOfClass:[NSDictionary class]] ? dictionary[@"data"] : nil;
                NSString *nickName =
                [data[@"operatorNickname"] isKindOfClass:[NSString class]] ? data[@"operatorNickname"] : nil;
                if ([nickName isEqualToString:[RCIM sharedRCIM].currentUserInfo.name]) {
                    [[RCIMClient sharedRCIMClient] removeConversation:model.conversationType targetId:model.targetId];
                    [self refreshConversationTableViewIfNeeded];
                }
            }
        }
    }
    return dataSource;
}

//点击Cell
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    switch (model.conversationModelType) {
            /*!
             公众服务的会话显示
             */
        case RC_CONVERSATION_MODEL_TYPE_PUBLIC_SERVICE:
        {
            
        }
            break;
            /*!
             默认显示
             */
        case RC_CONVERSATION_MODEL_TYPE_NORMAL:
        {
            LSWMChatViewController *chatView = [LSWMChatViewController new];
            chatView.conversationType = model.conversationType;
            chatView.targetId = model.targetId;
            chatView.title = model.conversationTitle;
            chatView.conversation = model;
            chatView.unReadMessage = model.unreadMessageCount;
            chatView.enableNewComingMessageIcon = YES; //开启消息提醒
            chatView.enableUnreadMessageIcon = YES;
            chatView.displayUserNameInCell = NO;
            [self.navigationController pushViewController:chatView animated:YES];
        }
            break;
            /*!
             聚合显示
             */
        case RC_CONVERSATION_MODEL_TYPE_COLLECTION:
        {
            
            
        }
            break;
            /*!
             用户自定义的会话显示
             */
        case RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION:
        {
            
        }
            break;
            
        default:
            break;
    }
}
//高度
- (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 67.0f;
}


#pragma mark UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        RCDSearchViewController *searchViewController = [[RCDSearchViewController alloc] init];
//        self.searchNavigationController = [[UINavigationController alloc] initWithRootViewController:searchViewController];
//        searchViewController.delegate = self;
//        [self.navigationController.view addSubview:self.searchNavigationController.view];
}

- (void)onSearchCancelClick {
        [self.searchNavigationController.view removeFromSuperview];
        [self.searchNavigationController removeFromParentViewController];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self refreshConversationTableViewIfNeeded];
}


@end

