//
//  WCNavigationController.m
//  WeChat
//
//  Created by 蒋嵩 on 16/1/4.
//  Copyright © 2016年 song.jiang. All rights reserved.
//

#import "WCNavigationController.h"

@interface WCNavigationController ()

@end

@implementation WCNavigationController

+(void)initialize
{
    
}
//
+(void)setupNavTheme
{
    //设置导航栏样式
    UINavigationBar *navBar = [UINavigationBar appearance];
    //设置导航条的背景
    [navBar setBackgroundImage:[UIImage imageNamed:@"topbarbg_ios7"] forBarMetrics:UIBarMetricsDefault];
    //设置导航栏的字体
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:att];
    //设置状态栏的样式
    //默认的话，状态栏的样式由控制器决定的
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
//如果控制器由导航控制器管理，设置状态栏的样式时要在导航控制器中设置,也可在info.plist文件中设置view statesBar based-controller 为 NO
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
