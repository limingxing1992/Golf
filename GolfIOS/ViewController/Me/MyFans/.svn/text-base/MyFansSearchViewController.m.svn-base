//
//  MyFansSearchViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/24.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyFansSearchViewController.h"

@interface MyFansSearchViewController ()

@end

@implementation MyFansSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[MyFansTableViewCell class] forCellReuseIdentifier:@"resultCell"];
    self.tableView.rowHeight = 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyFansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //进入社区主页
    FriendUserModel *model = self.dataArray[indexPath.row];
    [self dismissViewControllerAnimated:YES completion:^{
        if (_block) {
            _block(model);
        }
    }];
}

@end
