//
//  TSORecordViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/14.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSORecordViewController.h"
#import "TSORecoreView.h"
#import "TSOUserRecordView.h"
#import "UIImage+Image.h"
#import "ScoreInfo.h"
#import "ScoreList.h"
#import "SeverStatus.h"
#import "NSDate+YB_Extension.h"

@interface TSORecordViewController ()

/**返回按钮*/
@property (nonatomic, strong) UIButton *backBtn;
/**确认成绩*/
@property (nonatomic, strong) UIButton *makeSureBtn;
/**竖线分割线*/
@property (nonatomic, strong) UIView *lineView1;
/**横线分割线*/
@property (nonatomic, strong) UIView *lineView2;
/**横线分割线*/
@property (nonatomic, strong) UIView *lineView3;
/**横线分割线*/
@property (nonatomic, strong) UIView *lineView4;
/**数据数组*/
@property (nonatomic, strong) NSMutableArray *scoreArr;
/**洞序 标题view*/
@property (nonatomic, strong) TSORecoreView *titleView;
/**标准杆 标题View*/
@property (nonatomic, strong) TSORecoreView *standardScoreView;
/**用户分数View*/
@property (nonatomic, strong) UIView *userScoreView;
/**球场名称*/
@property (nonatomic, strong) UILabel *nameLabel;
/**比赛时间*/
@property (nonatomic, strong) UILabel *timeLabel;
/**洞序*/
@property (nonatomic, strong) UILabel *holeLabel;
/**标准杆*/
@property (nonatomic, strong) UILabel *standardLabel;
///**老鹰球*/
//@property (nonatomic, strong) UIButton *laoyingBtn;
///**小鸟球*/
//@property (nonatomic, strong) UIButton *xiaoniaoBtn;
///**标准杆*/
//@property (nonatomic, strong) UIButton *biaozhunBtn;
///**柏忌*/
//@property (nonatomic, strong) UIButton *baijiBtn;
///**双柏忌*/
//@property (nonatomic, strong) UIButton *shuangbaijiBtn;


/**数据*/
//@property (nonatomic, strong) NSMutableArray *dataArray;

@end



//#define laoyingColor [UIColor colorWithRed:225/255.0 green:169/255.0 blue:88/255.0 alpha:1]
//#define xiaoniaoColor [UIColor colorWithRed:228/255.0 green:98/255.0 blue:114/255.0 alpha:1]
//#define biaozhunColor [UIColor colorWithRed:46/255.0 green:179/255.0 blue:168/255.0 alpha:1]
//#define baijiColor [UIColor colorWithRed:80/255.0 green:143/255.0 blue:220/255.0 alpha:1]
//#define shuangbaiColor [UIColor colorWithRed:80/255.0 green:95/255.0 blue:236/255.0 alpha:1]
@implementation TSORecordViewController

//MARK: - lifeCycle

