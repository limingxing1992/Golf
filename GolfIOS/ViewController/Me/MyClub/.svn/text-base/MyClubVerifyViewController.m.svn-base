//
//  VerifyViewController.m
//  GolfIOS
//
//  Created by mac mini on 16/11/15.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyClubVerifyViewController.h"
static NSString* VerifyViewCellId = @"VerifyViewCellid";
@interface MyClubVerifyViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong) UITableView *tableView;
/** 审核背景图*/
@property (nonatomic, strong) UIImageView *BgView;
/** 底部视图*/
@property (nonatomic, strong)UIView *footerview;
/** 头像*/
@property(nonatomic,strong) UIImageView *iconView;
/** 等级*/
@property(nonatomic,strong) UIImageView *levelView;
/** 名称*/
@property(nonatomic,strong) UILabel *nameLabel;
/** 性别信息*/
@property(nonatomic,strong) UILabel *sexLabel;
/** 位置信息*/
@property(nonatomic,strong) UILabel *memberLabel;
/** 申请信息*/
@property(nonatomic,strong) UILabel *questionLabel;



/****网络数据***/
/** 数据列表*/
@property (nonatomic, strong) NSMutableArray *dataList;
/** 申请人详细模型*/
@property (nonatomic, strong) MyClubNewJoinListModel *DetailModel;
/** 用户ID*/
@property (nonatomic, copy) NSString *userId;
/** 申请Id*/
@property (nonatomic, copy) NSString *applyId;
/** 差点*/
@property (nonatomic, copy) NSString *handicap;
/** 申请加入俱乐部原因*/
@property (nonatomic, copy) NSString *joinReason;
/** 杆数*/
@property (nonatomic, copy) NSString *toalBar;



@end

@implementation MyClubVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.name = @"申请审核";//需要赋值数据
    self.isAutoBack = NO;
    //初始化模型
    self.DetailModel = [[MyClubNewJoinListModel alloc] init];
    //初始化UI
    [self setUI];
    //请求数据
    [self requestData];
}

#pragma mark - 设置模型获取数据
-(void)setApplyUserModel:(MyClubNewJoinListModel *)applyUserModel{
    _applyUserModel = applyUserModel;
    self.userId = applyUserModel.ID.stringValue;
}

