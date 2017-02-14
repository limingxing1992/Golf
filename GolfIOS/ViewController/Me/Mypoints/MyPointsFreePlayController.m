//
//  MyPointsFreePlayController.m
//  GolfIOS
//
//  Created by wyao on 16/11/22.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyPointsFreePlayController.h"
#import "MyPointsExchangeViewController.h"

@interface MyPointsFreePlayController ()
/** 头部图片*/
@property (nonatomic, strong) UIImageView *topIv;
/** 头部描述*/
@property (nonatomic, strong) UIView *topDetailView;
/** 积分分割线*/
@property (nonatomic, strong)UIView *sepaLine;

/** 底部背景视图*/
@property (nonatomic, strong) UIView *FootBgView;
/** 兑换内容视图*/
@property (nonatomic, strong) UIView *ContentDetailView;
/** 兑换须知视图*/
@property (nonatomic, strong) UIView *NoticeView;


/** 兑换名称*/
@property (nonatomic, strong) UILabel *serviceNameLabel;
/** 兑换时间*/
@property (nonatomic, strong) UILabel *createTimeLabel;
/** 兑换积分*/
@property (nonatomic, strong) UILabel *scoreLabel;
/** 兑换内容*/
@property (nonatomic, strong) UILabel *serviceContentLabel;
/** 兑换须知*/
@property (nonatomic, strong) UILabel *noticeContentLabel;

@end

@implementation MyPointsFreePlayController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"兑换服务";
    
    //禁止UIScrollView水平方向滚动，只允许垂直方向滚动
    self.contentView.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
   
//    [self setUI];
    
}


#pragma mark - 模型数据获取设置UI
-(void)setPointsModel:(MyPointsModel *)PointsModel{
    _PointsModel = PointsModel;
    //兑换名称
    self.serviceNameLabel.text = !PointsModel.serviceName ? @"未知服务" : PointsModel.serviceName;
    //兑换积分
    self.scoreLabel.text = !PointsModel.score ? @"0" : PointsModel.score;
    //兑换内容
    self.serviceContentLabel.text = !PointsModel.content ? @"没有内容" : PointsModel.content;
    //兑换须知
    self.noticeContentLabel.text = !PointsModel.notice ? @"未知内容" : PointsModel.notice;

    [self setUI];

}


#pragma mark - 初始化UI
-(void)setUI{
    
    [self.contentView addSubview:self.topDetailView];
    [self.contentView addSubview:self.ContentDetailView];
    [self.contentView addSubview:self.NoticeView];
    [self.view addSubview:self.FootBgView];
    
    //头部
    [self layoutTopDetailSubViews];
    //内容
    [self layoutContentDetailView];
    //须知
    [self layoutNoticeView];
    
    //底部视图
    self.FootBgView.sd_layout
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(60);
    
}


#pragma mark - 布局头部视图

-(void)layoutTopDetailSubViews{
    
    self.topDetailView.sd_layout
    .topSpaceToView(self.contentView,12)
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(75);
    
    
    //头像图标
    [self.topDetailView addSubview:self.topIv];
    
    //名称
    [self.topDetailView addSubview:self.serviceNameLabel];
    
    //分割线
    [self.topDetailView addSubview:self.sepaLine];
    
    //积分
    if (self.scoreLabel.text == nil) {
        self.scoreLabel.text = @"0";
    }
    NSString *pointString = [NSString stringWithFormat:@"%@ 积分",self.scoreLabel.text];
    [self.scoreLabel attribute:pointString changeString:self.scoreLabel.text color:[UIColor redColor] font:FONT(18)];
    [self.topDetailView addSubview:self.scoreLabel];
    
    
    //布局
    self.topIv.sd_layout
    .topSpaceToView(self.topDetailView,8)
    .leftSpaceToView(self.topDetailView,10)
    .widthIs(50)
    .heightIs(50);
    self.topIv.sd_cornerRadius = @(25);
    
    
    self.serviceNameLabel.sd_layout
    .centerYEqualToView(self.topIv)
    .leftSpaceToView(self.topIv,8)
    .autoHeightRatio(0);
    [self.serviceNameLabel setMaxNumberOfLinesToShow:1];
    [self.serviceNameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
    self.scoreLabel.sd_layout
    .centerYEqualToView(self.topDetailView)
    .rightSpaceToView(self.topDetailView ,15)
    .autoHeightRatio(0);
    [self.scoreLabel setMaxNumberOfLinesToShow:1];
    [self.scoreLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    
    self.sepaLine.sd_layout
    .centerYEqualToView(self.scoreLabel)
    .rightSpaceToView(self.scoreLabel,6)
    .heightIs(35)
    .widthIs(2);
}

#pragma mark -根据label获取高度
-(CGFloat)GetHeightWithLabelText:(NSString *)DetailText{
      
    //获取tttLabel的高度
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:DetailText];
    //自定义str一样的行间距
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    paragrapStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [paragrapStyle setLineSpacing:15];
    //设置行间距
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragrapStyle range:NSMakeRange(0, DetailText.length)];
    //设置字体
    [attrString addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, DetailText.length)];
    
     NSDictionary *dic = @{NSFontAttributeName:FONT(15), NSParagraphStyleAttributeName:paragrapStyle};
    
    //得到自定义行间距的UILabel的高度
    CGRect rect = [DetailText boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 30,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil];

    return rect.size.height;
    
}


