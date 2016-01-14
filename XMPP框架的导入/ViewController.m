//
//  ViewController.m
//  XMPP框架的导入
//
//  Created by 蒋嵩 on 16/1/2.
//  Copyright © 2016年 song.jiang. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //做注销
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app logout];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
