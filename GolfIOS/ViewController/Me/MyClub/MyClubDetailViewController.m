//
//  ClubDetailViewController.m
//  GolfIOS
//
//  Created by wyao on 2016/11/14.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyClubDetailViewController.h"
#import "MyClubDetailViewCell.h"
#import "MyClubNewApplyViewController.h"

static NSString* cellid = @"cellid";
static NSString*  createdCellid = @"createdCellid";
@interface MyClubDetailViewController ()<
UITableViewDelegate,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate,
UITableViewDataSource>

@property(nonatomic,copy) UITableView *tableView;
/** 俱乐部名称*/
@property(nonatomic,copy) NSString *clubName;
/** 俱乐部介绍*/
@property(nonatomic,copy) NSString *introduction;


/****头部视图控件***/
/** 已创建头部视图*/
@property(nonatomic,strong) UIView *createdView;
/** 俱乐部名称*/
@property(nonatomic,strong) UILabel *nameLabel;
/** 俱乐部头像*/
@property(nonatomic,strong) UIImageView *iconView;
/** 俱乐部成员总数*/
@property(nonatomic,strong) UILabel *memberCountLabel;
/** 俱乐部成员数*/
@property(nonatomic,strong) UILabel *memberLabel;
/** 俱乐部申请*/
@property(nonatomic,strong) UILabel *applyLabel;
/** 申请的人数*/
@property(nonatomic,strong) UILabel *checkLabel;



/****网络数据***/
/** 数据页数*/
@property (nonatomic, assign) NSInteger page;
/** 数据列表*/
@property (nonatomic, strong) NSMutableArray *dataList;
/** 俱乐部介绍模型*/
@property (nonatomic, strong) MyClubModel *DetailModel;

@end

@implementation MyClubDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GRAYCOLOR;
    self.isAutoBack = NO;
    self.name = self.model.clubName;
    
    //初始化UI
    [self setUI];
    //请求数据
    [self requestData];    
    //注册通知
    [GOLFNotificationCenter addObserver:self selector:@selector(UploadData) name:@"updateApplyList" object:nil];
}

/** 接收通知刷新数据*/
-(void)UploadData{
    [self.tableView.mj_header beginRefreshing];
    [self.tableView reloadData];
}


- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}


#pragma mark - 设置数据
-(void)setModel:(MyClubItemModel *)model{
    _model = model;
    //设置信息
    self.clubName = !model.clubName ? @"未知俱乐部" : model.clubName;
    self.clubId = !model.clubId ? nil: model.clubId;
}


-(void)setDetailModel:(MyClubModel *)DetailModel{
    
    _DetailModel = DetailModel;
    
    self.nameLabel.text = !DetailModel.clubName ? @"未知俱乐部" : DetailModel.clubName;
    [self.iconView sd_setImageWithURL:FULLIMGURL(DetailModel.logoUrl) placeholderImage:Placeholder_small];
    self.memberCountLabel.text = !DetailModel.totalNum ? @"未知数字" : DetailModel.totalNum;
    self.checkLabel.text = !DetailModel.checkNum ? @"未知数字" : DetailModel.checkNum;
    self.introduction = !DetailModel.introduction ? @"没有介绍信息" : DetailModel.introduction;
    [self.tableView reloadData];
}

#pragma mark - 初始化UI
-(void)setUI{
    
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.tableView];
    //布局
    self.createdView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 175);
    [self setCreatedViewUI];
    //设置为tableView的头部视图
    self.tableView.tableHeaderView = self.createdView;
}

#pragma mark - 已创建的申请按钮点击事件
-(void)btnClick{
    if ([self.checkLabel.text isEqualToString:@"0"]) {
        return;
    }
    MyClubNewApplyViewController *vc = [[MyClubNewApplyViewController alloc] init];
    //NSLog(@"self.clubId-------->%@",self.clubId);
    vc.clubId = self.clubId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 请求网络数据
-(void)requestData{
    
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    //俱乐部参数字段
    NSDictionary *DetailParameter = @{@"clubId":self.clubId};
    //请求俱乐部详情
    [ShareBusinessManager.userManager  postMyClubSelfDetailWithParameters:DetailParameter success:^(id responObject) {
       //设置数据
        MyClubModel *model = [[MyClubModel alloc] init];
        model = responObject;
        self.DetailModel = model;

    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
    
    
    //过往消息字段
    NSDictionary *historyParameter = @{@"clubId":self.clubId,
                                       @"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                       @"pageSize":PAGESIZE.stringValue};

    
    [ShareBusinessManager.userManager postMyClubHistoryHistoryClubArticleListWithParameters:historyParameter success:^(id responObject) {
         [self dataWithArray:responObject];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
    

}

#pragma mark - 获取数组里面的模型
-(void)dataWithArray:(NSArray *)responObject{
    
    //遍历数据模型数组
    for (MyClubHistoryArcticleItemModel *model in responObject) {
            [self.dataList addObject:model];
        }
    [self.tableView reloadData];

    if (self.dataList.count > 0) {
        self.page ++;
        [self.tableView reloadData];
    }
    
    if (self.dataList.count < PAGESIZE.integerValue) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }

}

#pragma mark - 空白页代理
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}

#pragma mark - 数据源方法
// 有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
        return 2;
}

// 有多少行
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return self.dataList.count;
    }
}

// cell内容
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {
        MyClubDetailViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.introduction = self.DetailModel.introduction;
        return cell;
    }
    else {
        MyClubDetailViewCell* cell = [tableView dequeueReusableCellWithIdentifier:createdCellid];
        cell.flag = indexPath.section;
        cell.historyModel = self.dataList[indexPath.row];
        return cell;
    }
}

