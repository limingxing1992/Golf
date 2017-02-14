//
//  TSOScoringViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/11.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOScoringViewController.h"
#import "TSOSingleScoringCell.h"
#import "TSORecordViewController.h"
#import "FBShimmering.h"
#import "FBShimmeringView.h"
#import "TSOUSelectHoleView.h"
#import "StandardHoleListModel.h"
#import "ScoreInfo.h"
#import "ScoreUser.h"
#import "ScoreList.h"
#import "TSOAddPlayerButton.h"

@interface TSOScoringViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
TSOSingleScoringCellDelegate,
TSOUSelectHoleViewDelegate
>

{
    NSMutableString *_actualBarListStr;
    NSMutableString *_joingUserIdListStr;
    NSMutableString *_pushBarListStr;
    NSMutableString *_standardBarListStr;
}


/**顶部总杆数*/
@property (nonatomic, strong) UILabel *totalScoreLb;
/**总推杆数*/
@property (nonatomic, strong) UILabel *totalPushScoreLb;
/**总杆*/
@property (nonatomic, strong) UILabel *zongLb;

/**scrollView*/
@property (nonatomic, strong) UICollectionView *mainView;

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

/**底部提示文字*/
@property (nonatomic, strong) UILabel *tipLabel;
/**FBShimmeringView*/
@property (nonatomic, strong) FBShimmeringView *tipView;

/**选择球洞视图*/
@property (nonatomic, strong) TSOUSelectHoleView *selectHoleView;
/**蒙版*/
@property (nonatomic, strong) UIView *maskView;
/**导航栏选择球洞按钮*/
@property (nonatomic, strong) UIButton *titleBtn;
/**计分信息 包括参加计分的用户*/
@property (nonatomic, strong) ScoreInfo *scoreInfo;
/**玩家容器视图*/
@property (nonatomic, strong) UIView *playersView;

/**当前选中的玩家*/
@property (nonatomic, strong) TSOAddPlayerButton *selBtn;

/**当前显示的洞*/
@property (nonatomic, assign) NSInteger currentHole;

@end

#define kItemHeight SCREEN_HEIGHT - 114 - 45 - 120
static NSString *const kTSOSingleScoringCell = @"kTSOSingleScoringCell";



@implementation TSOScoringViewController

#pragma mark - LifeCycle

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}

- (instancetype)initWithScoreInfo:(ScoreInfo *)scoreInfo{
    if (self = [super init]) {
        self.currentHole = 0;
        self.scoreInfo = scoreInfo;
        [self setupUI];
        [self setupMainView];
        [self refreshTotalScore];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GOLFNotificationCenter addObserver:self selector:@selector(poptoRoot) name:@"poptoRoot" object:nil];
}

