//
//  APIChosseTableViewController.m
//  YSSCIOS
//
//  Created by 李明星 on 16/9/27.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "APIChosseTableViewController.h"

@interface APIChosseTableViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, copy) NSString *currentAPI;

@end

@implementation APIChosseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"选择API";
    self.isAutoBack = NO;
    [self.view addSubview:self.tableView];
    _currentAPI = [GOLFUserDefault objectForKey:@"currentAPI"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
/** 初始化数据*/
- (void)initData{
    _data = @[RealAPI,HostAPI, TestAPI_0, TestAPI_1];
}

#pragma mark ----------------界面逻辑

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_currentAPI isEqualToString:_data[indexPath.row]]) {
        return;
    }else{
        [GOLFUserDefault setObject:_data[indexPath.row] forKey:@"currentAPI"];
        [SVProgressHUD showInfoWithStatus:@"程序即将退出，请重新进入"];
        [self performSelector:@selector(exitAPP) withObject:nil afterDelay:2];
    }
}
/** APP退出*/
- (void)exitAPP{
    exit(0);
}

#pragma mark ----------------tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"apiCell"];
    cell.textLabel.font = FONT(16);
    cell.textLabel.textColor = SHENTEXTCOLOR;
    cell.textLabel.text = _data[indexPath.row];
    if ([_currentAPI isEqualToString:_data[indexPath.row]]) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify155")];
    }
    return cell;
}

#pragma mark ----------------实例

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT)];
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.separatorInset = UIEdgeInsetsZero;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"apiCell"];
    }
    return _tableView;
}


@end