#pragma mark -兑换内容
-(void)layoutContentDetailView{
    
    //计算高度
    CGFloat realHeight = [self GetHeightWithLabelText:self.serviceContentLabel.text];
    
    
    NSLog(@"--realHeight--------->%f",realHeight);
    
    self.ContentDetailView.sd_layout
    .topSpaceToView(self.topDetailView,12)
    .leftSpaceToView(self.contentView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(realHeight + 60);
    
    UILabel  *label = [UILabel labelWithText:@"兑换内容" andTextColor:LIGHTTEXTCOLOR andFontSize:16.0f];
    [self.ContentDetailView addSubview:label];
    label.sd_layout
    .topSpaceToView(self.ContentDetailView,15)
    .leftSpaceToView(self.ContentDetailView,15)
    .autoHeightRatio(0);
    [label setMaxNumberOfLinesToShow:1];
    [label setSingleLineAutoResizeWithMaxWidth:100];
    
     UIView *sepaLineView = [[UIView alloc] init];
     sepaLineView.backgroundColor = BACKGROUNDCOLOR;
    [self.ContentDetailView addSubview:sepaLineView];
    sepaLineView.sd_layout
    .topSpaceToView(label,15)
    .leftSpaceToView(self.ContentDetailView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(1);
    

    
    [self.ContentDetailView addSubview:self.serviceContentLabel];
    self.serviceContentLabel.sd_layout
    .topSpaceToView(sepaLineView,0)
    .leftSpaceToView(self.ContentDetailView,15)
    .heightIs(realHeight)
    .widthIs(SCREEN_WIDTH -30);
//    [self.serviceContentLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH -30];
//    [self.ContentDetailView setupAutoHeightWithBottomView:self.serviceContentLabel bottomMargin:15];
    
}

#pragma mark -兑换须知
-(void)layoutNoticeView{
    
    //计算高度
    CGFloat realHeight = [self GetHeightWithLabelText:self.noticeContentLabel.text];
    
    self.NoticeView.sd_layout
    .topSpaceToView(self.ContentDetailView,12)
    .leftSpaceToView(self.contentView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(realHeight + 60);

    UILabel  *label = [UILabel labelWithText:@"兑换须知" andTextColor:LIGHTTEXTCOLOR andFontSize:16.0f];
    [self.NoticeView addSubview:label];
    label.sd_layout
    .topSpaceToView(self.NoticeView,15)
    .leftSpaceToView(self.NoticeView,15)
    .autoHeightRatio(0);
    [label setMaxNumberOfLinesToShow:1];
    [label setSingleLineAutoResizeWithMaxWidth:100];
    
    UIView *sepaLineView = [[UIView alloc] init];
    sepaLineView.backgroundColor = BACKGROUNDCOLOR;
    [self.NoticeView addSubview:sepaLineView];
    sepaLineView.sd_layout
    .topSpaceToView(label,15)
    .leftSpaceToView(self.NoticeView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(1);
    
    [self.NoticeView addSubview:self.noticeContentLabel];
    self.noticeContentLabel.sd_layout
    .topSpaceToView(sepaLineView,0)
    .leftSpaceToView(self.NoticeView,15)
    .heightIs(realHeight)
    .widthIs(SCREEN_WIDTH -30);
    //[self.noticeContentLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH -30];
    //[self.NoticeView setupAutoHeightWithBottomView:self.noticeContentLabel bottomMargin:15];
    
    
}

#pragma mark - 底部创建按钮
-(void)layoutFootView{
    
    UIButton *creatBtn = [[UIButton alloc] init];
    [creatBtn setTitle:@"去兑换" forState:UIControlStateNormal];
    [creatBtn setBackgroundColor:[UIColor colorWithHex:0x2aa344]];
    [creatBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    creatBtn.titleLabel.font = FONT(15);
    creatBtn.tag = 1;
    [creatBtn addTarget:self action:@selector(creatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.FootBgView addSubview:creatBtn];
    
    creatBtn.sd_layout
    .topSpaceToView(self.FootBgView,10)
    .leftSpaceToView(self.FootBgView,18)
    .bottomSpaceToView(self.FootBgView,10)
    .rightSpaceToView(self.FootBgView,18);
}



#pragma mark - 创建俱乐部
-(void)creatBtnClick:(UIButton*)sender{
    NSString *message = [NSString stringWithFormat:@"请确认花费%@积分兑换该服务？", _PointsModel.score];
    GOLFWeakObj(self);
    [STL_CommonIdea alertWithTarget:self Title:@"兑换确认" message:message action_0:@"确认兑换" action_1:@"放弃" block_0:^{
        [SVProgressHUD show];
        
        [ShareBusinessManager.userManager postMyPointsConverServiceWithParameters:@{@"serviceId":_PointsModel.ID}
                                                                          success:^(id responObject) {
                                                                              [SVProgressHUD showSuccessWithStatus:@"兑换成功,请等待客服联系"];
                                                                              [weakself updateMyBalance];
                                                                          } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                              [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                          }];
    } block_1:nil];    
}
/** 本页面兑换成功后需要及时刷新积分*/
- (void)updateMyBalance{
    [ShareBusinessManager.loginManager postUserBanlanceScoreWithParameters:nil
                                                                   success:^(id responObject) {
                                                                       [UserModel sharedUserModel].money = responObject[@"money"];
                                                                       [UserModel sharedUserModel].score = [responObject[@"score"] stringValue];
                                                                   }
                                                                   failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                       [UserModel sharedUserModel].money = @"0";
                                                                       [UserModel sharedUserModel].score = @"0";
                                                                   }];
}


#pragma mark - 懒加载
-(UIView *)topDetailView{
    if (!_topDetailView) {
        _topDetailView = [[UIView alloc] init];
        _topDetailView.backgroundColor = WHITECOLOR;
    }
    return _topDetailView;
    
}

- (UIImageView *)topIv{
    if (!_topIv) {
        _topIv = [[UIImageView alloc] init];
        _topIv.image = IMAGE(@"classify153");
    }
    return _topIv;
}

-(UIView *)FootBgView{
    if (!_FootBgView) {
        _FootBgView = [[UIView alloc] init];
        _FootBgView.backgroundColor = WHITECOLOR;
        [self layoutFootView];
    }
    return _FootBgView;
}


-(UILabel *)serviceNameLabel{
    if (!_serviceNameLabel) {
        _serviceNameLabel = [UILabel labelWithText:@"免费一次打球服务" andTextColor:BLACKTEXTCOLOR andFontSize:18];
        [_serviceNameLabel sizeToFit];
    }
    return _serviceNameLabel;
}

-(UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.textColor = LIGHTTEXTCOLOR;
        _scoreLabel.font = FONT(18);
        [_scoreLabel sizeToFit];
    }
    return _scoreLabel;
}


-(UIView *)sepaLine{
    if (!_sepaLine) {
        _sepaLine = [[UIView alloc] init];
        _sepaLine.backgroundColor = BACKGROUNDCOLOR;
    }
    return _sepaLine;
}
-(UIView *)ContentDetailView{
    if (!_ContentDetailView) {
        _ContentDetailView = [[UIView alloc] init];
        _ContentDetailView.backgroundColor = WHITECOLOR;
    }
    return _ContentDetailView;
}

-(UIView *)NoticeView{
    if (!_NoticeView) {
        _NoticeView = [[UIView alloc] init];
        _NoticeView.backgroundColor = WHITECOLOR;
    }
    return _NoticeView;
}

-(UILabel *)serviceContentLabel{
    if (!_serviceContentLabel) {
        _serviceContentLabel = [UILabel labelWithText:@"没有内容" andTextColor:LIGHTTEXTCOLOR andFontSize:15];
        //设置行间距
        [UILabel changeLineSpaceForLabel:_serviceContentLabel WithSpace:15];
        _serviceContentLabel.numberOfLines = 0;
        _serviceContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _serviceContentLabel;
}

-(UILabel *)noticeContentLabel{
    if (!_noticeContentLabel) {
        _noticeContentLabel = [UILabel labelWithText:@"没有内容" andTextColor:LIGHTTEXTCOLOR andFontSize:15];
        //设置行间距
        [UILabel changeLineSpaceForLabel:_noticeContentLabel WithSpace:15];
        _noticeContentLabel.numberOfLines = 0;
        _noticeContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _noticeContentLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
