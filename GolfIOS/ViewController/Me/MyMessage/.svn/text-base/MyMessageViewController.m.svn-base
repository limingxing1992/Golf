//
//  MyMessageViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/8.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MyMessageCommentViewController.h"
#import "MyMessageSystemMsgViewController.h"

static NSString * MyMsgHomeTableViewCellid = @"MyMsgHomeTableViewCellid";
static CGFloat rowHeight = 65;

@interface MyMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 列表*/
@property (nonatomic, strong) UITableView *tableView;
/** 上半部数据*/
@property (nonatomic, strong) NSArray *listData0;
/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) MyMessageSysNumModel *NumModel;

@property (nonatomic, strong) UIButton *dynamicButton;
@property (nonatomic, strong) UIButton *sysMSgButton;

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.name = @"我的消息";
    self.isAutoBack = NO;
    
    _listData0 =@[
                  @{@"title":@"我的动态",@"imageName":@"classify171"},
                  @{@"title":@"系统消息",@"imageName":@"classify172"}
                  ];
    
    [self loadData];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, _listData0.count * rowHeight);
    
    //注册通知
    [GOLFNotificationCenter addObserver:self selector:@selector(updateSysMsgNum) name:@"updateSysMsgNum" object:nil];
    [GOLFNotificationCenter addObserver:self selector:@selector(updateDynamicNum) name:@"updateDynamicNum" object:nil];

}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}

-(void)updateSysMsgNum{
    self.NumModel.sysMsgNum = @"0";
    [self.tableView reloadData];
}
-(void)updateDynamicNum{
    self.NumModel.dynamicNum = @"0";
    [self.tableView reloadData];
}



-(void)loadData{
    
    [self.dataList removeAllObjects];
    [ShareBusinessManager.userManager postMyMessageSystemNewNumWithParameters:nil success:^(id responObject) {
        self.NumModel = responObject ;
        [self.tableView reloadData];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}


#pragma mark - tableView 数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.listData0.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return rowHeight;
}

#pragma mark - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *info;
    info = _listData0[indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyMsgHomeTableViewCellid];
    [cell setCell:cell textFont:FONT(14) textColor:SHENTEXTCOLOR detailtextFont:FONT(12) detailTextColor:LIGHTTEXTCOLOR accessoryViewImage:@"classify8"];
    cell.textLabel.text = info[@"title"];
    cell.imageView.image = IMAGE(info[@"imageName"]);
    
    switch (indexPath.row) {
        case 0:
        {
            //判断消息是否存在
            if ([self.NumModel.dynamicNum isEqualToString:@"0"] || !self.NumModel.dynamicNum) {
                return cell;
            }else{
                
                [cell.imageView addSubview:self.dynamicButton];
                [self setFrameWithButton:self.dynamicButton numString:self.NumModel.dynamicNum];
            }

        }
            break;
            
         case 1:
        {
            //判断消息是否存在
            if ([self.NumModel.sysMsgNum isEqualToString:@"0"] || !self.NumModel.sysMsgNum) {
                return cell;
            }else{
                [cell.imageView addSubview:self.sysMSgButton];
                [self setFrameWithButton:self.sysMSgButton numString:self.NumModel.sysMsgNum];
            }

        }
            break;
            
        default:
            break;
    }
    
    return cell;

}

-(void)setFrameWithButton:(UIButton*)btn numString:(NSString*)numString{
    
    if ([numString integerValue] < 10) {
        btn.frame = CGRectMake(26, -2, 15, 15);
        [btn setTitle:numString forState:UIControlStateNormal];
    }else if ([numString integerValue] < 100){
        btn.frame = CGRectMake(26, -2, 18, 15);
        [btn setTitle:numString forState:UIControlStateNormal];
    }else{
        btn.frame = CGRectMake(26, -2, 25, 15);
        [btn setTitle:@"99+" forState:UIControlStateNormal];
    }
    
}

/** 进入各次级页面*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中效果
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
        switch (indexPath.row) {
            case 0:
            {//进入我的评论
                MyMessageCommentViewController *commentViewVc = [[MyMessageCommentViewController alloc] init];
                [self.navigationController pushViewController:commentViewVc animated:YES];
            }
                break;
            case 1:
            {//进入系统消息
                MyMessageSystemMsgViewController *SystemMsgViewVc = [[MyMessageSystemMsgViewController alloc] init];
                [self.navigationController pushViewController:SystemMsgViewVc animated:YES];
            }
                break;
            default:
                break;
        }
}


#pragma mark - 控件懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MyMsgHomeTableViewCellid];
    }
    return _tableView;
    
}

- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}
-(UIButton *)dynamicButton{
    if (!_dynamicButton) {
        
        _dynamicButton = [[UIButton alloc] init];
        [_dynamicButton setBackgroundImage:IMAGE(@"classify173") forState:UIControlStateNormal];
        _dynamicButton.userInteractionEnabled = NO;
        [_dynamicButton setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        _dynamicButton.titleLabel.font = FONT(12);
        //    btn.layer.borderColor = [UIColor redColor].CGColor;
        [_dynamicButton.layer setMasksToBounds:YES];
        [_dynamicButton.layer setCornerRadius:6];
        //    [btn.layer setBorderWidth:0.5];

    }
    return _dynamicButton;
}
-(UIButton *)sysMSgButton{
    if (!_sysMSgButton) {
        _sysMSgButton = [[UIButton alloc] init];
        //[_sysMSgButton setBackgroundImage:IMAGE(@"classify173") forState:UIControlStateNormal];
        [_sysMSgButton setBackgroundColor:[UIColor redColor]];
        _sysMSgButton.userInteractionEnabled = NO;
        [_sysMSgButton setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        _sysMSgButton.titleLabel.font = FONT(12);
        [_sysMSgButton.layer setMasksToBounds:YES];
        [_sysMSgButton.layer setCornerRadius:7];
    }
    return _sysMSgButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