#pragma mark - 请求网络数据
-(void)requestData{
    
    
    [self.dataList removeAllObjects];
    
    self.userId = !self.userId ? @"未知" :self.userId;
    self.clubId = !self.clubId ? @"未知" :self.clubId;
    //申请人详细字段
    NSDictionary *Parameter = @{@"clubId":self.clubId,
                                @"userId":self.userId
                                };
    [ShareBusinessManager.userManager postMyClubNewApplyUserDetailWithParameters:Parameter success:^(id responObject) {
        self.DetailModel = responObject;
        [self.tableView reloadData];
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

-(void)setDetailModel:(MyClubNewJoinListModel *)DetailModel{
    
    _DetailModel = DetailModel;
    //设置数据
    //头像
    [self.iconView sd_setImageWithURL:FULLIMGURL(DetailModel.headUrl) placeholderImage:Placeholder_small];
    //用户昵称
    self.nameLabel.text = !DetailModel.nickname ? @"未知昵称" : DetailModel.nickname;
    //用户城市
    self.memberLabel.text = !DetailModel.address ? @"好友：0" : DetailModel.nickname;
    //用户性别 sex字段 性别：0-保密，1-男，2-女 @mock=0
    if ([DetailModel.sex isEqualToString:@"0"]) {
        self.sexLabel.text = @"性别：保密";
    }else if([DetailModel.sex isEqualToString:@"1"]){
        self.sexLabel.text = @"性别：男";
    }else if([DetailModel.sex isEqualToString:@"2"]){
        self.sexLabel.text = @"性别：女";
    }else{
        self.sexLabel.text = @"性别：保密";
    }
    //用户等级图标
    NSString *gradeName = [NSString stringWithFormat:@"%@",DetailModel.gradeName];
    UIImage *gradeImage;
    if ([gradeName isEqualToString:@"男爵"]) {
        gradeImage = [UIImage imageNamed:@"classify148"];
    }else if([gradeName isEqualToString:@"子爵"]){
        gradeImage = [UIImage imageNamed:@"classify149"];
    }else if([gradeName isEqualToString:@"伯爵"]){
        gradeImage = [UIImage imageNamed:@"classify150"];
    }else if([gradeName isEqualToString:@"侯爵"]){
        gradeImage = [UIImage imageNamed:@"classify151"];
    }else if([gradeName isEqualToString:@"公爵"]){
        gradeImage = [UIImage imageNamed:@"classify152"];
    }else{
        gradeImage = [UIImage imageNamed:@"classify148"];
    }
    self.levelView.image = gradeImage;

    //差点
    self.handicap = !DetailModel.handicap ? @"未知" : DetailModel.handicap;
    //杆数
    self.toalBar = !DetailModel.toalBar? @"未知" : DetailModel.toalBar;
    //申请理由
    self.joinReason = !DetailModel.joinReason? @"未填写申请理由" : DetailModel.joinReason;
    //描述
    self.questionLabel.text = [NSString stringWithFormat:@"用户%@申请加入俱乐部,是否同意?",self.nameLabel.text];
    
    //申请id
    self.applyId = !DetailModel.applyId.stringValue ? nil:  DetailModel.applyId.stringValue;

    [self.tableView reloadData];
}

#pragma mark - 初始化UI
-(void)setUI{
    [self.view addSubview:self.tableView];
    [self layoutBgViewSubviews];
    self.tableView.tableHeaderView = self.BgView;
    [self layoutFootView];
}


-(void)btnClick:(UIButton*)sender{
    
    NSDictionary *Parameter = @{@"applyId":self.applyId};
    
    if (sender.tag == 1) {
        //同意申请
        if (self.applyId == nil) {
            [SVProgressHUD showErrorWithStatus:@"操作失败"];
            return;
        }
       [ShareBusinessManager.userManager postMyClubAgreeApplyWithParameters:Parameter success:^(id responObject) {
           [SVProgressHUD showSuccessWithStatus:responObject];
           //更新申请人列表
           [SVProgressHUD showErrorWithStatus:@"操作成功"];
           [GOLFNotificationCenter postNotificationName:@"updateApplyList" object:nil userInfo:nil];
           [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }];
    }else if(sender.tag == 2){
        [ShareBusinessManager.userManager postMyClubRefuseWithParameters:Parameter success:^(id responObject) {
            [SVProgressHUD showSuccessWithStatus:responObject];
            //更新申请人列表
            [SVProgressHUD showErrorWithStatus:@"操作成功"];
            [GOLFNotificationCenter postNotificationName:@"updateApplyList" object:nil userInfo:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showSuccessWithStatus:errorMsg];
        }];
        
    }
}

-(void)layoutBgViewSubviews{
    
    
    [self.BgView addSubview:self.iconView];
    [self.BgView addSubview:self.levelView];
    [self.BgView addSubview:self.nameLabel];
    [self.BgView addSubview:self.memberLabel];
    [self.BgView addSubview:self.sexLabel];

    //布局
    self.iconView.sd_layout
    .topSpaceToView(self.BgView,13)
    .leftSpaceToView(self.BgView,15)
    .widthIs(43)
    .heightIs(43);
    self.iconView.sd_cornerRadius = @(21);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.BgView,13)
    .leftSpaceToView(self.iconView,10);
     [self.nameLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    self.levelView.sd_layout
    .topSpaceToView(self.BgView,14)
    .leftSpaceToView(self.nameLabel,8)
    .widthIs(38)
    .heightIs(10);
    
    self.sexLabel.sd_layout
    .topSpaceToView(self.nameLabel,14)
    .leftSpaceToView(self.iconView,10)
    .autoHeightRatio(0);
    [self.sexLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    
    self.memberLabel.sd_layout
    .topSpaceToView(self.nameLabel,14)
    .leftSpaceToView(self.sexLabel,8)
    .autoHeightRatio(0);
     [self.memberLabel setSingleLineAutoResizeWithMaxWidth:80];
    
}
-(void)layoutFootView{
    
    [self.view addSubview:self.footerview];
    
    //布局
    [self.footerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(60);
    }];
    
    
    UIButton *agreeBtn = [[UIButton alloc] init];
    [agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [agreeBtn setBackgroundColor:[UIColor colorWithHex:0x2aa344]];
    [agreeBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    agreeBtn.titleLabel.font = FONT(15);
    agreeBtn.tag = 1;
    [agreeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerview addSubview:agreeBtn];
    
    UIButton *disAgreeBtn = [[UIButton alloc] init];
    [disAgreeBtn setTitle:@"不同意" forState:UIControlStateNormal];
    [disAgreeBtn setBackgroundColor:WHITECOLOR];
    [disAgreeBtn setTitleColor:[UIColor colorWithHex:0x2aa344] forState:UIControlStateNormal];
    //边框宽度
    [disAgreeBtn.layer setBorderWidth:0.5];
    //边框颜色
    disAgreeBtn.layer.borderColor=[UIColor colorWithHex:0x2aa344].CGColor;
    disAgreeBtn.titleLabel.font = FONT(15);
    disAgreeBtn.tag = 2;
    [disAgreeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerview addSubview:disAgreeBtn];
    
    //布局
    [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.footerview).offset(10);
        make.left.equalTo(self.footerview).offset(18);
        make.bottom.equalTo(self.footerview).offset(-10);
        
        make.right.equalTo(disAgreeBtn.mas_left).offset(-15);
    }];
    
    [disAgreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(agreeBtn);
        make.left.equalTo(agreeBtn.mas_right).offset(15);
        make.right.equalTo(self.footerview).offset(-18);
        make.height.width.equalTo(agreeBtn);
    }];
    
    
    //文字描述
    [self.view addSubview:self.questionLabel];
    [self.questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.footerview);
        make.bottom.equalTo(self.footerview.mas_top).offset(-18);
    }];
}


#pragma mark - Table view data source



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:VerifyViewCellId];
    //消除选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //设置标题大小
    cell.textLabel.font = FONT(12);
    //设置标题颜色
    cell.textLabel.textColor = SHENTEXTCOLOR;
    //设置指示图
    //cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];
    //设置详请字体颜色
    cell.detailTextLabel.textColor = LIGHTTEXTCOLOR;
    //设置详情字体大小
    cell.detailTextLabel.font = FONT(12);
    
    //self.DetailModel = self.dataList[indexPath.row];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @" 杆数";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@杆",self.toalBar];
        }else{
            cell.textLabel.text = @" 差点";
            cell.detailTextLabel.text = self.handicap;
        }
    }else{
        cell.textLabel.text = @" 申请理由";
        cell.detailTextLabel.text = self.joinReason;
    }
    
    return cell;

}