- (void)setupNav{
    [super setupNav];
    
    self.titleBtn = [[UIButton alloc] init];
    self.titleBtn.size = CGSizeMake(50, 44);
    [_titleBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
    [_titleBtn setTitle:[NSString stringWithFormat:@"%@1",self.scoreInfo.data.groupInfo.beforeField]forState:UIControlStateNormal];
    [_titleBtn addTarget:self action:@selector(titleBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *recordBtnItem = [UIBarButtonItem itemWithImage:IMAGE(@"yb_cart") selImage:nil targer:self action:@selector(toRecordViewController)];
    self.navigationItem.rightBarButtonItem = recordBtnItem;
     [self.navigationItem setTitleView:_titleBtn];
}

- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    _flowLayout = flowLayout;
    
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 114 + 120, SCREEN_WIDTH, kItemHeight) collectionViewLayout:flowLayout];
    mainView.backgroundColor = WHITECOLOR;
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[TSOSingleScoringCell class] forCellWithReuseIdentifier:kTSOSingleScoringCell];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.scrollsToTop = NO;
    

    [self.view addSubview:mainView];
    _mainView = mainView;
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.totalScoreLb];
    [self.view addSubview:self.playersView];
    [self.view addSubview:self.zongLb];
    [self.totalScoreLb addSubview:self.totalPushScoreLb];

    self.totalScoreLb.sd_layout
    .topSpaceToView(self.view, 74)
    .leftSpaceToView(self.view, 15)
    .heightIs(40)
    .widthIs(40);
    
    self.totalPushScoreLb.sd_layout
    .topSpaceToView(self.totalScoreLb, -5)
    .rightSpaceToView(self.totalScoreLb, -5)
    .heightIs(20)
    .widthIs(20);
    
    self.zongLb.sd_layout
    .topSpaceToView(self.totalScoreLb, 0)
    .centerXEqualToView(self.totalScoreLb)
    .autoHeightRatio(0);
    [self.zongLb setSingleLineAutoResizeWithMaxWidth:50];
    

    [self refreshTotalScore];
    
    [self.view addSubview:self.tipView];
    self.tipView.contentView = self.tipLabel;
    self.tipView.sd_layout
    .bottomSpaceToView(self.view, 15)
    .centerXEqualToView(self.view)
    .heightIs(20)
    .widthIs(104);
    
    NSArray *userArr = self.scoreInfo.data.scoreList;
    NSInteger i = 0;
    NSMutableArray *viewArr = [[NSMutableArray alloc] init];
    CGFloat btnw = 50;
    for (ScoreList *userScoreList in userArr) {
        
        TSOAddPlayerButton *playerBtn = [[TSOAddPlayerButton alloc] init];
        
        NSURL *iconUrl = [YB_Tools fullIconUrl:userScoreList.headUrl];
        [playerBtn sd_setImageWithURL:iconUrl forState:UIControlStateNormal placeholderImage:Placeholder_small];

        playerBtn.tag = userScoreList.userId.integerValue;
        [playerBtn setTitle:userScoreList.nickName forState:UIControlStateNormal];
        [playerBtn setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        [playerBtn setTitleColor:GLOBALCOLOR forState:UIControlStateSelected];
        playerBtn.frame = CGRectMake(i * (btnw + 15), 0, btnw, 80);
        [self.playersView addSubview:playerBtn];
        
        [playerBtn addTarget:self action:@selector(playerBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            playerBtn.selected = YES;
            self.selBtn = playerBtn;
        }
        [viewArr addObject:playerBtn];
        
        i ++;
    }
    
    _playersView.sd_layout
    .topSpaceToView(self.view, 120)
    .centerXEqualToView(self.view)
    .widthIs(userArr.count * btnw +(userArr.count - 1) * 15)
    .heightIs(100);
    
}

- (void)back{
    
    [self addScoreRecordWithHoleNum:self.currentHole];
    
    [super back];
}


//进入界面直接旋转的方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - function
//刷新顶部标题控件
- (void)refreshWithHole:(NSNumber *)hole{
//    [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:hole.integerValue inSection:10] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    [self.selectHoleView clickBtnAtIndex:hole.integerValue];
    
    if (hole.integerValue <=9 ) {
        [self.titleBtn setTitle:[NSString stringWithFormat:@"%@%zd",_scoreInfo.data.groupInfo.beforeField,hole.integerValue+1] forState:UIControlStateNormal];
    }else{
        [self.titleBtn setTitle:[NSString stringWithFormat:@"%@%zd",_scoreInfo.data.groupInfo.afterField,hole.integerValue+1] forState:UIControlStateNormal];
    }
    
    
}

//刷新总分
- (void)refreshTotalScore{
    NSInteger totalScore = 0;
    NSInteger totalPushScore = 0;
    ScoreList *scorelistModel;
    for (ScoreList *scorelist in self.scoreInfo.data.scoreList) {
        if (self.selBtn.tag == scorelist.userId.integerValue) {
            scorelistModel = scorelist;
        }
    }
    for (Hole *hole in scorelistModel.holeScore) {
        totalScore = totalScore + hole.actualBar.integerValue;
        totalPushScore = totalPushScore + hole.pushBar.integerValue;
    }
    
    self.totalScoreLb.text = [NSString stringWithFormat:@"%zd" ,totalScore];
    self.totalPushScoreLb.text = [NSString stringWithFormat:@"%zd",totalPushScore];
}

//MARK: - function
- (void)setupDataWithHole:(NSInteger)holeNum{
    
    NSMutableArray *actualBarListArr = [[NSMutableArray alloc] init];
    NSMutableArray *joingUserIdListArr = [[NSMutableArray alloc] init];
    NSMutableArray *pushBarListArr = [[NSMutableArray alloc] init];
    NSMutableArray *standardBarListArr = [[NSMutableArray alloc] init];
    
    //获取比赛球洞初始计分信息
    ScoreInfoData *infoData = self.scoreInfo.data;
    NSArray *scoreListArr = infoData.scoreList;
    [scoreListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ScoreList *temp = (ScoreList *)obj;
        NSArray *tempHoles = temp.holeScore;
        Hole *hole = tempHoles[holeNum];
        [joingUserIdListArr addObject:temp.userId.stringValue];
        [actualBarListArr addObject:hole.actualBar.stringValue];
        [standardBarListArr addObject:hole.standardBar.stringValue];
        [pushBarListArr addObject:hole.pushBar.stringValue];
    }];
    
    _actualBarListStr = [[actualBarListArr componentsJoinedByString:@","] mutableCopy];
    _joingUserIdListStr = [[joingUserIdListArr componentsJoinedByString:@","] mutableCopy];
    _pushBarListStr = [[pushBarListArr componentsJoinedByString:@","] mutableCopy];
    _standardBarListStr = [[standardBarListArr componentsJoinedByString:@","] mutableCopy];
    
}

