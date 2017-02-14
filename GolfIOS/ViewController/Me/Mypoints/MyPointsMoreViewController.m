//
//  MyPointsMoreViewController.m
//  GolfIOS
//
//  Created by wyao on 16/11/22.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyPointsMoreViewController.h"
#import "MyPointsMainViewCell.h"
#import "TSOPublishTopicViewController.h"
#import "TSOCommunityViewController.h"

static NSString* pointsHeaderCell = @"pointsHeaderCell";
static NSString*  pointsCommonCell = @"pointsCommonCell";
static NSString*  pointsMainCell = @"pointsMainCell";
@interface MyPointsMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 活动视图*/
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MyPointsMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.name = @"积分任务";
    self.isAutoBack = NO;
     [self setUI];
    
}
#pragma mark - 初始化UI
-(void)setUI{
    NSLog(@"加载视图");
    [self.view addSubview:self.tableView];
    //布局
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(NaviBar_HEIGHT);
        make.left.right.bottom.equalTo(self.view).offset(0);;
    }];
}

#pragma mark - tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 4;
}

#pragma mark - 组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return  6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
    
}
#pragma mark - 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 40;
        }
        return 115;
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        return 40;
    }
    return 88;
}



#pragma mark - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //每一组的第一行cell采用系统的样式
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:pointsHeaderCell];
        cell.textLabel.font = FONT(16);
        cell.textLabel.textColor = BLACKTEXTCOLOR;
        cell.imageView.image = IMAGE(@"classify154");
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            cell.textLabel.text = @"主要任务";
        }else if (indexPath.section == 1){
            cell.textLabel.text = @"常规任务";
        }
        return cell;
        
    }
    //第二组其他行使用系统样式带箭头
    else if (indexPath.section == 1) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:pointsCommonCell];
        cell.textLabel.font = FONT(16);
        cell.textLabel.textColor = BLACKTEXTCOLOR;
        cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];
        if (indexPath.row == 1) {
            cell.imageView.image = IMAGE(@"classify182");
            cell.textLabel.text = @"发帖";
        }else if(indexPath.row == 2){
            cell.imageView.image = IMAGE(@"classify184");
            cell.textLabel.text = @"评论";
        }else{
            cell.imageView.image = IMAGE(@"classify185");
            cell.textLabel.text = @"点赞";
        }
        return cell;
    }
    //第一组使用自定义的cell
    MyPointsMainViewCell *cell = [[MyPointsMainViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pointsMainCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, MAXFLOAT)];
    
    if (indexPath.row == 1) {
        [cell.btn setTitle:@"去充值" forState:UIControlStateNormal];
        cell.nameLabel.text = @"充值获取更多积分";
    }else if (indexPath.row == 2){
        [cell.btn setTitle:@"去预定" forState:UIControlStateNormal];
        cell.nameLabel.text = @"预定球场获取更多积分";
    }
    
    [cell.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;

}

#pragma mark - 常规任务点击cell的跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        switch (indexPath.row) {
            case 1:
            {//跳转社区发帖
                TSOPublishTopicViewController *publishVC = [[TSOPublishTopicViewController alloc] init];
                [self.navigationController pushViewController:publishVC animated:YES];
            }
                break;
            case 2:
            {//跳转社区列表
                TSOCommunityViewController *communityVC = [[TSOCommunityViewController alloc] initHideBottomBarPage];
                [self.navigationController pushViewController:communityVC animated:YES];
            }
                break;
            case 3:
            {//社区列表
                
            }
                break;
            default:
                break;
        }
    }

}

#pragma mark - 主要任务的点击事件
-(void)btnClick:(UIButton*)sender{
    
        MyPointsMainViewCell *btnCell = (id)sender.superview.superview;
        NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:btnCell];
        //NSLog(@"点击第%ld行",indexPath.row);
        if (cellIndexPath.row == 1) {
            [SVProgressHUD showSuccessWithStatus:@"去充值"];
            BirdWalletFillViewController *vc = [[BirdWalletFillViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (cellIndexPath.row == 2){
            [SVProgressHUD showSuccessWithStatus:@"预订球场"];
            PlaceAppointViewController *vc = [[PlaceAppointViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
}


#pragma mark - 懒加载控件
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.scrollEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = BACKGROUNDCOLOR;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:pointsHeaderCell];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:pointsCommonCell];
        [_tableView registerClass:[MyPointsMainViewCell class] forCellReuseIdentifier:pointsMainCell];
    }
    return _tableView;
    
 }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
