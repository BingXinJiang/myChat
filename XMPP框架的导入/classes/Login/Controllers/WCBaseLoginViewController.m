//
//  WCBaseLoginViewController.m
//  WeChat
//
//  Created by 蒋嵩 on 16/1/9.
//  Copyright © 2016年 song.jiang. All rights reserved.
//

#import "WCBaseLoginViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD+HM.h"
#import "WCUserInfo.h"
#import "WCXMPPTool.h"

@interface WCBaseLoginViewController ()

@end

@implementation WCBaseLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)login {
    //登录
    
    //点击登陆隐藏键盘
    [self.view endEditing:YES];
    
    //2.调用WCXMPPTool的一个login连接服务器并登录
    //登录之前给个提示
    [MBProgressHUD showMessage:@"正在登录中..." toView:self.view];
    //调用WCXMPPTool中的方法
    [WCXMPPTool sharedWCXMPPTool].registerOperation = NO;
    __weak typeof(self) selfVc = self;//如果不加这句话，登陆后该控制器不会被释放，会造成内存泄漏，该句话对self进行了弱引用
    [[WCXMPPTool sharedWCXMPPTool] xmppUserLogin:^(XMPPResultType type) {
        [selfVc handleResultType:type];
    }];
}

-(void)handleResultType:(XMPPResultType)type
{
    //主线程刷新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view];
        switch (type) {
            case XMPPResultTypeLoginSuccess:
                NSLog(@"登录成功");
                [self enterMainPage];
                break;
            case XMPPResultTypeFailure:
                NSLog(@"登录失败");
                [MBProgressHUD showError:@"用户名或密码不正确" toView:self.view];
                break;
            case XMPPRESULTTYPENetErr:
                [MBProgressHUD showError:@"网络不给力" toView:self.view];
                break;
            default:
                break;
        }
        
    });
}

-(void)enterMainPage
{
    //更改用户的登录状态为YES
    [WCUserInfo sharedWCUserInfo].loginStatus = YES;
    //保存登录成功后的用户数据到沙盒
    [[WCUserInfo sharedWCUserInfo] saveUserInfoToSanbox];
    //隐藏模态窗口
    [self dismissViewControllerAnimated:NO completion:nil];
    //登录成功，来到主界面
    //此方法是在子线程调用，所以应该在主线程刷新UI
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController = storyboard.instantiateInitialViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
