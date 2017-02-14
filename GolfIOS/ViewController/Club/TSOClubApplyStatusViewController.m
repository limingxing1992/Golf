//
//  TSOClubApplyStatusViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/10.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOClubApplyStatusViewController.h"
#import "TSORecommendClubCell.h"
#import "ClubIntroModel.h"
#import "ClubSysRecommendModel.h"
#import "TSOClubApplyView.h"
#import "SeverStatus.h"

@interface TSOClubApplyStatusViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
TSOClubApplyViewDelegate
>

/**顶部状态视图*/
@property (nonatomic, strong) UIView *topView;
/**messageLb*/
@property (nonatomic, strong) UILabel *messageLb;
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;

/**maskVIew*/
@property (nonatomic, strong) UIView *maskView;
/**clubId*/
@property (nonatomic, strong) NSString *clubId;

@end

static NSString *const kTSORecommendClubCell = @"kTSORecommendClubCell";

@implementation TSOClubApplyStatusViewController

- (instancetype)initIsScuess:(BOOL)isScuess
{
    self = [super init];
    if (self) {
        self.messageLb = [[UILabel alloc] init];
        if (isScuess) {
            
            self.messageLb.text = @"恭喜您，成功加入俱乐部";
        }else{
            self.messageLb.text = @"您的申请已发送至俱乐部耐心等待管理员审核";
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self requestsysRecommendedClubList];
}



- (void)setupNav{
    [super setupNav];
    self.navTitle = @"";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.size = CGSizeMake(40, 40);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"classify88"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [leftBtn sizeToFit];
    [leftBtn addTarget:self action:@selector(backToFront) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backToFront{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 请求数据

- (void)requestsysRecommendedClubList{
    
    [ShareBusinessManager.clubManager getSysRecommendedClubListWithParameters:nil success:^(id responObject) {
        ClubSysRecommendModel *model = (ClubSysRecommendModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            self.dataList = [model.data mutableCopy];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

//申请加入俱乐部
- (void)applyAddClub{
    
    //
    TSOClubApplyView *applyView = [[TSOClubApplyView alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH * 0.9, 200)];
    applyView.delegate = self;
    applyView.center = CGPointMake(self.view.center.x, SCREEN_HEIGHT * 0.3);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.maskView = [[UIView alloc] initWithFrame:window.bounds];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMask)];
    [self.maskView addGestureRecognizer:tap];
    if ([UIDevice currentDevice].systemVersion.floatValue > 9.0) {
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithFrame:applyView.bounds];
        [applyView addSubview:effectView];
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        effectView.effect = blurEffect;
        
        [window addSubview:self.maskView];
        [self.maskView addSubview:applyView];
        
        [UIView animateWithDuration:0.25 animations:^{
            effectView.effect = nil;
        } completion:^(BOOL finished) {
            [effectView removeFromSuperview];
        }];
    }else{
        [window addSubview:self.maskView];
        [self.maskView addSubview:applyView];
    }
    
}

- (void)dismissMask{
    
    [self.maskView removeFromSuperview];
    
}

#pragma mark - TSOClubApplyViewDelegate

- (void)clubApplyViewCancelButtonDidClick{
    [self dismissMask];
}

- (void)clubApplyView:(TSOClubApplyView *)view applyButtonDidClick:(NSString *)reasonStr{
    NSLog(@"%@",reasonStr);
    [self dismissMask];
    //请求加入
    [SVProgressHUD showWithStatus:@"正在申请"];
    //请求成功跳转到成功页面
    NSDictionary *parameter = @{@"clubId":self.clubId,
                                @"joinReason":reasonStr};
    [ShareBusinessManager.clubManager getJoinClubWithParameters:parameter success:^(id responObject) {
        SeverStatus *model = (SeverStatus *)responObject;
        if (model.errorCode.integerValue == 1) {
            [SVProgressHUD showSuccessWithStatus:@"请求发送成功"];
            [self requestsysRecommendedClubList];
        }else{
            
            //测试  跳转应该放在请求成功的情况下  现在请求成功的状态不合理暂时放在这里
            [SVProgressHUD dismiss];
          
            
        }
        
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
    
    
    
    //延时模拟请求成功
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        
    });
}


#pragma mark - UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    label.font = FONT(14);
    label.textColor = BLACKCOLOR;
    label.text = @"   推荐的俱乐部";
    label.backgroundColor = WHITECOLOR;
    return label;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ClubSysRecommend *model = self.dataList[indexPath.row];
    TSORecommendClubCell *cell = [tableView dequeueReusableCellWithIdentifier:kTSORecommendClubCell];
    weak(self);
    [cell setHandler:^{
        weakSelf.clubId = model.clubId.stringValue;
        [weakSelf applyAddClub];
    }];
    
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
#pragma mark - Setter&Getter

- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 179);
        _topView.backgroundColor = WHITECOLOR;
        UIImageView *rightView = [[UIImageView alloc] initWithImage:IMAGE(@"classify56")];
        [_topView addSubview:rightView];
        rightView.sd_layout
        .topSpaceToView(_topView, 35)
        .centerXEqualToView(_topView)
        .widthIs(36)
        .heightIs(36);
        
        _messageLb.font = FONT(18);
        _messageLb.textColor = GLOBALCOLOR;
    
        [_topView addSubview:_messageLb];
        _messageLb.frame = CGRectMake(0, 0, 203, 50);
        _messageLb.center = CGPointMake(_topView.center.x, 110);
        _messageLb.textAlignment = NSTextAlignmentCenter;
        _messageLb.numberOfLines = 2;
        
        UILabel *tipLb = [[UILabel alloc] init];
        tipLb.font = FONT(14);
        tipLb.textColor = BLACKCOLOR;
        tipLb.text = @"以下这些也许您会感兴趣";
        [_topView addSubview:tipLb];
        tipLb.sd_layout
        .topSpaceToView(_messageLb, 15)
        .centerXEqualToView(_topView)
        .autoHeightRatio(0);
        [tipLb setSingleLineAutoResizeWithMaxWidth:200];
    
    }
    return _topView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 244,SCREEN_WIDTH ,SCREEN_HEIGHT - 243) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TSORecommendClubCell class] forCellReuseIdentifier:kTSORecommendClubCell];
    }
    return _tableView;
}

- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

@end
