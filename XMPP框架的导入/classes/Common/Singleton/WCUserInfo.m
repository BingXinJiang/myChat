//
//  WCUserInfo.m
//  WeChat
//
//  Created by 蒋嵩 on 16/1/7.
//  Copyright © 2016年 song.jiang. All rights reserved.
//

#import "WCUserInfo.h"
#define UserKey @"user"
#define PwdKey @"pwd"
#define LoginStatusKey @"loginStatus"

@implementation WCUserInfo
singleton_implementation(WCUserInfo)

-(void)saveUserInfoToSanbox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:UserKey];
    [defaults setObject:self.pwd forKey:PwdKey];
    [defaults setBool:self.loginStatus forKey:LoginStatusKey];
    [defaults synchronize];
}
-(void)loadUserInfoFromSanbox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:UserKey];
    self.pwd = [defaults objectForKey:PwdKey];
    self.loginStatus = [defaults boolForKey:LoginStatusKey];
}
@end
