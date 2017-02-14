//
//  PlaceSubmitApointViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "PlaceSubmitApointViewController.h"

@interface PlaceSubmitApointViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UITextFieldDelegate,
    STL_PickerViewDelegate,
    STL_TimePickerViewDelegate,
    STL_NumPickerViewDelegate
>
/** 套餐信息*/
@property (nonatomic, strong) TaocanPlaceTableViewCell *taocanInfoCell;
/** 服务条例*/
@property (nonatomic, strong) UILabel *noticeLb;
/** 列表信息*/
@property (nonatomic, strong) UITableView *tableView;
/** 列表标题信息*/
@property (nonatomic, strong) NSArray *titleAry_0;
@property (nonatomic, strong) NSArray *titleAry_1;
@property (nonatomic, strong) NSArray *titleAry_2;

/** 联系人输入框*/
@property (nonatomic, strong) UITextField *connectNameTf;
/** 联系电话输入框*/
@property (nonatomic, strong) UITextField *connectPhoneTf;
/** 备注输入框*/
@property (nonatomic, strong) UITextField *connectRemarkTf;
/** 预约按钮*/
@property (nonatomic, strong) UIButton *submitBtn;
/** 预订信息*/
@property (nonatomic, strong) PlaceSumbitModel *submitModel;

@property (nonatomic, strong) STL_PickerView *datePickView;

@property (nonatomic, strong) STL_TimePickerView *timePickView;

@property (nonatomic, strong) STL_NumPickerView *numPickView;


@end

@implementation PlaceSubmitApointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"预订信息";
    [self.contentView addSubview:self.taocanInfoCell];
    [self.contentView addSubview:self.noticeLb];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.submitBtn];
    [self.datePickView setBackgroundColor:WHITECOLOR];
    [GOLFNotificationCenter addObserver:self selector:@selector(keyBoardShowAction:) name:UIKeyboardWillShowNotification object:nil];
    [GOLFNotificationCenter addObserver:self selector:@selector(keyBoardHideAction:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutSubViews];//自动布局
    [self.tableView reloadData];
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}

#pragma mark ----------------数据

/** 初始化数据*/
- (void)initData{
    _titleAry_0 = @[@"打球日期", @"开始时间", @"打球类型"];
    _titleAry_1 = @[@"打球人数", @"联系人姓名", @"联系人电话"];
    _titleAry_2 = @[@"备注"];
    [self connectDate];
}

/** 处理时间*/
- (void)connectDate{
    _submitModel = [[PlaceSumbitModel alloc] init];
    NSUInteger month = [NSDate jk_month:[NSDate date]];
    NSUInteger day = [NSDate jk_day:[NSDate date]];
    NSUInteger year = [NSDate jk_year:[NSDate date]];
    _submitModel.playDateYear = year;
    _submitModel.playDateMonth = month;
    _submitModel.playDateDay = day;
    _submitModel.playWeek = [NSDate jk_dayFromWeekday:[NSDate date]];
    _submitModel.count = _model.minMember;//最少人数
    _submitModel.comboId = _model.ID;//套餐id
    _submitModel.typeName = _model.typeName;//套餐类型
    _submitModel.starTime = _openTime;
    _submitModel.connectNotice = @"无备注";
    _submitModel.price = _model.price;
}

/** 自动布局*/
- (void)autoLayoutSubViews{
    _taocanInfoCell.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(90);
    
    _noticeLb.sd_layout
    .centerYIs(114)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    
    NSInteger count = _titleAry_0.count + _titleAry_1.count + _titleAry_2.count ;
    
    _tableView.sd_layout
    .topSpaceToView(_taocanInfoCell, 28)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(40 + count *45);
    
    _submitBtn.sd_layout
    .topSpaceToView(_tableView, 0)
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .heightIs(40);
    [_submitBtn setSd_cornerRadius:@5];
    
    [self.contentView setupAutoContentSizeWithBottomView:_submitBtn bottomMargin:10];
}
#pragma mark ----------------监听输入框弹出和隐藏

