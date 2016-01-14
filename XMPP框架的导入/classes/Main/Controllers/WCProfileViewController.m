//
//  WCProfileViewController.m
//  WeChat
//
//  Created by 蒋嵩 on 16/1/13.
//  Copyright © 2016年 song.jiang. All rights reserved.
//

#import "WCProfileViewController.h"
#import "WCXMPPTool.h"
#import "XMPPvCardTemp.h"
#import "WCUserInfo.h"

@interface WCProfileViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headerView;//头像
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;//昵称
@property (weak, nonatomic) IBOutlet UILabel *weixinNumLabel;//微信号
@property (weak, nonatomic) IBOutlet UILabel *orgNameLabel;//公司
@property (weak, nonatomic) IBOutlet UILabel *orgUnitLabel;//部门
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//职位
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;//电话号码
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;//电子邮箱
@end

@implementation WCProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置个人信息
    [self loadVcard];
}
-(void)loadVcard
{
    //显示个人信息
    //XMPP框架提供了一个方法直接获取个人信息
    XMPPvCardTemp *myVcard = [WCXMPPTool sharedWCXMPPTool].vCard.myvCardTemp;
    //设置头像
    if (myVcard.photo) {
        self.headerView.image = [UIImage imageWithData:myVcard.photo];
    }
    //设置昵称
    self.nickNameLabel.text = myVcard.nickname;
    //设置微信号（用户名）
    self.weixinNumLabel.text = [WCUserInfo sharedWCUserInfo].user;
    //公司
    self.orgNameLabel.text = myVcard.orgName;
    //部门
    if (myVcard.orgUnits.count > 0) {
        self.orgUnitLabel.text = myVcard.orgUnits[0];
    }
    //职位
    self.titleLabel.text = myVcard.title;
#warning myVcard.telecomsAddresses 这个get方法，没有对电子名片的xml数据进行解析
    //使用note字段充当电话
    //电话
    self.phoneLabel.text = myVcard.note;
    //邮箱
    //使用mailer充当
    self.emailLabel.text = myVcard.mailer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return 5;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell的tag
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSInteger tag = cell.tag;
    //判断
    if (tag == 2) {//不做任何操作
        WCLog(@"不做任何操作");
        return;
    }
    if (tag == 0) {//选择照片
        WCLog(@"选择照片");
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相" otherButtonTitles:@"相册", nil];
        [sheet showInView:self.view];
    }else{//跳到下一个控制器
        WCLog(@"跳到下一个控制器");
    }
}
#pragma actionSheet代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    //设置允许编辑
    imagePicker.allowsEditing = YES;
    if (buttonIndex == 0) {//相机
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{//相册
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //显示图片选择器
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark 图片选择器的代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    WCLog(@"%@", info);
    //设置图片
    self.headerView.image = info[UIImagePickerControllerEditedImage];
    //隐藏当前的模态窗口
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
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