#pragma mark - cell的点击事件
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark -懒加载控件
- (UIImageView *)BgView{
    if (!_BgView) {
        _BgView = [[UIImageView alloc] init];
        _BgView.backgroundColor = WHITECOLOR;
        _BgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 68);
    }
    return _BgView;
}
-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"classify4"];
    }
    return _iconView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"招财进兜兜";//需要赋值，先写死
        _nameLabel.font = FONT(13);
        [_nameLabel setTextColor:LIGHTTEXTCOLOR];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
-(UIImageView *)levelView{
    if (!_levelView) {
        _levelView = [[UIImageView alloc] init];
        _levelView.image = [UIImage imageNamed:@"classify148"];
    }
    return _levelView;
}

-(UILabel *)memberLabel{
    if (!_memberLabel) {
        _memberLabel = [[UILabel alloc] init];
        _memberLabel.text = @"好友：00";//需要赋值，先写死
        _memberLabel.font = FONT(12);
        [_memberLabel setTextColor:LIGHTTEXTCOLOR];
        _memberLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _memberLabel;
}

-(UILabel *)sexLabel{
    if (!_sexLabel) {
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.text = @"性别：女";//需要赋值，先写死
        _sexLabel.font = FONT(12);
        [_sexLabel setTextColor:LIGHTTEXTCOLOR];
        _sexLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _sexLabel;
}

-(UILabel *)questionLabel{
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc] init];
        //需要传入值
        _questionLabel.text = [NSString stringWithFormat:@"用户%@申请加入俱乐部,是否同意?",@"未知信息"];
        _questionLabel.font = FONT(13);
        [_questionLabel setTextColor:SHENTEXTCOLOR];
    }
    return _questionLabel;
}

-(UIView *)footerview{
    if (!_footerview) {
        _footerview = [[UIView alloc] init];
        _footerview.backgroundColor = WHITECOLOR;
    }
    return _footerview;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.separatorColor = GRAYCOLOR;;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.frame = CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:VerifyViewCellId];
    }
    return _tableView;
}

- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
        
    }
    return _dataList;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
