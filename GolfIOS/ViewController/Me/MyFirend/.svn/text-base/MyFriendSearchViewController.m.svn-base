//
//  MyFriendSearchViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/24.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyFriendSearchViewController.h"

@interface MyFriendSearchViewController ()

@end

@implementation MyFriendSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MyFriendUserTableViewCell class] forCellReuseIdentifier:@"resultCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyFriendUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell"];
    FriendUserModel *itemModel = self.dataArray[indexPath.row];
    cell.model = itemModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
