//
//  WCMeViewController.m
//  WeChat
//
//  Created by 蒋嵩 on 16/1/5.
//  Copyright © 2016年 song.jiang. All rights reserved.
//

#import "WCMeViewController.h"
#import "AppDelegate.h"
#import "WCXMPPTool.h"
#import "XMPPFramework.h"
#import "XMPPvCardTemp.h"
#import "WCUserInfo.h"

@interface WCMeViewController ()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
//昵称
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
//微信号
@property (weak, nonatomic) IBOutlet UILabel *weixinNumLabel;
@end

@implementation WCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //显示用户的个人信息
    //使用Coredata获取数据
    //1.上下文关联到数据
    //2.FetchRequest
    //3.设置过滤和排序
    //4.执行请求获取数据
    //XMPP框架提供了一个方法直接获取个人信息
    XMPPvCardTemp *myVcard = [WCXMPPTool sharedWCXMPPTool].vCard.myvCardTemp;
    //设置头像
    if (myVcard.photo) {
        self.headerView.image = [UIImage imageWithData:myVcard.photo];
    }
    //设置昵称
    self.nickNameLabel.text = myVcard.nickname;
    //设置微信号（用户名）
    NSString *user = [WCUserInfo sharedWCUserInfo].user;
    self.weixinNumLabel.text = [NSString stringWithFormat:@"微信号:%@", user];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (IBAction)logoutBtnClick:(id)sender
{
    //直接调用appdelegate中的方法，
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    [app xmppUserlogout];
    [[WCXMPPTool sharedWCXMPPTool] xmppUserlogout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