- (instancetype)initReadOnlyView:(BOOL)isReadOnly{
    if (self = [super init]) {
        if (isReadOnly) {
            self.makeSureBtn.hidden = YES;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
//    [self refreshData];
}

- (void)viewWillAppear:(BOOL)animated{
    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}
- (void)setupUI{
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.makeSureBtn];
    [self.view addSubview:self.lineView1];
    [self.view addSubview:self.lineView2];
    [self.view addSubview:self.lineView3];
    [self.view addSubview:self.lineView4];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.holeLabel];
    [self.view addSubview:self.standardLabel];
//    [self.view addSubview:self.laoyingBtn];
    
    self.backBtn.sd_layout
    .leftSpaceToView(self.view, 15)
    .bottomSpaceToView(self.view, 15)
    .widthIs(40)
    .heightIs(40);
    
    self.makeSureBtn.sd_layout
    .rightSpaceToView(self.view, 15)
    .bottomSpaceToView(self.view, 15)
    .widthIs(60)
    .heightIs(40);
    
    self.lineView1.sd_layout
    .leftSpaceToView(self.view, SCREEN_HEIGHT * 0.1)
    .topSpaceToView(self.view,20)
    .widthIs(0.5)
    .heightIs(SCREEN_WIDTH * 0.324 - 20);
    
    self.lineView2.sd_layout
    .leftSpaceToView(self.lineView1, 0)
    .topSpaceToView(self.view, SCREEN_WIDTH * 0.2)
    .heightIs(0.5)
    .rightSpaceToView(self.view, 0);
    
    self.lineView3.sd_layout
    .topSpaceToView(self.lineView2, SCREEN_WIDTH * 0.06)
    .heightIs(0.5)
    .leftSpaceToView(self.lineView1, 0)
    .rightSpaceToView(self.view, 0);
    
    self.lineView4.sd_layout
    .topSpaceToView(self.lineView1, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(0.5);
    
    [self.view addSubview:self.titleView];
    self.titleView.sd_layout
    .leftSpaceToView(self.lineView1, 30)
    .topSpaceToView(self.lineView2, 0)
    .widthIs(SCREEN_HEIGHT * 0.9)
    .heightIs(SCREEN_WIDTH * 0.06);
    
    [self.view addSubview:self.standardScoreView];
    self.standardScoreView.sd_layout
    .leftSpaceToView(self.lineView1, 30)
    .topSpaceToView(self.lineView3, 0)
    .widthIs(SCREEN_HEIGHT * 0.9)
    .heightIs(SCREEN_WIDTH * 0.06);
    
    [self.view addSubview:self.userScoreView];
    self.userScoreView.sd_layout
    .topSpaceToView(self.lineView4, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(SCREEN_WIDTH * 0.1 * 1);
    
    self.timeLabel.sd_layout
    .leftSpaceToView(self.lineView1, 10)
    .bottomSpaceToView(self.lineView2, 10)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.lineView1, 10)
    .bottomSpaceToView(self.timeLabel, 10)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:300];
    [self.nameLabel setMaxNumberOfLinesToShow:1];
    
    self.standardLabel.sd_layout
    .leftSpaceToView(self.view, 12)
    .centerYEqualToView(self.standardScoreView)
    .autoHeightRatio(0);
    [self.standardLabel setSingleLineAutoResizeWithMaxWidth:50];
    
    self.holeLabel.sd_layout
    .leftSpaceToView(self.view, 12)
    .centerYEqualToView(self.titleView)
    .autoHeightRatio(0);
    [self.holeLabel setSingleLineAutoResizeWithMaxWidth:30];
    
    UIView *tipContainerView = [[UIView alloc] init];
    [self.view addSubview:tipContainerView];
    
//    [tipContainerView addSubview:self.laoyingBtn];
//    self.laoyingBtn.sd_layout.heightIs(20);
//    
//    [tipContainerView addSubview:self.xiaoniaoBtn];
//    self.xiaoniaoBtn.sd_layout.heightIs(20);
//    
//    [tipContainerView addSubview:self.biaozhunBtn];
//    self.biaozhunBtn.sd_layout.heightIs(20);
//    
//    [tipContainerView addSubview:self.baijiBtn];
//    self.baijiBtn.sd_layout.heightIs(20);
//    
//    [tipContainerView addSubview:self.shuangbaijiBtn];
//    self.shuangbaijiBtn.sd_layout.heightIs(20);
    
//    [tipContainerView setupAutoWidthFlowItems:@[self.laoyingBtn,self.xiaoniaoBtn,self.biaozhunBtn,self.baijiBtn,self.shuangbaijiBtn] withPerRowItemsCount:5 verticalMargin:0 horizontalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
//    
//    
//    
//    tipContainerView.sd_layout
//    .leftSpaceToView(self.nameLabel, 10)
//    .bottomEqualToView(self.nameLabel)
//    .rightSpaceToView(self.view, 15)
//    .heightIs(20);

    
//    self.nameLabel.text = @"Coto de Caza Golf & Racquet Club";
//    self.timeLabel.text = @"2099年13月33日 13：22";
}


//MARK: - 设置模型数据
- (void)setModel:(ScoreInfo *)model{
    _model = model;
    NSMutableArray *standardArray = [[NSMutableArray alloc] init];
    ScoreList *list = _model.data.scoreList[0];
    for (Hole *hole in list.holeScore) {
        [standardArray addObject:hole.par];
    }
    
    self.nameLabel.text = _model.data.groupInfo.ballPlaceName;
    self.timeLabel.text = [NSDate timeLineStringWithString:_model.data.groupInfo.createTime];

  
    self.standardScoreView.scoreArray = [self formateScore:standardArray];

    [self setupUserView];
}

