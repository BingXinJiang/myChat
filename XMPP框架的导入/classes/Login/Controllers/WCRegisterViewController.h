//
//  WCRegisterViewController.h
//  WeChat
//
//  Created by 蒋嵩 on 16/1/9.
//  Copyright © 2016年 song.jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WCRegisterViewControllerDelegate <NSObject>
//完成注册
-(void)registerViewControllerDidFinishRegister;
@end

@interface WCRegisterViewController : UIViewController
@property (nonatomic, weak)id<WCRegisterViewControllerDelegate> delegate;
@end