//MARK: - Action

- (void)playerBtnDidClick:(TSOAddPlayerButton *)button{

    self.selBtn.selected = NO;
    self.selBtn = button;
    self.selBtn.selected = YES;

    [self.mainView reloadData];
    [self refreshTotalScore];
}

- (void)titleBtnDidClick:(UIButton *)button{
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.maskView = [[UIView alloc] initWithFrame:window.bounds];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMask)];
    [self.maskView addGestureRecognizer:tap];
//    if ([UIDevice currentDevice].systemVersion.floatValue > 9.0) {
//        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithFrame:self.selectHoleView.bounds];
//        [self.selectHoleView addSubview:effectView];
//        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//        effectView.effect = blurEffect;
//        
//        [window addSubview:self.maskView];
//        [self.maskView addSubview:self.selectHoleView];
//        
//        [UIView animateWithDuration:0.25 animations:^{
//            effectView.effect = nil;
//        } completion:^(BOOL finished) {
//            [effectView removeFromSuperview];
//        }];
//    }else{
//        [window addSubview:self.maskView];
//        [self.maskView addSubview:self.selectHoleView];
//    }
    [window addSubview:self.maskView];
    [self.maskView addSubview:self.selectHoleView];
  
}

- (void)dismissMask{
    
    [self.maskView removeFromSuperview];
    
}

- (void)toRecordViewController{
    
    
    [self addScoreRecordWithHoleNum:_currentHole];
    TSORecordViewController *recordVC = [[TSORecordViewController alloc] init];

    recordVC.model = self.scoreInfo;
//    recordVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:recordVC animated:YES];
    
    [self presentViewController:recordVC animated:YES completion:nil];
}

- (void)poptoRoot{
    
    [self back];
}

//MARK: - 每个洞计分

- (void)addScoreRecordWithHoleNum:(NSInteger)holeNum{
    
    [self setupDataWithHole:holeNum];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:_actualBarListStr forKey:@"actualBarList"];
    [dict setObject:self.scoreInfo.data.groupId forKey:@"groupId"];
    [dict setObject:[NSString stringWithFormat:@"%zd",holeNum + 1] forKey:@"hotelId"];
    [dict setObject:_joingUserIdListStr forKey:@"joingUserIdList"];
    [dict setObject:_pushBarListStr forKey:@"pushBarList"];
    [dict setObject:_standardBarListStr forKey:@"standardBarList"];

    NSLog(@"%@=========",dict);
  
    [ShareBusinessManager.scoreManager addScoreWithParameters:dict success:^(id responObject) {
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {

    }];
    
}

//MARK: - TSOSingleScoringCellDelegate

- (void)tsoSingleScoringCell:(TSOSingleScoringCell *)cell standardNumChanged:(NSNumber *)standardNum{
    
    [self.scoreInfo.data.scoreList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ScoreList *scoreList = (ScoreList *)obj;
        if (scoreList.userId.integerValue == self.selBtn.tag) {
            Hole *hole = scoreList.holeScore[cell.row];
            hole.standardBar = standardNum;
            
        }
        
    }];
    
}

- (void)tsoSingleScoringCell:(TSOSingleScoringCell *)cell scoreChanged:(NSNumber *)score pushNumChanged:(NSNumber *)pushNum{
    
      [self.scoreInfo.data.scoreList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          ScoreList *scoreList = (ScoreList *)obj;
          if (scoreList.userId.integerValue == self.selBtn.tag) {
              Hole *hole = scoreList.holeScore[cell.row];
              hole.pushBar = pushNum;
              hole.actualBar = score;
          }
          
      }];
    
    [self refreshTotalScore];
}
//MARK: - TSOUSelectHoleViewDelegate

