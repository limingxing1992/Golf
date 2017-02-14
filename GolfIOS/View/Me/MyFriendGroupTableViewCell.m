//
//  MyFriendGroupTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/21.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyFriendGroupTableViewCell.h"
#import "StitchingImage.h"

@interface MyFriendGroupTableViewCell ()

/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;

/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;

/** 名字。最多显示5个*/
@property (nonatomic, strong) UILabel *nameLb;



@end

@implementation MyFriendGroupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = WHITECOLOR;
        [self.contentView sd_addSubviews:@[self.headIv, self.titleLb, self.nameLb]];
        [self autoLayoutSubViews];
    }
    return self;
}

/** 自动布局*/
- (void)autoLayoutSubViews{

    _headIv.frame = CGRectMake(15, 14, 40, 40);
    _headIv.layer.cornerRadius = 3;
    _headIv.clipsToBounds = YES;
    
    _titleLb.sd_layout
    .topEqualToView(_headIv)
    .leftSpaceToView(_headIv, 5)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    _nameLb.sd_layout
    .bottomEqualToView(_headIv)
    .leftSpaceToView(_headIv, 5)
    .rightSpaceToView(self.contentView, 5)
    .autoHeightRatio(0);
    
}

#pragma mark ----------------界面刷新

- (void)setModel:(FriendGroupItemModel *)model{
    _model = model;
    NSMutableArray *imgs = [[NSMutableArray alloc] init];//图片路径数组
    NSMutableString *name = [[NSMutableString alloc] init];//名字数组
    NSArray *groupList = model.groupMemberList;
    for (FriendUserModel *itemModel in groupList) {
        if (itemModel.headUrl.length) {
            [imgs addObject:itemModel.headUrl];
        }else{
            [imgs addObject:@"1"];
        }
        if (itemModel.nickName.length) {
            [name appendFormat:@"%@，",itemModel.nickName];
        }else{
            [name appendFormat:@"%@，", itemModel.userName];
        }
    }
    if (!imgs.count) {
        [imgs addObject:@"1"];
    }
    
    NSString *title = [NSString stringWithFormat:@"%@（%ld）",model.groupName,model.groupCount];
    
    [self updateWithImages:imgs name:name title:title];
    
}

- (void)updateWithImages:(NSArray *)images name:(NSString *)name title:(NSString *)title{
    
    [self createImageViewWithCanvasView:_headIv withImages:images];
    if (name) {
        _nameLb.text = name;
    }
    if (title) {
        _titleLb.text = title;
    }
}
/** 制作群组头像*/
- (UIImageView *)createImageViewWithCanvasView:(UIImageView *)canvasView withImages:(NSArray *)images {
    NSMutableArray *imageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        if ([images[i] isEqualToString:@"1"]) {
            imageView.image = Placeholder_small;
        }else{
            [imageView sd_setImageWithURL:FULLIMGURL(images[i]) placeholderImage:Placeholder_small];
        }
        [imageViews addObject:imageView];
    }
    return [[StitchingImage alloc] stitchingOnImageView:canvasView withImageViews:imageViews marginValue:0];
}

#pragma mark ----------------实例

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.backgroundColor = RGBColor(200, 200, 200);
    }
    return _headIv;
}


- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(14);
        _nameLb.textColor = LIGHTTEXTCOLOR;
        _nameLb.text = @"新的";
    }
    return _nameLb;
}


- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(14);
        _titleLb.textColor = BLACKTEXTCOLOR;
        _titleLb.text = @"家人（0）";
    }
    return _titleLb;
}

@end