- (void)setupUserView{


    self.userScoreView.mj_h = SCREEN_WIDTH * 0.1 * _model.data.scoreList.count;
    
    
    int i = 0;
    for (ScoreList *list in _model.data.scoreList) {
        //分数视图
        TSOUserRecordView *userView = [[TSOUserRecordView alloc] init];
        NSMutableArray *scoreArray = [[NSMutableArray alloc] init];
        NSMutableArray *pushArray = [[NSMutableArray alloc] init];
        for (Hole *hole in list.holeScore) {
            [scoreArray addObject:hole.actualBar];
            [pushArray addObject:hole.pushBar];
        }
        //此处没有传入标准杆数据 所以显示的数字是没有背景颜色标注的，如果希望有背景颜色使用下面这个属性
//        userView.standScoreArr
        userView.userScoreArr = [self formateScore:scoreArray];
        userView.pushScoreArr = [self formateScore:pushArray];
        userView.frame = CGRectMake(SCREEN_HEIGHT * 0.1 + 30, SCREEN_WIDTH * 0.1 * i, SCREEN_HEIGHT * 0.9 - 30,SCREEN_WIDTH * 0.1);
        [self.userScoreView addSubview:userView];
        //选手名称
        UILabel *playerNameLb = [[UILabel alloc] init];
        playerNameLb.font = FONT(12);
        playerNameLb.textColor = SHENTEXTCOLOR;
        playerNameLb.numberOfLines = 1;
        [self.userScoreView addSubview:playerNameLb];
        playerNameLb.sd_layout
        .leftSpaceToView(self.userScoreView, 12)
        .centerYEqualToView(userView)
        .autoHeightRatio(0);
        [playerNameLb setSingleLineAutoResizeWithMaxWidth:50];

        playerNameLb.text = list.nickName;

        //分割线
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = LIGHTTEXTCOLOR;

        [self.userScoreView addSubview:lineView];
        lineView.frame = CGRectMake(0, SCREEN_WIDTH * 0.1 * (i+1), SCREEN_HEIGHT, 0.5);
        
        i ++;
    }

}



- (BOOL)shouldAutorotate
{
    //是否支持转屏
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //支持哪些转屏方向
    return UIInterfaceOrientationMaskLandscape;
}

//进入界面直接旋转的方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}
// 是否隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Founction

- (NSComparisonResult)compare: (NSDictionary *)otherDictionary
{
    NSDictionary *tempDictionary = (NSDictionary *)self;
    
    NSNumber *number1 = [[tempDictionary allKeys] objectAtIndex:0];
    NSNumber *number2 = [[otherDictionary allKeys] objectAtIndex:0];
    
    NSComparisonResult result = [number1 compare:number2];
    
    return result == NSOrderedDescending; // 升序
    //    return result == NSOrderedAscending;  // 降序
}


- (NSMutableArray *)formateScore:(NSMutableArray*)scoreArray{
    //对数据进行处理
    NSMutableArray *scoreData = [[NSMutableArray alloc] init];
    //前9个数据求和上半场分数
    int scoreOUT = 0 ;
    //后9个数求和下半场分数
    int scoreIN = 0;
    //所有数据求和得全场分数
    int scoreTOT = 0;
    for (int i = 0; i<scoreArray.count; i++ ) {
        
        NSNumber *scoreNmu = scoreArray[i];
        //            NSNumber *standardNum = [dict objectForKey:@"standardNum"];
        [scoreData addObject:scoreNmu];
        if (i< 9) {
            scoreOUT = scoreOUT + scoreNmu.intValue;
        }else{
            scoreIN = scoreIN + scoreNmu.intValue;
        }
        scoreTOT = scoreOUT + scoreIN;
        
        if (i == 8) {
            [scoreData addObject:[NSNumber numberWithInt:scoreOUT]];
        }
        if (i == 17) {
            [scoreData addObject:[NSNumber numberWithInt:scoreIN]];
            [scoreData addObject:[NSNumber numberWithInt:scoreTOT]];
        }
        
    }
    
    return scoreData;
}

#pragma mark - Action

- (void)back{
    

    [self dismissViewControllerAnimated:YES completion:nil];

    
}
//确认成绩
- (void)makeSure{
    [SVProgressHUD showWithStatus:@"确认成绩中"];
    [ShareBusinessManager.scoreManager confirmScoreWithParameters:@{@"groupId":_model.data.groupId} success:^(id responObject) {
        SeverStatus *model = (SeverStatus *)responObject;
        if (model.errorCode.integerValue == 1) {
            [SVProgressHUD showSuccessWithStatus:@"确认成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"poptoRoot" object:nil];
            });
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showWithStatus:errorMsg];
    }];
    
    
    
}

#pragma mark - Setter&Getter

