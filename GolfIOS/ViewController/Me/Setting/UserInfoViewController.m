//
//  UserInfoViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/5.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "UserInfoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@interface UserInfoViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UIImagePickerControllerDelegate,UINavigationControllerDelegate
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleData_0;

@property (nonatomic, strong) NSArray *titleData_1;
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 昵称*/
@property (nonatomic, strong) UILabel *nameLb;
/** 公开按钮*/
@property(nonatomic,strong) UIButton *openBtn;
/** 不公开按钮*/
@property(nonatomic,strong) UIButton *closeBtn;
/** 按钮点击的逻辑*/
@property(nonatomic,assign) BOOL isOpen;




@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"个人资料";
    self.isAutoBack = NO;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _nameLb.text = [UserModel sharedUserModel].nickName;
}


- (void)initData{
    _titleData_0 = @[@"头像", @"昵称", @"性别", @"修改密码"];
    _titleData_1 = @[@"杆数", @"差点"];
}

#pragma mark ----------------界面逻辑
- (BOOL)buttonClick:(UIButton *)button {
    
    //切换点击效果
    if (button.isSelected) {
        return NO;
    }
    button.selected = !button.selected;
    
    if (button.tag == 100) {
        self.closeBtn.selected = false;
        self.isOpen = true;
    }else{
        self.openBtn.selected = false;
        self.isOpen = false;
    }
    
    NSString *sex ;
    if (self.isOpen) {
        //当前切换男
        sex = @"1";
    }else{
        //当前切换女
        sex = @"2";
    }
    
    [ShareBusinessManager.loginManager postEditUserInfoWithParameters:@{@"sex":sex}
                                                              success:^(id responObject) {
                                                                  
                                                                  [GOLFNotificationCenter postNotificationName:UserInfoUpdate object:nil];
                                                                  
                                                              } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                  [SVProgressHUD showErrorWithStatus:errorMsg];
                                                              }];
    
    
    
    
    
    
    return self.isOpen;
}

