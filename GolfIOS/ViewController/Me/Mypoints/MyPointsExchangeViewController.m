//
//  MyPointsExchangeViewController.m
//  GolfIOS
//
//  Created by wyao on 16/11/24.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyPointsExchangeViewController.h"
#import "MyPointsViewController.h"
#import "MyPointsFreePlayController.h"

@interface MyPointsExchangeViewController ()

@end

@implementation MyPointsExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"兑换服务";
    self.isAutoBack = YES;
    [self setUI];
}

-(void)setUI{
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.image = IMAGE(@"classify106");
    [self.view addSubview:iconView];
    
    UILabel *label = [UILabel labelWithText:@"恭喜你，成功兑换该服务！\n客服将在第一时间联系你，请耐心等待。" andTextColor:BLACKTEXTCOLOR andFontSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [label sizeToFit];
    [self.view addSubview:label];
    
    UIButton *creatBtn = [[UIButton alloc] init];
    [creatBtn setTitle:@"继续兑换" forState:UIControlStateNormal];
    [creatBtn setBackgroundColor:[UIColor colorWithHex:0x2aa344]];
    [creatBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    creatBtn.titleLabel.font = FONT(15);
    creatBtn.tag = 1;
    [creatBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creatBtn];
    
    
    UIButton *bacKBtn = [[UIButton alloc] init];
    [bacKBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [bacKBtn setBackgroundColor:[UIColor whiteColor]];
    [bacKBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
    bacKBtn.layer.borderColor = [UIColor colorWithHex:0x2aa344].CGColor;
    [bacKBtn.layer setMasksToBounds:YES];
    [bacKBtn.layer setBorderWidth:0.5];
    bacKBtn.titleLabel.font = FONT(15);
    bacKBtn.tag = 2;
    [bacKBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bacKBtn];
    
    
    //布局
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(75 + NaviBar_HEIGHT);
        make.width.offset(166);
        make.height.offset(109);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iconView);
        make.top.equalTo(iconView.mas_bottom).offset(25);
    }];
    
    [creatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(label);
        make.top.equalTo(label.mas_bottom).offset(35);
        make.width.offset(220);
        make.height.offset(45);
    }];
    
    [bacKBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(creatBtn);
        make.top.equalTo(creatBtn.mas_bottom).offset(20);
        make.width.offset(220);
        make.height.offset(45);
    }];
    
    

}

#pragma mark - 创建俱乐部
-(void)BtnClick:(UIButton*)sender{

    if (sender.tag == 1 ) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MyPointsViewController class]]) {
                MyPointsViewController *revise =(MyPointsViewController *)controller;
                [self.navigationController popToViewController:revise animated:YES];
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
