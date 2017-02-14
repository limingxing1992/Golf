//
//  PlaceDetailViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "STL_PageControl.h"
#import <MapKit/MapKit.h>

@interface PlaceDetailViewController ()
<
    SDCycleScrollViewDelegate,
    UITableViewDelegate,
    UITableViewDataSource
>
/** 收藏按钮*/
@property (nonatomic, strong) UIButton *collectBtn;
/** 分享按钮*/
@property (nonatomic, strong) UIButton *shareBtn;
/** 轮播banner*/
@property (nonatomic, strong) SDCycleScrollView *scorllView;
/** 自定义分页空间*/
@property (nonatomic, strong) STL_PageControl *pageControl;
/** 块图(承载按钮)*/
@property (nonatomic, strong) UIView *firstView_0;
/** 球场详情btn*/
@property (nonatomic, strong) STL_MixBtn *placeDetailBtn;
/** 联系电话btn*/
@property (nonatomic, strong) STL_MixBtn *phoneBtn;
/** 块图（展示地址信息）*/
@property (nonatomic, strong) UIView *secondView_0;
/** 图标*/
@property (nonatomic, strong) UIImageView *addressIv;
/** 地址*/
@property (nonatomic, strong) UILabel *addressLb;
/** 块图（评价入口）*/
@property (nonatomic, strong) UIView *thirdView_0;
/** 评价图标*/
@property (nonatomic, strong) UIImageView *jugeIv;
/** 评价标题*/
@property (nonatomic, strong) UILabel *jugeLb;
/** 入口图标*/
@property (nonatomic, strong) UIImageView *rigth_jugeIv;
/** 块图（套餐）*/
@property (nonatomic, strong) UIView *fourthView_0;
/** 套餐*/
@property (nonatomic, strong) UILabel *taocanLb;
/** 营业时间*/
@property (nonatomic, strong) UIView *fiveView_0;
/** 营业时间图标*/
@property (nonatomic, strong) UIImageView *timeIv;
/** 营业时间*/
@property (nonatomic, strong) UILabel *timeLb;
/** 套餐列表*/
@property (nonatomic, strong) UITableView *tableView;
/** 套餐数据源*/
@property (nonatomic, strong) NSMutableArray *data;
/** 套餐详情数据*/
@property (nonatomic, strong) PlaceDetailModel *model;

@property (nonatomic, strong) UIScrollView *bigScroll;//查看图片点击放大


@end

@implementation PlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNaviItem];//自定义导航栏
    [self.contentView addSubview:self.scorllView];
    [self.contentView addSubview:self.firstView_0];
    [self.contentView addSubview:self.secondView_0];
    [self.contentView addSubview:self.thirdView_0];
    [self.contentView addSubview:self.fourthView_0];
    [self.contentView addSubview:self.fiveView_0];
    [self.contentView addSubview:self.tableView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutSubViews];//布局
}

