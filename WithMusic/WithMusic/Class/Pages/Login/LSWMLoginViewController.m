//
//  LSWMLoginViewController.m
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMLoginViewController.h"
#import "AppDelegate.h"
#import "LSWMessageCoversationListMViewController.h"

@interface LSWMLoginViewController ()

@end

@implementation LSWMLoginViewController

static void extracted(LSWMLoginViewController *object) {
    [LSWMNetworkUtil GetTokenWithUserID:@"111" username:@"SHUMIN" headurl:@"http://pic26.photophoto.cn/20130323/0005018467298586_b.jpg" success:^(id responseObject) {
        NSString *token = responseObject[@"data"];
        
        /*！
         * 登录
         */
        [[RCIM sharedRCIM] connectWithToken:token
                                    success:^(NSString *userId) {
                                        
                                        [RCIMClient sharedRCIMClient].currentUserInfo  = [[RCUserInfo alloc] initWithUserId:userId name:@"SHUMIN" portrait:@"http://pic26.photophoto.cn/20130323/0005018467298586_b.jpg"];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [object switchRootController];
                                        });
                                        
                                    } error:^(RCConnectErrorCode status) {
                                        NSLog(@"RCConnectErrorCode--%ld",status);
                                        
                                    } tokenIncorrect:^{
                                        
                                    }];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    extracted(self);
    
}

-(void)switchRootController{
    [UIApplication sharedApplication].delegate.window.rootViewController = [LSWMessageCoversationListMViewController new];
}

@end

