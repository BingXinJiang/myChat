//
//  WCUserInfo.h
//  WeChat
//
//  Created by 蒋嵩 on 16/1/7.
//  Copyright © 2016年 song.jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface WCUserInfo : NSObject

singleton_interface(WCUserInfo);

@property (nonatomic, copy)NSString *user;//用户名
@property (nonatomic, copy)NSString *pwd;//密码
@property (nonatomic, assign)BOOL loginStatus;//登录状态

@property (nonatomic, copy)NSString *registerUser;//注册的用户名
@property (nonatomic, copy)NSString *registerPwd;//注册的密码

//保存用户数据到沙盒
-(void)saveUserInfoToSanbox;

//从沙盒里获取用户数据
-(void)loadUserInfoFromSanbox;

@end
