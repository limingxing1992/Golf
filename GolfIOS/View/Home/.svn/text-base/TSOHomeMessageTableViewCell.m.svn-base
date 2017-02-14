//
//  TSOHomeMessageTableViewCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/1.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOHomeMessageTableViewCell.h"
#import "UIImage+Image.h"
#import "CCPScrollView.h"
#import "HomeInfoModel.h"

@interface TSOHomeMessageTableViewCell ()<SDCycleScrollViewDelegate>

/**我的动态*/
@property (nonatomic, strong) UIImageView *statusImageView;
/**滚动信息*/
@property (nonatomic, strong) CCPScrollView *scrollMessageView;


@end

@implementation TSOHomeMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.backgroundColor = WHITECOLOR;
    [self.contentView addSubview:self.statusImageView];

    self.scrollMessageView = [[CCPScrollView alloc] initWithFrame:CGRectMake(60, 5, 150, 16)];
    self.scrollMessageView.centerY = self.statusImageView.centerY;

    [self.contentView addSubview:self.scrollMessageView];

}

- (void)setModel:(HomeInfoModel *)model{
    _model = model;
    
    NSMutableArray *orderTitleArr = [[NSMutableArray alloc] init];
    for (HomeOrderModel *model in _model.data.indexOrderListInfo) {
//        NSString * message = [model.orderNo stringByAppendingString:[NSString stringWithFormat:@" %@",model.handleMessage]];
//        NSLog(@"=======%@",message);
        [orderTitleArr addObject:model.handleMessage];
    }
    
    if (orderTitleArr.count == 0) {
        self.statusImageView.hidden = YES;
        self.scrollMessageView.hidden = YES;
    }else{
        self.statusImageView.hidden = NO;
        self.scrollMessageView.hidden = NO;
        self.scrollMessageView.titleArray = orderTitleArr;
        self.scrollMessageView.titleFont = 12;
        self.scrollMessageView.titleColor = SHENTEXTCOLOR;
        [self.scrollMessageView clickTitleLabel:^(NSInteger index, NSString *titleString) {
            if ([self.delegate respondsToSelector:@selector(homeMessageTableViewCellMessageDidClick:)]) {
        
                HomeOrderModel *orderModel = _model.data.indexOrderListInfo[index - 100];
                [self.delegate homeMessageTableViewCellMessageDidClick:orderModel.orderNo];
            }
        }];
    }
    
    
}

- (UIImageView *)statusImageView{
    if (_statusImageView == nil) {
        _statusImageView = [[UIImageView alloc] init];
        _statusImageView.frame = CGRectMake(15, 2, 60, 14);
        _statusImageView.image = IMAGE(@"classify217");
        
    }
    return _statusImageView;
}

@end