// 设置组头的高度
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
        return 30;
}
//自动获取高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        return 100;
    }
    //获取高度
    CGFloat height = [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
    return height;
}


//组视图
- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    
        UIView *view = [[UIView alloc] init];
        UILabel* headerLabel = [[UILabel alloc] init];
        if (section == 0) {
            headerLabel.text = @"俱乐部介绍";
        }else{
            headerLabel.text = @"过往消息";
        }
        headerLabel.font = [UIFont systemFontOfSize:14];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = LIGHTTEXTCOLOR;
        
        view.backgroundColor = BACKGROUNDCOLOR;
        [view addSubview:headerLabel];
        [headerLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.offset(10);
            make.centerY.offset(0);
        }];
        return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 懒加载控件
- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
        
    }
    return _dataList;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.separatorColor = GRAYCOLOR;;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        
        [_tableView registerClass:[MyClubDetailViewCell class] forCellReuseIdentifier:cellid];
        [_tableView registerClass:[MyClubDetailViewCell class] forCellReuseIdentifier:createdCellid];
        _tableView.frame = CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT -NaviBar_HEIGHT);
        
        self.page = 1;
        
        weak(self);
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestData];
            
        }];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            [weakSelf requestData];
            [weakSelf.tableView.mj_header endRefreshing];
        }];



    }
    return _tableView;
}

#pragma mark - 初始化已创建的头部视图
-(void)setCreatedViewUI{
    
    self.view.backgroundColor = GRAYCOLOR;
    
    //第一块视图
    UIView *firstView = [[UIView alloc] init];
    firstView.backgroundColor = WHITECOLOR;
    firstView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 118);
    [self.createdView addSubview:firstView];
    [firstView addSubview:self.iconView];
    [firstView addSubview:self.nameLabel];
    
    //布局
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView).offset(18);
        make.centerX.equalTo(firstView);
        make.width.height.offset(58);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconView);
        make.top.equalTo(self.iconView.mas_bottom).offset(12);
    }];
    
    
    
    //第二块视图
    UIView *secondView = [[UIView alloc] init];
    secondView.backgroundColor = WHITECOLOR;
    secondView.frame = CGRectMake(0, 119, (SCREEN_WIDTH -1)*0.5, 56);
    [self.createdView addSubview:secondView];
    [secondView addSubview:self.memberLabel];
    [secondView addSubview:self.memberCountLabel];
    
    //布局
    [self.memberCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(secondView);
        make.top.equalTo(secondView).offset(14);
    }];
    [self.memberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.memberCountLabel);
        make.top.equalTo(self.memberCountLabel.mas_bottom).offset(7);
    }];
    
    
    
    //第三块视图
    UIView *thirdView = [[UIView alloc] init];
    thirdView.backgroundColor = WHITECOLOR;
    thirdView.frame = CGRectMake((SCREEN_WIDTH -1)*0.5 +1,119, (SCREEN_WIDTH -1)*0.5, 56);
    [self.createdView addSubview:thirdView];
    [thirdView addSubview:self.checkLabel];
    [thirdView addSubview:self.applyLabel];
    
    //为了点击加上一层btn蒙版
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor clearColor];
    btn.userInteractionEnabled = YES;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [thirdView addSubview:btn];
    
    //布局
    [self.checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(thirdView);
        make.top.equalTo(thirdView).offset(14);
    }];
    
    [self.applyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.checkLabel);
        make.top.equalTo(self.checkLabel.mas_bottom).offset(7);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(thirdView);
    }];
}




#pragma mark - 懒加载已加入的头部视图

-(UIView *)createdView{
    if (!_createdView) {
        _createdView = [[UIView alloc] init];
    }
    return _createdView;
}


-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        [_iconView sd_setImageWithURL:FULLIMGURL(self.DetailModel.logoUrl) placeholderImage:Placeholder_small];
    }
    return _iconView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = self.clubName;//需要赋值，先写死
        _nameLabel.font = FONT(12);
        [_nameLabel setTextColor:[UIColor darkGrayColor]];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

-(UILabel *)memberLabel{
    //成员数label
    if (!_memberLabel) {
        _memberLabel = [[UILabel alloc] init];
        _memberLabel.text = @"成员数";
        _memberLabel.font = FONT(12);
        [_memberLabel setTextColor:LIGHTTEXTCOLOR];
        _memberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _memberLabel;
}
-(UILabel *)memberCountLabel{
    if (!_memberCountLabel) {
        _memberCountLabel = [[UILabel alloc] init];
        //_memberCountLabel.text = self.totalNum;//需要赋值，先写死
        _memberCountLabel.font = FONT(12);
        [_memberCountLabel setTextColor:SHENTEXTCOLOR];
        _memberCountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _memberCountLabel;
}
-(UILabel *)applyLabel{
    if (!_applyLabel) {
        _applyLabel = [[UILabel alloc] init];
        _applyLabel.text = @"新申请";
        _applyLabel.font = FONT(12);
        [_applyLabel setTextColor:[UIColor darkGrayColor]];
        _applyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _applyLabel;
}
-(UILabel *)checkLabel{
    if (!_checkLabel) {
        _checkLabel= [[UILabel alloc] init];
       // _checkLabel.text = self.checkNum;//设置数据
        _checkLabel.font = FONT(12);
        [_checkLabel setTextColor:GLOBALCOLOR];
        _checkLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _checkLabel;
}

@end
