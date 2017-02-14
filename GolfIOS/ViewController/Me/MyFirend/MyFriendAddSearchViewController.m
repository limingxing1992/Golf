//
//  MyFriendAddSearchViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/5.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyFriendAddSearchViewController.h"

@interface MyFriendAddSearchViewController ()

@end

@implementation MyFriendAddSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MyAddFriendTableViewCell class] forCellReuseIdentifier:@"addFriendCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyAddFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addFriendCell"];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.model = dict;
    GOLFWeakObj(self);
    cell.block = ^(id responObject){
        [weakself dismissViewControllerAnimated:YES completion:^{
            if (weakself.block) {
                weakself.block(responObject);
            }
        }];
    };
    return cell;
}

@end