- (void)keyBoardShowAction:(NSNotification *)fication{
    NSDictionary *info = [fication userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;

    GOLFWeakObj(self);
    [UIView animateWithDuration:0.15 animations:^{
        weakself.contentView.transform = CGAffineTransformMakeTranslation(0, -keyboardSize.height);
    }];
    
}

- (void)keyBoardHideAction:(NSNotification *)fication{
    GOLFWeakObj(self);
    [UIView animateWithDuration:0.15 animations:^{
        weakself.contentView.transform = CGAffineTransformIdentity;
    }];
    
}

#pragma mark ----------------预约
/** 点击立即预约按钮*/
- (void)submitOrderAction{
    
    
    [self.view endEditing:YES];
    GOLFWeakObj(self);
    [STL_CommonIdea alertWithTarget:self Title:@"确认提交订单？" message:nil action_0:@"取消" action_1:@"确定" block_0:nil block_1:^{
        [weakself sumbitOrder];
    }];

}
/** 下单操作*/
- (void)sumbitOrder{
    if (!_submitModel.connectPhone.length || !_submitModel.connectName.length || ![_submitModel.connectPhone validateMobile]) {
        [SVProgressHUD showErrorWithStatus:@"请正确填写联系人信息"];
        return;
    }
    
    if (!IsLogin) {
        [self presentViewController:LoginNavi animated:YES completion:nil];
        return;
    }
    
    [SVProgressHUD show];
    GOLFWeakObj(self);
    NSString *time = [NSString stringWithFormat:@"%ld-%ld-%ld %@:00",_submitModel.playDateYear, _submitModel.playDateMonth, _submitModel.playDateDay, _submitModel.starTime];
    
    
    NSDictionary *dict = @{@"ballComboId":_submitModel.comboId,
                           @"bookTime":time,
                           @"personNum":[NSNumber numberWithInteger:_submitModel.count],
                           @"phoneNumber":_submitModel.connectPhone,
                           @"phoneUser":_submitModel.connectName,
                           @"remark":_submitModel
                           .connectNotice};
    [ShareBusinessManager.appointmentPlaceManager postAppointmentPlaceSubmitWithParameter:dict
                                                                                  success:^(id responObject) {
                                                                                      [SVProgressHUD showSuccessWithStatus:@"订单提交成功"];
                                                                                      PayOrderViewController *sureVc = [[PayOrderViewController alloc] init];
                                                                                      sureVc.model = weakself.submitModel;
                                                                                      sureVc.placeName = weakself.placeName;
                                                                                      sureVc.orderNo = responObject;
                                                                                      [weakself.navigationController pushViewController:sureVc animated:YES];
                                                                                  } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                                      [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                                  }];
    
}
/** 编辑预约信息*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //点击选择打球日期
                    [self alertView:self.datePickView];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [GOLFNotificationCenter postNotificationName:@"firstSelect" object:nil];
                    });
                }
                    break;
                case 1:
                {
                    //选择开始时间
                    [self alertViewTime:self.timePickView];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [GOLFNotificationCenter postNotificationName:@"firstTimeSelect" object:nil];
                    });
                }
                    break;
                case 2:
                {
                    //选择打球类型
                }
                    break;
  
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //点击选择打球人数
                    [self alertViewNum:self.numPickView];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [GOLFNotificationCenter postNotificationName:@"firstNumSelect" object:nil];
                    });
                }
                    break;
                case 1:
                {
//                    //编辑联系人姓名
//                    AppointPlaceEditInfoViewController *editVc = [[AppointPlaceEditInfoViewController alloc] init];
//                    editVc.model = _submitModel;
//                    editVc.type = 0;
//                    [self.navigationController pushViewController:editVc animated:YES];

                }
                    break;
                case 2:
                {
//                    //编辑联系人电话
//                    AppointPlaceEditInfoViewController *editVc = [[AppointPlaceEditInfoViewController alloc] init];
//                    editVc.model = _submitModel;
//                    editVc.type = 1;
//                    [self.navigationController pushViewController:editVc animated:YES];
                }
                    break;
                default:
                    break;
            }

        }
            break;
        case 2:
        {
            //编辑备注
//            AppointPlaceEditInfoViewController *editVc = [[AppointPlaceEditInfoViewController alloc] init];
//            editVc.model = _submitModel;
//            editVc.type = 2;
//            [self.navigationController pushViewController:editVc animated:YES];

        }
            break;
        default:
            break;
    }
}

#pragma mark ----------------tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return _titleAry_0.count;
        }
            break;
        case 1:
        {
            return _titleAry_1.count;
        }
            break;
        case 2:
        {
            return _titleAry_2.count;
        }
            break;
        default:
        {
            return 0;
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"placeApointInfoCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = FONT(14);
    cell.detailTextLabel.font = FONT(14);
    cell.textLabel.textColor = BLACKTEXTCOLOR;
    cell.detailTextLabel.textColor = BLACKTEXTCOLOR;
    cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];
    cell.detailTextLabel.text = @"";//
    NSString *title;
    switch (indexPath.section) {
        case 0:
        {
            title = _titleAry_0[indexPath.row];
            if (indexPath.row == 1) {
                cell.detailTextLabel.attributedText = [_submitModel.starTime attributeStrWithAttributes:@{NSForegroundColorAttributeName: GLOBALCOLOR} range:NSMakeRange(0, _submitModel.starTime.length)];
            }
            if (indexPath.row == 0) {
                cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify55")];
                NSString *date = [NSString stringWithFormat:@"%.2ld月%.2ld号 %@",_submitModel.playDateMonth, _submitModel.playDateDay, _submitModel.playWeek];
                cell.detailTextLabel.attributedText = [date attributeStrWithAttributes:@{NSForegroundColorAttributeName:GLOBALCOLOR} range:NSMakeRange(0, 6)];
                
            }
            
            if (indexPath.row == 2) {
                cell.accessoryView= nil;
                //球场类型
                cell.detailTextLabel.text = _submitModel.typeName;
            }
        }
            break;
        case 1:
        {
            title = _titleAry_1[indexPath.row];
            if (indexPath.row == 1) {
                cell.accessoryView = self.connectNameTf;
            }else if (indexPath.row == 2){
                cell.accessoryView = self.connectPhoneTf;
            }
            
            if (indexPath.row == 0) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%2ld人", _submitModel.count];
            }
        }
            break;
        case 2:
        {
            title = _titleAry_2[indexPath.row];
            cell.accessoryView = self.connectRemarkTf;
        }
            break;
        default:
            break;
    }
    //标题
    cell.textLabel.text = title;
    return cell;
}

#pragma mark ----------------文本输入框代理


- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (_connectNameTf == textField) {
        NSLog(@"%@", _connectNameTf.text);
        _submitModel.connectName = _connectNameTf.text;
    }
    
    if (_connectPhoneTf == textField) {
        _submitModel.connectPhone = _connectPhoneTf.text;
    }
    
    if (_connectRemarkTf == textField) {
        _submitModel.connectNotice = _connectRemarkTf.text;
    }
    
}

#pragma mark ----------------弹窗服务条例

- (void)alertServiceRule{
    ServiceRuleView *rule = [[ServiceRuleView alloc] initWithFrame:[UIScreen mainScreen].bounds message:_model.notice];
    [rule show];
}

#pragma mark ----------------弹窗选择器

- (void)alertView:(STL_PickerView *)customView{
    STL_AlertCustomView *alert = [[STL_AlertCustomView alloc] initWithFrame:[UIScreen mainScreen].bounds customView:customView];
    customView.delegate = alert;
    [alert show];
}

- (void)alertViewTime:(STL_TimePickerView *)customView{
    STL_AlertCustomView *alert = [[STL_AlertCustomView alloc] initWithFrame:[UIScreen mainScreen].bounds customView:customView];
    customView.delegate = alert;
    [alert show];
}

- (void)alertViewNum:(STL_NumPickerView *)customView{
    STL_AlertCustomView *alert = [[STL_AlertCustomView alloc] initWithFrame:[UIScreen mainScreen].bounds customView:customView];
    customView.delegate = alert;
    [alert show];
}

#pragma mark ----------------改变时间

- (void)sureWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day week:(NSString *)week{
    _submitModel.playDateYear = year;
    _submitModel.playDateMonth = month;
    _submitModel.playDateDay = day;
    _submitModel.playWeek = week;
    [self.tableView reloadData];
}

- (void)sureWithTime:(NSString*)time{
    _submitModel.starTime = time;
    [self.tableView reloadData];
}

- (void)sureWithCount:(NSInteger)count{
    _submitModel.count = count;
    
    
    [self.tableView reloadData];
}

- (void)cancel{
    
}


#pragma mark ----------------实例

- (TaocanPlaceTableViewCell *)taocanInfoCell{
    if (!_taocanInfoCell) {
        _taocanInfoCell = [[TaocanPlaceTableViewCell alloc] init];
        _taocanInfoCell.model = _model;
        [_taocanInfoCell.priceLb removeFromSuperview];
        [_taocanInfoCell.apointBtn removeFromSuperview];
    }
    return _taocanInfoCell;
}

- (UILabel *)noticeLb{
    if (!_noticeLb) {
        _noticeLb = [[UILabel alloc] init];
        _noticeLb.textColor = OrangeCOLOR;
        _noticeLb.font = FONT(10);
        _noticeLb.text = @"服务条例: 请提前24小时预约 >";
        _noticeLb.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertServiceRule)];
        [_noticeLb addGestureRecognizer:tap];
        
    }
    return _noticeLb;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.scrollEnabled = NO;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"placeApointInfoCell"];
    }
    return _tableView;
}

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _submitBtn.backgroundColor = GLOBALCOLOR;
        _submitBtn.titleLabel.font = FONT(16);
        [_submitBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_submitBtn setTitle:@"立即预约" forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitOrderAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (UITextField *)connectNameTf{
    if (!_connectNameTf) {
        _connectNameTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 150, 45)];
        _connectNameTf.font = FONT(12);
        _connectNameTf.textColor = BLACKTEXTCOLOR;
        _connectNameTf.placeholder = @"填写联系人姓名";
        _connectNameTf.textAlignment= NSTextAlignmentRight;
        _connectNameTf.delegate = self;
        _connectNameTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _connectNameTf;
}

- (UITextField *)connectPhoneTf{
    if (!_connectPhoneTf) {
        _connectPhoneTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 150, 45)];
        _connectPhoneTf.font =FONT(12);
        _connectPhoneTf.textColor = BLACKTEXTCOLOR;
        _connectPhoneTf.placeholder = @"填写手机号";
        _connectPhoneTf.delegate = self;
        _connectPhoneTf.textAlignment = NSTextAlignmentRight;
        _connectPhoneTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _connectPhoneTf;
}

- (UITextField *)connectRemarkTf{
    if (!_connectRemarkTf) {
        _connectRemarkTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 150, 45)];
        _connectRemarkTf.font = FONT(12);
        _connectRemarkTf.textColor = BLACKTEXTCOLOR;
        _connectRemarkTf.placeholder = @"填写备注信息";
        _connectRemarkTf.delegate = self;
        _connectRemarkTf.textAlignment = NSTextAlignmentRight;
        _connectRemarkTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _connectRemarkTf;

}

- (STL_PickerView *)datePickView{
    if (!_datePickView) {
        //计算当前年月日
        NSUInteger year = [NSDate jk_year:[NSDate date]];
        NSArray *yearArys = @[[NSString stringWithFormat:@"%ld", year], [NSString stringWithFormat:@"%ld", year+1], [NSString stringWithFormat:@"%ld", year+2]];
        NSUInteger month = [NSDate jk_month:[NSDate date]];
        NSMutableArray *monthArys = [[NSMutableArray alloc] init];
        for (NSInteger i =month; i <= 12; i++) {
            [monthArys addObject:[NSString stringWithFormat:@"%.2ld",i]];
        }
        
        NSUInteger day = [NSDate jk_day:[NSDate date]];
        NSMutableArray *dayArys = [[NSMutableArray alloc] init];
        
        for (NSInteger i =day; i < [NSDate jk_daysInMonth:[NSDate date]]; i++) {
            [dayArys addObject:[NSString stringWithFormat:@"%.2ld",i]];
        }

        _datePickView = [[STL_PickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, 350) title:@"选择日期" ary:@[yearArys, monthArys, dayArys]];
        _datePickView.delegate_1 = self;
    }
    return _datePickView;
}

- (STL_TimePickerView *)timePickView{
    if (!_timePickView) {
        
        NSMutableArray *timeArys = [[NSMutableArray alloc] init];
        NSInteger open = _openTime.integerValue;
        NSInteger close = _endTime.integerValue;
        for (NSInteger i = open; i <= close - _model.serviceHour.integerValue; i++) {
            [timeArys addObject:[NSString stringWithFormat:@"%.2ld:00",i]];
        }
        _timePickView = [[STL_TimePickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, 350) title:@"时间选择" ary:@[timeArys]];
        _timePickView.delegate_1 = self;
    }
    return _timePickView;
}

- (STL_NumPickerView *)numPickView{
    if (!_numPickView) {
        NSMutableArray *timeArys = [[NSMutableArray alloc] init];
        NSInteger open = _model.minMember;
        for (NSInteger i = open; i <= 120; i++) {
            [timeArys addObject:[NSString stringWithFormat:@"%.2ld",i]];
        }
        _numPickView = [[STL_NumPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, 350) title:@"人数选择" ary:@[timeArys]];
        _numPickView.delegate_1 = self;
    }
    return _numPickView;
}


@end
