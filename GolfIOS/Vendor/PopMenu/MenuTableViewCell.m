//
//  MenuTableViewCell.m
//  PopMenuTableView
//
//  Created by yy on 16/8/2.
//  Copyright © 2016年 KongPro. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(8, self.bounds.size.height - 1, self.bounds.size.width * 0.4, 0.5)];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BACKGROUNDCOLOR;
    [self.contentView addSubview:lineView];
    lineView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .bottomEqualToView(self.contentView)
    .heightIs(0.5);
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textColor = GLOBALCOLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}

- (void)setMenuModel:(MenuModel *)menuModel{
    _menuModel = menuModel;
    self.imageView.image = [UIImage imageNamed:menuModel.imageName];
    NSString *text = [NSString stringWithFormat:@"     %@",menuModel.itemName];
    self.textLabel.text = text;
}


@end
