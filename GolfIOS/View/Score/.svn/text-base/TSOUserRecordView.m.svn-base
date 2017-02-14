//
//  TSOUserRecordView.m
//  GolfIOS
//
//  Created by yangbin on 16/11/15.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOUserRecordView.h"

@interface  TSOUserRecordView()

/**杆数labelArr*/
@property (nonatomic, strong) NSMutableArray *labelArray;
/**推杆数LabelArr*/
@property (nonatomic, strong) NSMutableArray *pushLabelArray;

/**coverArr*/
@property (nonatomic, strong) NSMutableArray *coverArray;

@end


#define recordwidth ((SCREEN_HEIGHT * 0.9) - 100) / 19
#define recordHeight SCREEN_WIDTH * 0.1


@implementation TSOUserRecordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    return self;
}



- (void)setupUI{
    
    for (int i = 0; i < 21; i++) {
        UILabel *label = [[UILabel alloc] init];
        UIView *cover = [[UIView alloc] init];
        UILabel *pushLabel = [[UILabel alloc] init];
        cover.size = CGSizeMake(recordHeight *0.5, recordHeight* 0.5);
        
        cover.layer.masksToBounds = YES;
        cover.layer.cornerRadius = recordHeight * 0.25;
        cover.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        pushLabel.textAlignment = NSTextAlignmentCenter;
        
        if (i == 20) {
            label.frame = CGRectMake(i * recordwidth + 10, 0, recordwidth, recordHeight);
            cover.center = label.center;
        }else{
            
            label.frame = CGRectMake((i * recordwidth), 0, recordwidth, recordHeight);
            cover.center = label.center;
        }
        [self addSubview:cover];
        [self addSubview:label];
        [label addSubview:pushLabel];
        
        pushLabel.sd_layout
        .topSpaceToView(label, 3)
        .rightSpaceToView(label, 3)
        .autoHeightRatio(0);
        [pushLabel setSingleLineAutoResizeWithMaxWidth:30];
        
        
        
        label.font = FONT(12);
        pushLabel.font = FONT(8);
        [self.labelArray addObject:label];
        [self.coverArray addObject:cover];
        [self.pushLabelArray addObject:pushLabel];
    }
    
    
    
    
    
}

- (void)setPushScoreArr:(NSMutableArray *)pushScoreArr{
    _pushScoreArr = pushScoreArr;
    
    [_pushLabelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = (UILabel *)obj;
        NSNumber *pushScore = (NSNumber *)_pushScoreArr[idx];
        label.text = [NSString stringWithFormat:@"%@",pushScore];
    }];
}

- (void)setUserScoreArr:(NSMutableArray *)userScoreArr{
    _userScoreArr = userScoreArr;
    
//    UIColor *laoying = [UIColor colorWithRed:225/255.0 green:169/255.0 blue:88/255.0 alpha:1];
//    UIColor *xiaoniao = [UIColor colorWithRed:228/255.0 green:98/255.0 blue:114/255.0 alpha:1];
//    UIColor *biaozhun = [UIColor colorWithRed:46/255.0 green:179/255.0 blue:168/255.0 alpha:1];
//    UIColor *baiji = [UIColor colorWithRed:80/255.0 green:143/255.0 blue:220/255.0 alpha:1];
//    UIColor *shuangbai = [UIColor colorWithRed:80/255.0 green:95/255.0 blue:236/255.0 alpha:1];
    [_labelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *label = (UILabel *)obj;
        NSNumber *score = (NSNumber *)_userScoreArr[idx];
        NSNumber *standardNum = (NSNumber *)_standScoreArr[idx];
        UIView *cover = _coverArray[idx];
//        UIView *cover = [[UIView alloc] init];
//        cover.size = CGSizeMake(recordHeight *0.5, recordHeight* 0.5);
//        cover.center = CGPointMake(recordwidth * 0.5, recordHeight * 0.5);
//        cover.layer.masksToBounds = YES;
//        cover.layer.cornerRadius = recordHeight * 0.25;
////        label.textColor = WHITECOLOR;
        label.textColor = WHITECOLOR;
        
//        NSInteger point = score.integerValue - standardNum.integerValue;
        
//        cover.backgroundColor = [UIColor whiteColor];
        label.textColor = BLACKCOLOR;
//        if (score.integerValue >0) {
//            if (point <= -2) {
//                cover.backgroundColor = laoying;
//            }else if (point <= -1 ){
//                cover.backgroundColor = xiaoniao;
//            }else if (point <= 0){
//                cover.backgroundColor = biaozhun;
//            }else if (point <= 1){
//                cover.backgroundColor = baiji;
//            }else if (point <= 2){
//                cover.backgroundColor = shuangbai;
//            }else{
//                label.textColor = BLACKCOLOR;
//            }
//        }
        
        if (score.integerValue == 0 && idx != 9 && idx != 19 && idx != 20) {
            label.hidden = YES;
           
        }

        if (idx == 9 || idx == 19 || idx == 20) {
            label.textColor = BLACKCOLOR;
            cover.backgroundColor = [UIColor clearColor];
        }
        label.text = [NSString stringWithFormat:@"%@",score];
        
    }];
}


- (NSMutableArray *)labelArray{
    if (_labelArray == nil) {
        _labelArray = [[NSMutableArray alloc] init];
    }
    return _labelArray;
}

- (NSMutableArray *)coverArray{
    if (_coverArray == nil) {
        _coverArray = [[NSMutableArray alloc] init];
    }
    return _coverArray;
}

- (NSMutableArray *)pushLabelArray{
    if (_pushLabelArray == nil) {
        _pushLabelArray = [[NSMutableArray alloc] init];
    }
    return _pushLabelArray;
}

@end
