//
//  TSOScoreSelectCourtVC.m
//  GolfIOS
//
//  Created by yangbin on 16/12/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOScoreSelectCourtVC.h"

@interface TSOScoreSelectCourtVC ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation TSOScoreSelectCourtVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"选择球场";
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requedtData];
}
- (void)setupUI{
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    
}

- (void)requedtData{
//    NSDictionary *dict = @{};
    [ShareBusinessManager.appointmentPlaceManager postAppointmentPlaceListWithParameters:nil success:^(id responObject) {
        
        [self.dataList addObjectsFromArray:(NSMutableArray *)responObject];
        [self.tableView reloadData];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

//MARK: - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlaceItemModel *model = self.dataList[indexPath.row];
    if (_selectCourtBlock) {
        _selectCourtBlock(model);
    }
    [SVProgressHUD showWithStatus:@"选择中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
    });
    
}

//MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlaceItemModel *model = self.dataList[indexPath.row];
    AppointPlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
  
    if (cell == nil) {
        cell = [[AppointPlaceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
        cell.model = model;
        [cell hidePriceLabel];
//        [cell.imageView sd_setImageWithURL:FULLIMGURL(model.logoUrl) placeholderImage:Placeholder_small];
//        cell.textLabel.text = model.name;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
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
