//
//  MyMessageSystemMsgViewController.m
//  GolfIOS
//
//  Created by mac mini on 16/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyMessageSystemMsgViewController.h"
#import "MyMessageSysMsgCell.h"

static NSString * MyMessageSysMsgCellid = @"MyMessageSysMsgCellid";
static CGFloat sectionHeight = 10;

@interface MyMessageSystemMsgViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 列表*/
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyMessageSystemMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"系统消息";
    //self.isAutoBack = NO;
    //[self loadData];
    [self setUI];
    
    
}
-(void)setUI{
    //加载列表视图
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.bottom.equalTo(self.view);
    }];
    
}
#pragma mark - tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }
    return  sectionHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
    
}
#pragma mark - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyMessageSysMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:MyMessageSysMsgCellid forIndexPath:indexPath];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - 控件懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        //不显示滚动指示器
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 100.0f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[MyMessageSysMsgCell class] forCellReuseIdentifier:MyMessageSysMsgCellid];
    }
    return _tableView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
