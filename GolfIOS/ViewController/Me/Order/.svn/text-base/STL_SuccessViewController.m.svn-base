//
//  STL_SuccessViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/8.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "STL_SuccessViewController.h"

@interface STL_SuccessViewController ()
@property (nonatomic, strong) UIImageView *successIv;

@property (nonatomic, strong) UILabel *successLb;


@property (nonatomic, strong) UILabel *priceLb;



@property (nonatomic, strong) UIButton *appointBtn;

@property (nonatomic, strong) UIButton *lookDetailBtn;


@end

@implementation STL_SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView sd_addSubviews:@[self.successIv, self.successLb, self.priceLb, self.appointBtn, self.lookDetailBtn]];
    [self changeUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _successIv.sd_layout
    .topSpaceToView(self.contentView, 70)
    .centerXEqualToView(self.contentView)
    .heightIs(108.5)
    .widthIs(165);
    
    _successLb.sd_layout
    .topSpaceToView(_successIv, 20)
    .centerXEqualToView(self.contentView)
    .autoHeightRatio(0);
    [_successLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _priceLb.sd_layout
    .topSpaceToView(_successLb, 10)
    .centerXEqualToView(self.contentView)
    .autoHeightRatio(0);
    [_priceLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _appointBtn.sd_layout
    .topSpaceToView(_successLb, 65)
    .leftSpaceToView(self.contentView, 75 *KWidth_Scale)
    .rightSpaceToView(self.contentView, 75 *KWidth_Scale)
    .heightIs(44);
    
    _lookDetailBtn.sd_layout
    .topSpaceToView(_appointBtn, 20)
    .leftSpaceToView(self.contentView, 75 *KWidth_Scale)
    .rightSpaceToView(self.contentView, 75 *KWidth_Scale)
    .heightIs(44);
}

- (void)changeUI{
    switch (_type) {
        case 0:
        {
            self.name = @"支付成功";
            _successLb.text = @"订单支付成功，等待客服确认";
            NSString *text= [NSString stringWithFormat:@"订单金额：¥%@",_orderPrice];//@"订单金额：¥259";
            _priceLb.attributedText = [text attributeStrWithAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} range:NSMakeRange(5, text.length - 5)];
            [_appointBtn setTitle:@"查看订单" forState:UIControlStateNormal];
            [_lookDetailBtn setTitle:@"完成" forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            self.name = @"取消成功";
            _priceLb.text = nil;
            _successLb.text = @"您的订单已成功取消";

            [_appointBtn setTitle:@"预约其他球场" forState:UIControlStateNormal];
            [_lookDetailBtn setTitle:@"查看订单" forState:UIControlStateNormal];

        }
            break;
        case 2:
        {
            self.name = @"使用成功";
            _priceLb.text = nil;
            _successLb.text = @"恭喜您，订单使用成功";
            [_appointBtn setTitle:@"查看订单" forState:UIControlStateNormal];
            [_lookDetailBtn setTitle:@"去评价" forState:UIControlStateNormal];

        }
            break;
        default:
            break;
    }
}

#pragma mark ----------------界面逻辑
- (void)appointElsePlaceAction{
    
    switch (_type) {
        case 0:
        {//查看订单
            OrderDetailViewController *orderDetailVc = [[OrderDetailViewController alloc] init];
            orderDetailVc.orderNo = _orderNo;
            [self.navigationController pushViewController:orderDetailVc animated:YES];
        }
            break;
        case 1:
        {//预订球场
            PlaceAppointViewController *appointVc  = [[PlaceAppointViewController alloc] init];
            [self.navigationController pushViewController:appointVc animated:YES];

        }
            break;
        case 2:
        {//查看订单
            OrderDetailViewController *orderDetailVc = [[OrderDetailViewController alloc] init];
            orderDetailVc.orderNo = _orderNo;
            [self.navigationController pushViewController:orderDetailVc animated:YES];

        }
            break;
        default:
            break;
    }

    
}

- (void)lookForDetailAction{
    switch (_type) {
        case 0:
        {//完成
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
        case 1:
        {//查看订单
            OrderDetailViewController *orderDetailVc = [[OrderDetailViewController alloc] init];
            orderDetailVc.orderNo = _orderNo;
            [self.navigationController pushViewController:orderDetailVc animated:YES];
        }
            break;
        case 2:
        {//去评价
            OrderCommentViewController *commentVc = [[OrderCommentViewController alloc] init];
            commentVc.orderNo = _orderNo;
            [self.navigationController pushViewController:commentVc animated:YES];
        }
            break;
        default:
            break;
    }

}


#pragma mark ----------------实例化

- (UILabel *)successLb{
    if (!_successLb) {
        _successLb = [[UILabel alloc] init];
        _successLb.font = FONT(18);
        _successLb.textColor = BLACKTEXTCOLOR;
        _successLb.text = @"订单支付成功，等待客服确认";
    }
    return _successLb;
}

- (UIImageView *)successIv{
    if (!_successIv) {
        _successIv = [[UIImageView alloc] init];
        _successIv.image = IMAGE(@"classify106");
    }
    return _successIv;
}

- (UIButton *)appointBtn{
    if (!_appointBtn) {
        _appointBtn = [[UIButton alloc] init];
        _appointBtn.backgroundColor = GLOBALCOLOR;
        _appointBtn.titleLabel.font = FONT(14);
        _appointBtn.layer.cornerRadius = 5;
        [_appointBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_appointBtn addTarget:self action:@selector(appointElsePlaceAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appointBtn;
}

- (UIButton *)lookDetailBtn{
    if (!_lookDetailBtn) {
        _lookDetailBtn = [[UIButton alloc] init];
        _lookDetailBtn.backgroundColor = WHITECOLOR;
        _lookDetailBtn.layer.borderColor = GLOBALCOLOR.CGColor;
        _lookDetailBtn.layer.borderWidth = 1;
        _lookDetailBtn.layer.cornerRadius = 5;
        _lookDetailBtn.titleLabel.font = FONT(14);
        [_lookDetailBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [_lookDetailBtn addTarget:self action:@selector(lookForDetailAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookDetailBtn;
}


- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.font = FONT(15);
        _priceLb.textColor = LIGHTTEXTCOLOR;
    }
    return _priceLb;
}
@end
