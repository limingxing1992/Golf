//
//  TSOClubHomePageArticleTableViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/12/6.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOClubHomePageArticleTableViewController.h"
#import "ClubArticleModel.h"
#import "ClubArticle.h"

@interface TSOClubHomePageArticleTableViewController ()
/**俱乐部id*/
@property (nonatomic, strong) NSString *clubID;
/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;
/**page*/
@property (nonatomic, assign) NSInteger page;

@end

static NSString *const kTSOClubTableViewCell = @"kTSOClubTableViewCell";

@implementation TSOClubHomePageArticleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    weak(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestClubArticle];
        
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [weakSelf requestClubArticle];
        
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    [self.tableView registerClass:[TSOClubTableViewCell class] forCellReuseIdentifier:kTSOClubTableViewCell];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView.mj_header beginRefreshing];
}

- (instancetype)initWithClubID:(NSString *)clubID{
    if (self = [super init]) {
        self.clubID = clubID;
    }
    return self;
}

- (void)requestClubArticle{
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    NSDictionary *parameter = @{@"clubId":_clubID,
                                @"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                @"pageSize":PAGESIZE,
                                @"type":@"20"};
    
    
    [ShareBusinessManager.clubManager getClubArticleListWithParameters:parameter success:^(id responObject) {
        ClubArticleModel *model = (ClubArticleModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            
            if (model.data.dataList.count > 0) {
                
                [self.dataList addObjectsFromArray:model.data.dataList];
                self.page ++;
                [self.tableView reloadData];
            }
            if (model.data.dataList.count < PAGESIZE.integerValue) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            NSInteger cellCount = self.tableView.frame.size.height /100;
            if (self.dataList.count < cellCount + 1) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
            }
            
            if (self.dataList.count == 0) {
                self.tableView.tableFooterView = [[UIImageView alloc] initWithImage:EmptyImage];
            }else{
                self.tableView.tableFooterView = [UIView new];
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClubArticle *model = self.dataList[indexPath.row];
    TSOClubTableViewCell *clubCell = [tableView dequeueReusableCellWithIdentifier:kTSOClubTableViewCell];
    
    model.from = @3;
    clubCell.model = model;
    return clubCell;
}

@end
