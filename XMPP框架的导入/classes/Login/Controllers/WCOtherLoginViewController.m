//
//  WCOtherLoginViewController.m
//  WeChat
//
//  Created by 蒋嵩 on 16/1/3.
//  Copyright © 2016年 song.jiang. All rights reserved.
//

#import "WCOtherLoginViewController.h"
#import "CategoryWF.h"
#import "AppDelegate.h"
#import "MBProgressHUD+HM.h"
#import "WCUserInfo.h"

@interface WCOtherLoginViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation WCOtherLoginViewController

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
    [self.loginBtn setResizeN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];
}
- (IBAction)loginBtnClick {
    //登录
    //1.把用户名和密码放在WCUserInfo的单例里面
    //1.把用户名和密码放在沙盒
    NSString *user = self.userField.text;
    NSString *pwd = self.pwdField.text;
    WCUserInfo *userInfo = [WCUserInfo sharedWCUserInfo];
    userInfo.user = user;
    userInfo.pwd = pwd;
    //点击登录
    [super login];
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