/** 点击方法*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GOLFWeakObj(self);
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {//点击头像
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *action_cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *action_camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //拍照
                    [weakself pickerImage:UIImagePickerControllerSourceTypeCamera];

                }];
                UIAlertAction *action_photo = [UIAlertAction actionWithTitle:@"选取相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //相册
                    [weakself pickerImage:UIImagePickerControllerSourceTypePhotoLibrary];

                }];
                [alertVc addAction:action_cancel];
                [alertVc addAction:action_camera];
                [alertVc addAction:action_photo];
                [self presentViewController:alertVc animated:YES completion:nil];
                
            }
                break;
            case 1:
            {//点击昵称
                UserEditInfoViewController *editvc = [[UserEditInfoViewController alloc] init];
                editvc.infoStyle = 0;
                [self.navigationController pushViewController:editvc animated:YES];
                
            }
                break;
            case 3:
            {//点击修改密码
                UserEditInfoViewController *editvc = [[UserEditInfoViewController alloc] init];
                editvc.infoStyle = 1;
                [self.navigationController pushViewController:editvc animated:YES];

            }
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1){
        
    }

}

#pragma mark ---------图片选择

-(void)pickerImage:(UIImagePickerControllerSourceType)type
{
    //判断是否能用
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController *picker =[[UIImagePickerController alloc] init];
        picker.sourceType = type;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        //        NSLog(@"不行");
        [SVProgressHUD showErrorWithStatus:@"相机无法启动"];
    }
    
    
}


#pragma mark ----------图片选择器代理

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.headIv.image = info[UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //选取完成
    NSDictionary *parameter = @{@"file":@".png",
                                @"menu":@"userInfo"};
    [ShareBusinessManager.clubManager upLoadImageWith:@[self.headIv.image] parameters:parameter success:^(id responObject) {
        NSArray *data = responObject[@"data"];
        if (data.count) {
            [ShareBusinessManager.loginManager postEditUserInfoWithParameters:@{@"headUrl":data.firstObject} success:^(id responObject) {
                [SVProgressHUD showSuccessWithStatus:@"修改头像成功"];
                //刷新用户资料
                [GOLFNotificationCenter postNotificationName:UserInfoUpdate object:nil];
            } failure:^(NSInteger errCode, NSString *errorMsg) {
                [SVProgressHUD showErrorWithStatus:errorMsg];
            }];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 重写高亮方法
- (void)setHighlighted:(BOOL)highlighted {
    
}



#pragma mark ----------------tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return _titleData_0.count;
        }
            break;
        case 1:
        {
            return _titleData_1.count;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"userInfo"];
    cell.textLabel.font = FONT(14);
    cell.textLabel.textColor = BLACKTEXTCOLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];
    cell.detailTextLabel.font =  FONT(14);
    cell.detailTextLabel.textColor = BLACKTEXTCOLOR;
    if (indexPath.section == 0) {
        cell.textLabel.text = _titleData_0[indexPath.row];
        if (indexPath.row == 0) {
            [cell addSubview:self.headIv];
            self.headIv.sd_layout
            .centerYEqualToView(cell)
            .rightSpaceToView(cell.accessoryView, 5)
            .heightIs(37.5)
            .widthEqualToHeight();
            [self.headIv setSd_cornerRadiusFromWidthRatio:@0.5];
        }
        if (indexPath.row == 1) {
            [cell addSubview:self.nameLb];
            self.nameLb.sd_layout
            .centerYEqualToView(cell)
            .rightSpaceToView(cell.accessoryView, 5)
            .autoHeightRatio(0);
            [self.nameLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
        }
        if (indexPath.row == 2) {
            cell.accessoryView = [self sectionTwoAccessoryView];
        }
    }else if (indexPath.section == 1){
        cell.accessoryView = nil;
        cell.textLabel.text = _titleData_1[indexPath.row];
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = [UserModel sharedUserModel].polesNumber;
        }else if (indexPath.row == 1){
            cell.detailTextLabel.text = [UserModel sharedUserModel].handicap;
        }
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = BACKGROUNDCOLOR;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}


#pragma mark ----------------实例

-(UIView *)sectionTwoAccessoryView{
    UIView *accessoryView = [[UIView alloc] init];
    accessoryView.backgroundColor = WHITECOLOR;
    accessoryView.size = CGSizeMake(70, 15);
    
    
    UIButton *btn1 = [[UIButton alloc] init];
    [btn1 setTitle:@"男" forState:UIControlStateNormal];
    btn1.tag = 100;
    btn1.titleLabel.font = FONT(14);
    [btn1 setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
    [btn1 setImage:IMAGE(@"classify167") forState:UIControlStateNormal];
    [btn1 setImage:IMAGE(@"classify167") forState:UIControlStateHighlighted];
    [btn1 setImage:IMAGE(@"classify166") forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
    btn1.frame = CGRectMake(0, 0, accessoryView.bounds.size.width*0.5, accessoryView.bounds.size.height);
    [accessoryView addSubview:btn1];
    self.openBtn = btn1;
    
    
    UIButton *btn2 = [[UIButton alloc] init];
    [btn2 setTitle:@"女" forState:UIControlStateNormal];
    btn2.tag = 101;
    btn2.titleLabel.font = FONT(14);
    [btn2 setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
    [btn2 setImage:IMAGE(@"classify167") forState:UIControlStateNormal];
    [btn2 setImage:IMAGE(@"classify167") forState:UIControlStateHighlighted];
    [btn2 setImage:IMAGE(@"classify166") forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
    btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame), 0, accessoryView.bounds.size.width*0.5, accessoryView.bounds.size.height);
    [accessoryView addSubview:btn2];
    self.closeBtn = btn2;
    
    if ([UserModel sharedUserModel].sex == 0 || [UserModel sharedUserModel].sex == 1) {
        btn1.selected = YES;
        btn2.selected = NO;
    }else{
        btn1.selected = NO;
        btn2.selected = YES;
    }
    
    return accessoryView;
    
}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        [_headIv sd_setImageWithURL:FULLIMGURL([UserModel sharedUserModel].headUrl) placeholderImage:Placeholder_small];
    }
    return _headIv;
}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(14);
        _nameLb.textColor = LIGHTTEXTCOLOR;
        if ([[UserModel sharedUserModel].nickName length]) {
            _nameLb.text = [UserModel sharedUserModel].nickName;
        }else{
            _nameLb.text = [UserModel sharedUserModel].userName;
        }
    }
    return _nameLb;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.separatorInset = UIEdgeInsetsZero;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"userInfo"];
    }
    return _tableView;
}


@end
