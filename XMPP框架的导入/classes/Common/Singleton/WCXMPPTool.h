//
//  WCXMPPTool.h
//  WeChat
//
//  Created by 蒋嵩 on 16/1/9.
//  Copyright © 2016年 song.jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "XMPPFramework.h"

typedef enum{
    XMPPResultTypeLoginSuccess,//登录成功
    XMPPResultTypeFailure,//登录失败
    XMPPRESULTTYPENetErr,//网络不给力
    XMPPResultTypeRegisterSuccess,//注册成功
    XMPPResultTypeRegisterFailure//注册失败
}XMPPResultType;

typedef void (^XMPPResultBlock)(XMPPResultType type);//XMPP请求结果的block

@interface WCXMPPTool : NSObject
singleton_interface(WCXMPPTool);
//注册的标示，YES注册 NO登录
@property (nonatomic, assign, getter=isRegisterOperation)BOOL registerOperation;//注册操作
@property(nonatomic, strong)XMPPvCardTempModule *vCard;//电子名片
//用户登录
-(void)xmppUserLogin:(XMPPResultBlock)resultBlock;
//注销
-(void)xmppUserlogout;
//用户注册
-(void)xmppUserRegister:(XMPPResultBlock)resultBlock;
@end

#ifdef DEBUG
#define WCLog(...) NSLog(@"\n%s %d \n %@ \n\n", __func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define WCLog(...)
#endif