- (void)TSOUSelectHoleView:(TSOUSelectHoleView *)view holeButtonDidClick:(UIButton *)button{
    

     [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:button.tag - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    

    [SVProgressHUD showWithStatus:@"选择中..."];
   
    GOLFWeakObj(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [view removeFromSuperview];
        [SVProgressHUD dismiss];
        [weakself dismissMask];
    });
    
    if (button.tag <=9 ) {
        [self.titleBtn setTitle:[NSString stringWithFormat:@"%@%zd",_scoreInfo.data.groupInfo.beforeField,button.tag] forState:UIControlStateNormal];
    }else{
        [self.titleBtn setTitle:[NSString stringWithFormat:@"%@%zd",_scoreInfo.data.groupInfo.afterField,button.tag] forState:UIControlStateNormal];
    }
}

//MARK: - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
        NSInteger page = scrollView.contentOffset.x / SCREEN_WIDTH;
    NSInteger hole = page % 18;
    self.currentHole = hole;
    
    [self refreshWithHole:[NSNumber numberWithInteger:hole]];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / SCREEN_WIDTH;
    NSInteger hole = page % 18;
    
    [self addScoreRecordWithHoleNum:hole];
}

//MARK: - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 18;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    StandardHole *model = _standHolesModel.data[indexPath.row];
    
    TSOSingleScoringCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTSOSingleScoringCell forIndexPath:indexPath];
    cell.delegate = self;
    cell.row = indexPath.row;
    cell.standardNum = model.par;
    ScoreList *scorelistModel;
    
    
    
    for (ScoreList *scorelist in self.scoreInfo.data.scoreList) {
        if (self.selBtn.tag == scorelist.userId.integerValue) {
            scorelistModel = scorelist;
        
        }
    }

    Hole *hole = scorelistModel.holeScore[indexPath.row];
    cell.model = hole;
    if (hole.standardBar.integerValue >0) {
        cell.standardNum = hole.standardBar;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH, kItemHeight);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - Setter&Getter

- (UILabel *)totalScoreLb{
    if (_totalScoreLb == nil) {
        _totalScoreLb = [[UILabel alloc] init];
        _totalScoreLb.font = FONT(18);
        _totalScoreLb.textColor = BLACKCOLOR;
        _totalScoreLb.textAlignment = NSTextAlignmentCenter;
    }
    return _totalScoreLb;
}

- (UILabel *)totalPushScoreLb{
    if (_totalPushScoreLb == nil) {
        _totalPushScoreLb = [[UILabel alloc] init];
        _totalPushScoreLb.font = FONT(10);
        _totalPushScoreLb.textColor = LIGHTTEXTCOLOR;
        _totalPushScoreLb.textAlignment = NSTextAlignmentCenter;
    }
    return _totalPushScoreLb;
}

- (UILabel *)zongLb{
    if (_zongLb == nil) {
        _zongLb = [[UILabel alloc] init];
        _zongLb.font = FONT(14);
        _zongLb.text = @"总杆";
        _zongLb.textColor = BLACKCOLOR;
        _zongLb.textAlignment = NSTextAlignmentCenter;
    }
    return _zongLb;
}


- (UILabel *)tipLabel{
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = FONT(12);
        _tipLabel.textColor = GLOBALCOLOR;
        _tipLabel.text = @"左右滑动切换球洞";
    }
    return _tipLabel;
}

- (FBShimmeringView *)tipView{
    if (_tipView == nil) {
        _tipView = [[FBShimmeringView alloc]init];
        _tipView.shimmering = YES;
        _tipView.shimmeringOpacity = 1;
        _tipView.shimmeringDirection = FBShimmerDirectionRight;
        _tipView.shimmeringBeginFadeDuration = 0.3;
        _tipView.shimmeringSpeed = 100;
    }
    return _tipView;
}

- (TSOUSelectHoleView *)selectHoleView{
    if (_selectHoleView == nil) {
        _selectHoleView = [[TSOUSelectHoleView alloc] initWithGroupInfo:_scoreInfo.data.groupInfo];
        _selectHoleView.size = CGSizeMake(300, 230);
        _selectHoleView.center = self.view.center;
        _selectHoleView.delegate = self;
    }
    return _selectHoleView;
}


- (UIView *)playersView{
    if (_playersView == nil) {
        _playersView = [[UIView alloc] init];
    }
    return _playersView;
}

@end
