//
//  SettingViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/1.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
/** 设置列表*/
@property (nonatomic, strong) UITableView *tableView;
/** 设置标题*/
@property (nonatomic, strong) NSArray *titleAry_1;
/** 底部退出登录按钮*/
@property (nonatomic, strong) UIButton *exitBtn;
/**标志图标*/
@property (nonatomic, strong) UIImageView *bottomIv;



@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"设置";
    [self.contentView setBackgroundColor:WHITECOLOR];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.exitBtn];
    [self.contentView addSubview:self.bottomIv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutSubViews];
}
/** 初始化数据*/
- (void)initData{
    _titleAry_1 = @[@"清空缓存", @"当前版本", @"关于高尔夫", @"意见反馈", @"切换API"];

}
/** 自动布局*/
- (void)autoLayoutSubViews{
    _tableView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(_titleAry_1.count *45);
    
    _exitBtn.sd_layout
    .topSpaceToView(_tableView, 50)
    .leftSpaceToView(self.contentView, 75)
    .rightSpaceToView(self.contentView, 75)
    .heightIs(50);
    
    _bottomIv.sd_layout
    .bottomSpaceToView(self.contentView,20)
    .centerXEqualToView(self.contentView)
    .heightIs(40)
    .widthIs(150);
}

#pragma mark ----------------界面逻辑
/** 退出登录*/
- (void)exitAction{
    GOLFWeakObj(self);
    if (!IsLogin) {
        [SVProgressHUD showErrorWithStatus:@"暂未登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself presentViewController:LoginNavi animated:YES completion:nil];
        });
        return;
    }
    [GOLFUserDefault removeObjectForKey:@"userInfo"];//清除用户资料缓存
    [JPUSHService setAlias:@"" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];//清除极光推送别名设置
    [SVProgressHUD showSuccessWithStatus:@"退出成功"];
    [UserModel attempDealloc];//清除模型
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself presentViewController:LoginNavi animated:YES completion:nil];
    });
}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

/** cell点击*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //清空缓存
        [[SDImageCache sharedImageCache] clearDisk];//清除图片缓存
        [SVProgressHUD showWithStatus:@"正在清除"];
        GOLFWeakObj(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
            [weakself.tableView reloadData];
        });
    }else if (indexPath.row == 1){
        //检查更新(苹果审核不允许任何形式的内部更新了。。so，注释了)
    }else if (indexPath.row == 2) {
        //关于高尔夫
    }else if (indexPath.row == 3){
        //意见反馈
    }else if (indexPath.row ==4){
        //跳转测试服务器选择界面
        APIChosseTableViewController *chos = [[APIChosseTableViewController alloc] init];
        [self.navigationController pushViewController: chos animated:YES];
    }
}


#pragma mark ----------------tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleAry_1.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"settingCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = FONT(16);
    cell.textLabel.textColor  = SHENTEXTCOLOR;
    cell.detailTextLabel.font = FONT(16);
    cell.detailTextLabel.textColor = LIGHTTEXTCOLOR;
    
    cell.textLabel.text = _titleAry_1[indexPath.row];
    if (indexPath.row == 0) {
        NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
        NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
        cell.detailTextLabel.text = currentVolum;
    }else if(indexPath.row == 1){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"V %@", GOLF_VERSION];//当前使用内部版本号
    }else if (indexPath.row == 4){
        cell.detailTextLabel.text = [GOLFUserDefault objectForKey:@"currentAPI"];
    }
    
    return cell;

}

#pragma mark ----------------计算缓存大小

//计算出大小
- (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

#pragma mark ----------------实例化

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.scrollEnabled = NO;
        _tableView.separatorInset = UIEdgeInsetsZero;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"settingCell"];
    }
    return _tableView;
}

- (UIButton *)exitBtn{
    if (!_exitBtn) {
        _exitBtn = [[UIButton alloc] init];
        _exitBtn.titleLabel.font = FONT(18);
        [_exitBtn setBackgroundColor:WHITECOLOR];
        _exitBtn.layer.borderWidth = 0.5;
        _exitBtn.layer.borderColor = GLOBALCOLOR.CGColor;
        _exitBtn.layer.cornerRadius = 3;
        [_exitBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
        [_exitBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}

- (UIImageView *)bottomIv{
    if (!_bottomIv) {
        _bottomIv = [[UIImageView alloc] init];
        _bottomIv.image = IMAGE(@"settingLogo");
    }
    return _bottomIv;
}

@end
