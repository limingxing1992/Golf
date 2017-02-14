//
//  MyMessageGetCommentViewController.m
//  GolfIOS
//
//  Created by wyao on 16/12/9.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyMessageSendCommentViewController.h"
#import "CommunityArticleModel.h"
#import "MyMessageCommentCellModel.h"
#import "MyMessageCommentCell.h"

static NSString * MyMessageCommentCellid = @"MyMessageCommentCellid";
@interface MyMessageSendCommentViewController ()
/** 数据页数*/
@property (nonatomic, assign) NSInteger page;
/**数据列表*/
@property (nonatomic, strong) NSMutableArray *dataList;
@end


@implementation MyMessageSendCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    self.page = 1;
    self.tableView.separatorColor = GRAYCOLOR;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = BACKGROUNDCOLOR;
    //不显示滚动指示器
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加上啦刷新和下拉加载
    weak(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestData];
        
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [weakSelf requestData];
        
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    [self.tableView registerClass:[MyMessageCommentCell class] forCellReuseIdentifier:MyMessageCommentCellid];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 请求网络数据
-(void)requestData{
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    NSDictionary *parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                @"pageSize":PAGESIZE.stringValue};
    
    [ShareBusinessManager.communityManager getCommunityArticleListWithParameters:parameter success:^(id responObject) {
        CommunityArticleModel *model = (CommunityArticleModel *)responObject;
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
            
            
            NSInteger cellCount = self.view.frame.size.height /100;//test
            if (model.data.dataList.count < cellCount) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
                [self.tableView.mj_footer setState:MJRefreshStateIdle];
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


#pragma mark - tableView代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取高度
    CGFloat height = [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}


#pragma mark - tableView的数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyMessageCommentCell *communityCell = [tableView dequeueReusableCellWithIdentifier:MyMessageCommentCellid]
    ;

    MyMessageCommentCellModel *model;
    
    if (_dataList.count >0) {
        model = _dataList[indexPath.row];
    }
    
    communityCell.flag = true;
    communityCell.cellModel = model;
    
    
    return communityCell;
    
}



#pragma mark - 控件懒加载

- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
        
    }
    return _dataList;
}

@end
