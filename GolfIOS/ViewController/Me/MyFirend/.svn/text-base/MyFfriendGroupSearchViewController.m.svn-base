//
//  MyFfriendGroupSearchViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/24.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyFfriendGroupSearchViewController.h"

@interface MyFfriendGroupSearchViewController ()

@end

@implementation MyFfriendGroupSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[MyAddGroupFriendTableViewCell class] forCellReuseIdentifier:@"friendCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyAddGroupFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell"];
    FriendUserModel *itemModel = self.dataArray[indexPath.row];
    cell.model = itemModel;
    return cell;
    
    
}
@end