- (UIButton *)makeSureBtn{
    if (_makeSureBtn == nil) {
        _makeSureBtn = [[UIButton alloc] init];
        [_makeSureBtn setTitle:@"确认成绩" forState:UIControlStateNormal];
        _makeSureBtn.titleLabel.font = FONT(12);
        [_makeSureBtn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
        [_makeSureBtn addTarget:self action:@selector(makeSure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _makeSureBtn;
}

- (UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        _backBtn.titleLabel.font = FONT(12);
        [_backBtn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIView *)lineView1{
    if (_lineView1 == nil) {
        _lineView1 = [[UIView alloc] init];
        _lineView1.backgroundColor = LIGHTTEXTCOLOR;
        
    }
    return _lineView1;
}

- (UIView *)lineView2{
    if (_lineView2 == nil) {
        _lineView2 = [[UIView alloc] init];
        _lineView2.backgroundColor = LIGHTTEXTCOLOR;
       
    }
    return _lineView2;
}

- (UIView *)lineView3{
    if (_lineView3 == nil) {
        _lineView3 = [[UIView alloc] init];
        _lineView3.backgroundColor = LIGHTTEXTCOLOR;
        
    }
    return _lineView3;
}

- (UIView *)lineView4{
    if (_lineView4 == nil) {
        _lineView4 = [[UIView alloc] init];
        _lineView4.backgroundColor = LIGHTTEXTCOLOR;
       
    }
    return _lineView4;
}

- (TSORecoreView *)titleView{
    if (_titleView == nil) {
        _titleView = [[TSORecoreView alloc] initWithColor:BLACKCOLOR];
        _titleView.scoreArray = [@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"OUT",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"IN",@"TOT"] mutableCopy];
    }
    return _titleView;
}

- (TSORecoreView *)standardScoreView{
    if (_standardScoreView == nil) {
        _standardScoreView = [[TSORecoreView alloc] initWithColor:LIGHTTEXTCOLOR];
    }
    return _standardScoreView;
}

- (UIView *)userScoreView{
    if (_userScoreView == nil) {
        _userScoreView = [[UIView alloc] init];
        
    }
    return _userScoreView;
}


- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT(15);
        _nameLabel.textColor = BLACKCOLOR;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT(12);
        _timeLabel.textColor = LIGHTTEXTCOLOR;
    }
    return _timeLabel;
}

- (UILabel *)holeLabel{
    if (_holeLabel == nil) {
        _holeLabel = [[UILabel alloc] init];
        _holeLabel.font = FONT(10);
        _holeLabel.textColor = LIGHTTEXTCOLOR;
        _holeLabel.text = @"洞序";
    }
    return _holeLabel;
}

- (UILabel *)standardLabel{
    if (_standardLabel == nil) {
        _standardLabel = [[UILabel alloc] init];
        _standardLabel.font = FONT(10);
        _standardLabel.textColor = LIGHTTEXTCOLOR;
        _standardLabel.text = @"标准杆";
    }
    return _standardLabel;
}

//- (UIButton *)laoyingBtn{
//    if (_laoyingBtn == nil) {
//        _laoyingBtn = [[UIButton alloc] init];
//        [_laoyingBtn setTitle:@" 老鹰" forState:UIControlStateNormal];
//        [_laoyingBtn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
//        [_laoyingBtn setImage:[UIImage imageWithColor:laoyingColor andRadius:6] forState:UIControlStateNormal];
//        _laoyingBtn.titleLabel.font = FONT(12);
//    }
//    return _laoyingBtn;
//}
//
//- (UIButton *)xiaoniaoBtn{
//    if (_xiaoniaoBtn == nil) {
//        _xiaoniaoBtn = [[UIButton alloc] init];
//        [_xiaoniaoBtn setTitle:@" 小鸟" forState:UIControlStateNormal];
//        [_xiaoniaoBtn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
//        [_xiaoniaoBtn setImage:[UIImage imageWithColor:xiaoniaoColor andRadius:6] forState:UIControlStateNormal];
//        _xiaoniaoBtn.titleLabel.font = FONT(12);
//    }
//    return _xiaoniaoBtn;
//}
//
//- (UIButton *)biaozhunBtn{
//    if (_biaozhunBtn == nil) {
//        _biaozhunBtn = [[UIButton alloc] init];
//        [_biaozhunBtn setTitle:@" 标准" forState:UIControlStateNormal];
//        [_biaozhunBtn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
//        [_biaozhunBtn setImage:[UIImage imageWithColor:biaozhunColor andRadius:6] forState:UIControlStateNormal];
//        _biaozhunBtn.titleLabel.font = FONT(12);
//    }
//    return _biaozhunBtn;
//}
//
//- (UIButton *)baijiBtn{
//    if (_baijiBtn == nil) {
//        _baijiBtn = [[UIButton alloc] init];
//        [_baijiBtn setTitle:@" 柏忌" forState:UIControlStateNormal];
//        [_baijiBtn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
//        [_baijiBtn setImage:[UIImage imageWithColor:baijiColor andRadius:6] forState:UIControlStateNormal];
//        _baijiBtn.titleLabel.font = FONT(12);
//    }
//    return _baijiBtn;
//}
//
//- (UIButton *)shuangbaijiBtn{
//    if (_shuangbaijiBtn == nil) {
//        _shuangbaijiBtn = [[UIButton alloc] init];
//        [_shuangbaijiBtn setTitle:@" 双柏忌" forState:UIControlStateNormal];
//        [_shuangbaijiBtn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
//        [_shuangbaijiBtn setImage:[UIImage imageWithColor:shuangbaiColor andRadius:6] forState:UIControlStateNormal];
//        _shuangbaijiBtn.titleLabel.font = FONT(12);
//    }
//    return _shuangbaijiBtn;
//}


@end