/** 自定义导航栏*/
- (void)customNaviItem{
    UIBarButtonItem *barCollect = [[UIBarButtonItem alloc] initWithCustomView:self.collectBtn];
    UIBarButtonItem *barShare = [[UIBarButtonItem alloc] initWithCustomView:self.shareBtn];
    self.navigationItem.rightBarButtonItems = @[barShare, barCollect];
    
}
/** 初始化数据*/
- (void)initData{
    _data = [[NSMutableArray alloc] init];
}
/** 自动布局*/
- (void)autoLayoutSubViews{
    _pageControl.sd_layout
    .bottomSpaceToView(_scorllView, 10)
    .rightSpaceToView(_scorllView, 15)
    .heightIs(11);
    
    _firstView_0.sd_layout
    .topSpaceToView(_scorllView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(60);
    //球场详情
    _placeDetailBtn.sd_layout
    .centerYEqualToView(_firstView_0)
    .centerXIs(SCREEN_WIDTH / 4);
    //客服电话
    _phoneBtn.sd_layout
    .centerYEqualToView(_firstView_0)
    .centerXIs(SCREEN_WIDTH / 4 * 3);
    
    
    _fiveView_0.sd_layout
    .topSpaceToView(_firstView_0, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(45);
    
    _timeIv.sd_layout
    .centerYEqualToView(_fiveView_0)
    .centerXIs(20)
    .heightIs(15)
    .widthIs(14);
    
    _timeLb.sd_layout
    .centerYEqualToView(_fiveView_0)
    .leftSpaceToView(_timeIv, 5)
    .rightSpaceToView(_fiveView_0, 15)
    .autoHeightRatio(0);
    
    
    _secondView_0.sd_layout
    .topSpaceToView(_fiveView_0, 0.5)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(45);
    
    _addressIv.sd_layout
    .centerYEqualToView(_secondView_0)
    .centerXIs(20)
    .heightIs(15)
    .widthIs(14);
    
    _addressLb.sd_layout
    .centerYEqualToView(_secondView_0)
    .leftSpaceToView(_addressIv, 5)
    .rightSpaceToView(_secondView_0, 15)
    .autoHeightRatio(0);
    
    _thirdView_0.sd_layout
    .topSpaceToView(_secondView_0, 0.5)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(45);
    
    _jugeIv.sd_layout
    .centerYEqualToView(_thirdView_0)
    .centerXIs(20)
    .heightIs(14)
    .widthIs(14);
    
    _jugeLb.sd_layout
    .centerYEqualToView(_thirdView_0)
    .leftEqualToView(_addressLb)
    .autoHeightRatio(0);
    [_jugeLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _rigth_jugeIv.sd_layout
    .centerYEqualToView(_thirdView_0)
    .rightSpaceToView(_thirdView_0, 15)
    .widthIs(7)
    .heightIs(12.5);
    
    _fourthView_0.sd_layout
    .topSpaceToView(_thirdView_0, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(45);
    
    _taocanLb.sd_layout
    .centerYEqualToView(_fourthView_0)
    .leftSpaceToView(_fourthView_0, 15)
    .rightSpaceToView(_fourthView_0, 15)
    .autoHeightRatio(0);
    
    _tableView.sd_layout
    .topSpaceToView(_fourthView_0, 0.5)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(_data.count * 90);
    
    [self.contentView setupAutoContentSizeWithBottomView:_tableView bottomMargin:10];

}

#pragma mark ----------------数据

- (void)loadData{
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"努力加载中"];
    if (!_ballPlaceId) {
        [SVProgressHUD showErrorWithStatus:@"服务器错误"];
        return;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:_ballPlaceId forKey:@"ballPlaceId"];
    if (IsLogin) {
        [dict setValue:[UserModel sharedUserModel].ID forKey:@"userId"];
    }
    
    [ShareBusinessManager.appointmentPlaceManager postAppointmentPlaceDetailWithParameter:dict
                                                                                  success:^(id responObject) {
                                                                                      [SVProgressHUD dismiss];
                                                                                       weakself.model = responObject;
                                                                                      [weakself updateUI];
                                                                                  }
                                                                                  failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                                      [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                                  }];
}

- (void)updateUI{
//    NSLog(@"%@",_model);
    //更新套餐数据
    [_data addObjectsFromArray:_model.comboList];
    _tableView.sd_layout
    .heightIs(_data.count *90);
    [_tableView reloadData];
    
    //更新地址信息
    _addressLb.text = _model.ballPlaceInfo.address;
    
    //更新评价数量
    _jugeLb.text = [NSString stringWithFormat:@"评价（%@）",_model.commentNum];
    
    //更新banner
    NSMutableArray *imgAry = [[NSMutableArray alloc] init];
    for (NSString *imgUl in _model.imgList) {
        [imgAry addObject:FULLIMGURL(imgUl)];
//        [imgAry addObject:dict[@"fpath"]];
    }
    [_scorllView setImageURLStringsGroup:imgAry];
    _pageControl.numberOfPage = _model.imgList.count;
    //更新收藏状态
    _collectBtn.selected = _model.collectStatus;
    //更新营业时间
    _timeLb.text = [NSString stringWithFormat:@"营业时间：%@-%@",_model.ballPlaceInfo.openTime, _model.ballPlaceInfo.closeTime];
    
}



#pragma mark ----------------界面逻辑
/** 查看球场详情*/
- (void)placeDetailInfoAction{
    AppoinmentPlaceDetailViewController *detailVc = [[AppoinmentPlaceDetailViewController alloc] init];
    detailVc.ballPlaceId = _ballPlaceId;
    [self.navigationController pushViewController:detailVc animated:YES];
}
/** 联系球场客服*/
- (void)connectPlacePhoneAction{
    if (!_model.ballPlaceInfo.servicePhone) {
        [SVProgressHUD showErrorWithStatus:@"暂无客服电话"];
        return;
    }
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",_model.ballPlaceInfo.servicePhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
/** 进入评价*/
- (void)jugeDetailAction{
    AppointPlaceCommentViewController *commentVc = [[AppointPlaceCommentViewController alloc] init];
    commentVc.placeID = _ballPlaceId.stringValue;
    [self.navigationController pushViewController:commentVc animated:YES];
}
/** 收藏*/
- (void)right_1_action{
    _collectBtn.selected = !_collectBtn.isSelected;
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyFavoriteAddWithParameters:@{@"collectType":@10,
                                                                        @"linkId":_model.ballPlaceInfo.ID}
                                                              success:^(id responObject) {
                                                                  if (weakself.collectBtn.selected) {
                                                                      [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                                                                  }else{
                                                                      [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
                                                                  }
                                                              } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                  [SVProgressHUD showErrorWithStatus:errorMsg];
                                                              }];
}
/** 分享*/
- (void)right_0_action{    
    GOLFWeakObj(self);
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMShareMenuSelectionView *shareSelectionView, UMSocialPlatformType platformType) {
        [weakself shareDataWithPlatform:platformType];
    }];
    
}

- (void)shareDataWithPlatform:(UMSocialPlatformType)platformType{
    // 创建UMSocialMessageObject实例进行分享
    // 分享数据对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UIImage *img = IMAGE(@"iconBig");
    UMShareWebpageObject *obj = [UMShareWebpageObject shareObjectWithTitle:@"小鸟娱动" descr:@"时尚运动，随心而动。高尔夫，不只是运动！" thumImage:img];
    obj.webpageUrl = @"https://apps.1035.mobi/lM9Ebv";
    messageObject.shareObject = obj;
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
        
    }];
    
}

