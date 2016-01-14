//
//  WCRegisterViewController.m
//  WeChat
//
//  Created by 蒋嵩 on 16/1/9.
//  Copyright © 2016年 song.jiang. All rights reserved.
//

#import "WCRegisterViewController.h"
#import "UIImage+WF.h"
#import "UIButton+WF.h"
#import "WCUserInfo.h"
#import "AppDelegate.h"
#import "MBProgressHUD+HM.h"
#import "UITextField+WF.h"
#import "WCXMPPTool.h"

@interface WCRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@end

@implementation WCRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //判断当前设备的类型，改变左右两边约束的距离
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        self.leftConstraint.constant = 20;
        self.rightConstraint.constant = 20;
    }
    //设置TextField的背景
    self.userField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    self.pwdField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    //设置登录按钮的背景
    [self.registerBtn setResizeN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];
}
- (IBAction)registerBtnClick
{
    //隐藏键盘
    [self.view endEditing:YES];
    //判断用户输入的是否是电话号码
    if (![self.userField isTelphoneNum]) {
        [MBProgressHUD showError:@"请输入正确的手机号码。" toView:self.view];
        return;
    }
    //将用户数据保存到单例
    WCUserInfo *userInfo = [WCUserInfo sharedWCUserInfo];
    userInfo.registerUser = self.userField.text;
    userInfo.registerPwd = self.pwdField.text;
    //调用WCXMPPTool中的注册方法
    [WCXMPPTool sharedWCXMPPTool].registerOperation = YES;
    //提示
    [MBProgressHUD showMessage:@"正在登录中..." toView:self.view];
    __weak typeof(self) selfVC = self;
    [[WCXMPPTool sharedWCXMPPTool] xmppUserRegister:^(XMPPResultType type) {
        [selfVC handleResultType:type];
    }];
}
//处理注册的结果
-(void)handleResultType:(XMPPResultType)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view];
        switch (type) {
            case XMPPRESULTTYPENetErr:
                [MBProgressHUD showError:@"网络不稳定" toView:self.view];
                break;
            case XMPPResultTypeRegisterSuccess:
                [MBProgressHUD showError:@"注册成功" toView:self.view];
                //回到上一个窗口
                [self dismissViewControllerAnimated:YES completion:nil];
                if ([self.delegate respondsToSelector:@selector(registerViewControllerDidFinishRegister)]) {
                    [self.delegate registerViewControllerDidFinishRegister];
                }
                break;
            case XMPPResultTypeRegisterFailure:
                [MBProgressHUD showError:@"注册失败,用户名重复" toView:self.view];
                break;
            default:
                break;
        }
    });
}
- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)textChange
{
    BOOL enable = (self.userField.text.length != 0) && (self.pwdField.text.length != 0);
    self.registerBtn.enabled = enable;
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
