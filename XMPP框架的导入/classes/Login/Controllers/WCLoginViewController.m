//
//  WCLoginViewController.m
//  WeChat
//
//  Created by 蒋嵩 on 16/1/7.
//  Copyright © 2016年 song.jiang. All rights reserved.
//

#import "WCLoginViewController.h"
#import "WCUserInfo.h"
#import "CategoryWF.h"
#import "WCUserInfo.h"
#import "WCRegisterViewController.h"
#import "AppDelegate.h"
#import "WCNavigationController.h"
#import "MBProgressHUD+HM.h"
#import "WCXMPPTool.h"

@interface WCLoginViewController ()<WCRegisterViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation WCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置Textfield和按钮的样式
    self.pwdField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    [self.pwdField addLeftViewWithImage:@"Card_Lock"];
    [self.loginBtn setResizeN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];
    //设置登录名为上次登录名
    NSString *user = [WCUserInfo sharedWCUserInfo].user;
    self.userLabel.text = user;
}
- (IBAction)loginBtnClick:(id)sender
{
    //保存登录数据到单例中
    WCUserInfo *userInfo = [WCUserInfo sharedWCUserInfo];
    userInfo.user = self.userLabel.text;
    userInfo.pwd = self.pwdField.text;
    //调用父类方法登录
    [super login];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //获取注册控制器
    id destVc = segue.destinationViewController;
    if ([destVc isKindOfClass:[WCNavigationController class]]) {
        WCNavigationController *nav = destVc;
        //获取根控制器
        if ([nav.topViewController isKindOfClass:[WCRegisterViewController class]]) {
            WCRegisterViewController *registerVc = (WCRegisterViewController *)nav.topViewController;
            //设置注册控制器的代理
            registerVc.delegate = self;
        }
    }
}
#pragma mark registerViewControllerDelegate
-(void)registerViewControllerDidFinishRegister
{
    WCLog(@"完成注册");
    //完成注册userLabel要显示注册用户的用户名
    self.userLabel.text = [WCUserInfo sharedWCUserInfo].registerUser;
    //提示
    [MBProgressHUD showSuccess:@"完成注册" toView:self.view];
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