/** 点击滚动视图*/
- (void)touchScrollBack{
    [self.bigScroll removeFromSuperview];
}
/** 进入预定界面*/
- (void)intoAppointmentSumbitWithIndex:(NSInteger)index{
    
    
    PlaceSubmitApointViewController *sumbitVc = [[PlaceSubmitApointViewController alloc] init];
    sumbitVc.model = _data[index];
    sumbitVc.openTime = _model.ballPlaceInfo.openTime;
    sumbitVc.endTime = _model.ballPlaceInfo.closeTime;
    sumbitVc.placeName = _model.ballPlaceInfo.name;
    [self.navigationController pushViewController:sumbitVc animated:YES];

}
/** 点击地址弹出地图选择方式*/
- (void)addressAlertAction{
    NSString *latStr = LatTi;
    NSString *longStr = LongTi;
    double currentLatTi = latStr.doubleValue;
    double currentLongTi = longStr.doubleValue;
    
    double latTi = _model.ballPlaceInfo.latitude.doubleValue;
    double longTi = _model.ballPlaceInfo.longitude.doubleValue;

    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"进入地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionSelf = [UIAlertAction actionWithTitle:@"原生地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (Device_VERSION >= 7.0) {// 直接调用ios自己带的apple map
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latTi, longTi) addressDictionary:nil]];
            toLocation.name = _model.ballPlaceInfo.name;
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        }
        else {// ios6以下，调用google map
//            NSString *urlString = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d",currentLat,currentLon,_locationCoordinate.latitude,_locationCoordinate.longitude];
//            urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            NSURL *aURL = [NSURL URLWithString:urlString];
//            [[UIApplication sharedApplication] openURL:aURL];
        }

    }];
    UIAlertAction *actionBaidu = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"baidumap://"]]){
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%lf,%lf|name:我的位置&destination=latlng:%lf,%lf|name:终点&mode=driving",currentLatTi, currentLongTi,latTi,longTi] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:@"请安装百度地图app"];
        }

    }];
    
    UIAlertAction *actionGaode = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"iosamap://"]]){
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&poiname=%@&lat=%f&lon=%f&dev=1&style=2",@"知足乐", @"yourscheme", @"终点", latTi,longTi] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:@"请安装高德地图app"];
        }
        
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVc addAction:actionCancel];
    [alertVc addAction:actionSelf];
    [alertVc addAction:actionBaidu];
    [alertVc addAction:actionGaode];

    [self presentViewController:alertVc animated:YES completion:nil];
}

