//
//  TSOClubSearchResultTableViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/12/6.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOClubSearchResultTableViewController.h"
#import "ClubArticleModel.h"
#import "ClubArticle.h"
#import "TSOClubNoticeDetailViewController.h"

@interface TSOClubSearchResultTableViewController ()



@end

static NSString *const kTSOClubTableViewCell = @"kTSOClubTableViewCell";

@implementation TSOClubSearchResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[TSOClubTableViewCell class] forCellReuseIdentifier:kTSOClubTableViewCell];
//    self.tableView.emptyDataSetSource = self;
//    self.tableView.emptyDataSetDelegate = self;
//    self.tableView.tableFooterView = [UIView new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSearchDataList:(NSMutableArray *)searchDataList{
    _searchDataList = searchDataList;
    if (_searchDataList.count == 0) {
        UIImageView *placeHoderImageView = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
        placeHoderImageView.image = EmptyImage;
        self.tableView.tableFooterView = placeHoderImageView;
    }else{
        self.tableView.tableFooterView = [UIView new];
    }
    [self.tableView reloadData];
}

//#pragma mark - DZNEmptyDataSetSource
//
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
//    return EmptyImage;
//}
//- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
//    return WHITECOLOR;
//}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClubArticle *model;
    if (self.searchDataList.count > 0) {
       model = self.searchDataList[indexPath.row];
    }
    
    TSOClubTableViewCell *clubCell = [tableView dequeueReusableCellWithIdentifier:kTSOClubTableViewCell];
    clubCell.model = model;
    return clubCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ClubArticle *model;
    if (self.searchDataList.count > 0) {
        model = self.searchDataList[indexPath.row];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        if (_callBack) {
            _callBack(model);
        }
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

@end