//- (void)intoMap{
//    NSInteger selectrow = indexPath.row;
//    if (indexPath.section == 0) {
//        if (selectrow == 0) {
//            if (iOS7) {// 直接调用ios自己带的apple map
//                MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
//                MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:_locationCoordinate addressDictionary:nil]];
//                toLocation.name = _merchantInfo.merchantName;
//                [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
//                               launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
//            }
//            else {// ios6以下，调用google map
//                NSString *urlString = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d",currentLat,currentLon,_locationCoordinate.latitude,_locationCoordinate.longitude];
//                urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                NSURL *aURL = [NSURL URLWithString:urlString];
//                [[UIApplication sharedApplication] openURL:aURL];
//            }
//        }
//        else if (selectrow == 1)
//        {
//            if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"baidumap://"]]){
//                NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:终点&mode=driving",currentLat, currentLon,addressLat,addressLon] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
//                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
//            }
//            else
//            {
//                [SVProgressHUD showInfoWithStatus:@"请安装百度地图app"];
//            }
//        }
//        else if (selectrow == 2)
//        {
//            if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"iosamap://"]]){
//                NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&poiname=%@&lat=%f&lon=%f&dev=1&style=2",@"知足乐", @"yourscheme", @"终点", addressLat, addressLon] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
//            }
//            else
//            {
//                [SVProgressHUD showInfoWithStatus:@"请安装高德地图app"];
//            }
//        }
//}



#pragma mark ----------------SDCyscrollView代理

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    [_pageControl setCurrentPage:index];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self.view addSubview:self.bigScroll];
    NSArray *ary = _scorllView.imageURLStringsGroup;
    self.bigScroll.contentSize = CGSizeMake(SCREEN_WIDTH *ary.count, SCREEN_HEIGHT);
    
    for (NSInteger i = 0; i < ary.count; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH *i, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 200)];
        [iv sd_setImageWithURL:ary[i] placeholderImage:Placeholder_big];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        [self.bigScroll addSubview:iv];
    }
    
    [_bigScroll setContentOffset:CGPointMake(SCREEN_WIDTH *index, 0)];

}

#pragma mark ----------------tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GOLFWeakObj(self);
    TaocanPlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taocanCell"];
    cell.model = _data[indexPath.row];
    cell.block = ^{
        [weakself intoAppointmentSumbitWithIndex:indexPath.row];
    };
    return cell;
}

#pragma mark ----------------实例

- (UIButton *)collectBtn{
    if (!_collectBtn) {
        _collectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [_collectBtn setImage:IMAGE(@"classify47") forState:UIControlStateNormal];
        [_collectBtn setImage:IMAGE(@"classify46") forState:UIControlStateSelected];
        [_collectBtn addTarget:self action:@selector(right_1_action) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}

- (UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25 )];
        [_shareBtn setImage:IMAGE(@"classify49") forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(right_0_action) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (SDCycleScrollView *)scorllView{
    if (!_scorllView) {
        _scorllView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 185) delegate:self placeholderImage:Placeholder_big];
        _scorllView.autoScroll = YES;//关闭自动轮播
        _scorllView.showPageControl = NO;
        [_scorllView addSubview:self.pageControl];
        [_scorllView setBackgroundColor:RGBColor(240, 240, 240)];
    }
    return _scorllView;
}

- (STL_PageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[STL_PageControl alloc] init];
        _pageControl.numberOfPage = 0;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (UIView *)firstView_0{
    if (!_firstView_0) {
        _firstView_0 = [[UIView alloc] init];
        _firstView_0.backgroundColor = WHITECOLOR;
        [_firstView_0 addSubview:self.placeDetailBtn];
        [_firstView_0 addSubview:self.phoneBtn];
    }
    return _firstView_0;
}

- (STL_MixBtn *)placeDetailBtn{
    if (!_placeDetailBtn) {
        _placeDetailBtn = [[STL_MixBtn alloc] initWithImage:IMAGE(@"classify50") title:@"球场详情"];
        [_placeDetailBtn addTarget:self action:@selector(placeDetailInfoAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _placeDetailBtn;
}

- (STL_MixBtn *)phoneBtn{
    if (!_phoneBtn) {
        _phoneBtn = [[STL_MixBtn alloc] initWithImage:IMAGE(@"classify51") title:@"客服电话"];
        [_phoneBtn addTarget:self action:@selector(connectPlacePhoneAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;

}

- (UIView *)secondView_0{
    if (!_secondView_0) {
        _secondView_0 = [[UIView alloc] init];
        _secondView_0.backgroundColor = WHITECOLOR;
        [_secondView_0 addSubview:self.addressIv];
        [_secondView_0 addSubview:self.addressLb];
    }
    return _secondView_0;
}

- (UIView *)thirdView_0{
    if (!_thirdView_0) {
        _thirdView_0 = [[UIView alloc] init];
        _thirdView_0.backgroundColor = WHITECOLOR;
        [_thirdView_0 addSubview:self.jugeIv];
        [_thirdView_0 addSubview:self.jugeLb];
        [_thirdView_0 addSubview:self.rigth_jugeIv];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jugeDetailAction)];
        [_thirdView_0 addGestureRecognizer:tap];
    }
    return _thirdView_0;
}

- (UIImageView *)addressIv{
    if (!_addressIv) {
        _addressIv = [[UIImageView alloc] init];
        _addressIv.image = IMAGE(@"classify53");
    }
    return _addressIv;
}

- (UILabel *)addressLb{
    if (!_addressLb) {
        _addressLb = [[UILabel alloc] init];
        _addressLb.font = FONT(12);
        _addressLb.textColor = BLACKTEXTCOLOR;
        _addressLb.text = @"未知地址";
        _addressLb.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressAlertAction)];
        [_addressLb addGestureRecognizer:tap];
    }
    return _addressLb;
}

- (UIImageView *)jugeIv{
    if (!_jugeIv) {
        _jugeIv = [[UIImageView alloc] init];
        _jugeIv.image = IMAGE(@"classify52");
    }
    return _jugeIv;

}

- (UILabel *)jugeLb{
    if (!_jugeLb) {
        _jugeLb = [[UILabel alloc] init];
        _jugeLb.font = FONT(12);
        _jugeLb.textColor = BLACKTEXTCOLOR;
        _jugeLb.text = @"评价(0)";
    }
    return _jugeLb;
}

- (UIImageView *)rigth_jugeIv{
    if (!_rigth_jugeIv) {
        _rigth_jugeIv = [[UIImageView alloc] init];
        _rigth_jugeIv.image = IMAGE(@"classify8");
    }
    return _rigth_jugeIv;
}

- (UIView *)fourthView_0{
    if (!_fourthView_0) {
        _fourthView_0 = [[UIView alloc] init];
        _fourthView_0.backgroundColor = WHITECOLOR;
        [_fourthView_0 addSubview:self.taocanLb];
    }
    return _fourthView_0;
}

- (UILabel *)taocanLb{
    if (!_taocanLb) {
        _taocanLb = [[UILabel alloc] init];
        _taocanLb.font = FONT(12);
        _taocanLb.textColor = BLACKTEXTCOLOR;
        _taocanLb.text = @"精选套餐";
    }
    return _taocanLb;
}

- (UIView *)fiveView_0{
    if (!_fiveView_0) {
        _fiveView_0 = [[UIView alloc] init];
        _fiveView_0.backgroundColor = WHITECOLOR;
        [_fiveView_0 addSubview:self.timeIv];
        [_fiveView_0 addSubview:self.timeLb];
    }
    return _fiveView_0;
}

- (UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.textColor = BLACKTEXTCOLOR;
        _timeLb.font = FONT(12);
        _timeLb.text = @"营业时间：00：00-00:00";
    }
    return _timeLb;
}

- (UIImageView *)timeIv{
    if (!_timeIv) {
        _timeIv = [[UIImageView alloc] init];
        _timeIv.image = IMAGE(@"classify210");
    }
    return _timeIv;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.scrollEnabled = NO;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TaocanPlaceTableViewCell class] forCellReuseIdentifier:@"taocanCell"];
    }
    return _tableView;
}

- (UIScrollView *)bigScroll{
    if (_bigScroll == nil) {
        _bigScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bigScroll.showsVerticalScrollIndicator = NO;
        _bigScroll.showsHorizontalScrollIndicator = NO;
        _bigScroll.backgroundColor = [UIColor blackColor];
        _bigScroll.pagingEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollBack)];
        [_bigScroll addGestureRecognizer:tap];
    }
    return _bigScroll;
}

@end
