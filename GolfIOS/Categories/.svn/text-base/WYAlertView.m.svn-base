

#import "WYAlertView.h"
///alertView  宽
#define AlertW 297
#define AlertH 145
///按钮的  高
#define BtnH 50.0
///各个栏目之间的距离
#define WYSpace 20.0

/**
 block循环引用
 */
#define weak(self)   __weak typeof (self) weakSelf = self;

@interface WYAlertView()
//弹窗
@property (nonatomic,strong) UIView *alertView;
//title
@property (nonatomic,strong) UILabel *titleLbl;
//内容
@property (nonatomic,strong) UILabel *msgLbl;
//确认按钮
@property (nonatomic,strong) UIButton *rightBtn;
//取消按钮
@property (nonatomic,strong) UIButton *leftBtn;
//横线
@property (nonatomic,strong) UIView *lineView;
//竖线
@property (nonatomic,strong) UIView *verLineView;

@end

@implementation WYAlertView

- (instancetype)initWithTitle:(NSString *)title
                    titleFont:(CGFloat)titleFont
                    titleBold:(BOOL)titleIsBold
                    titleColor:(UIColor*)titleColor
                    message:(NSString *)message
                    messageFont:(CGFloat)messageFont
                    messageBold:(BOOL)messageIsBold
                    messageColor:(UIColor*)messageColor
                    rightBtn:(NSString *)rightTitle
                    rightBtnTitleColor:(UIColor *)rightBtnTitleColor
                    rightBtnTitleFont:(CGFloat)rightBtnTitleFont
                    leftBtn:(NSString *)leftTitle
                    leftBtnTitleColor:(UIColor *)leftBtnTitleColor
                    leftBtnTitleFont:(CGFloat)leftBtnTitleFont
{
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
        
        //设置alertView属性
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
        self.alertView.frame = CGRectMake(0, 0, AlertW, AlertH);
        self.alertView.layer.position = self.center;
        

        if (title) {
            
            CGRect rect = CGRectMake(2*WYSpace, WYSpace, AlertW - 4*WYSpace, titleFont);
            self.titleLbl = [self GetAdaptiveLable:rect  AndText:title titleFont:titleFont titleBold:titleIsBold titleColor:titleColor];
            [self.alertView addSubview:self.titleLbl];
            CGFloat titleW = self.titleLbl.bounds.size.width;
            CGFloat titleH = self.titleLbl.bounds.size.height;
            self.titleLbl.frame = CGRectMake((AlertW-titleW)/2, 2*WYSpace, titleW, titleH);
            
        }
        if (message) {
            
            CGRect rect = CGRectMake(WYSpace, CGRectGetMaxY(self.titleLbl.frame) + WYSpace, AlertW-2*WYSpace, messageFont);
            self.msgLbl = [self GetAdaptiveLable:rect AndText:message titleFont:messageFont titleBold:messageIsBold titleColor:messageColor];
            [self.alertView addSubview:self.msgLbl];
            CGFloat msgW = self.msgLbl.bounds.size.width;
            CGFloat msgH = self.msgLbl.bounds.size.height;
            self.msgLbl.frame = self.titleLbl ? CGRectMake((AlertW-msgW)/2, CGRectGetMaxY(self.titleLbl.frame)+WYSpace, msgW, msgH): CGRectMake((AlertW-msgW)/2, WYSpace, msgW, msgH);
        }
        
        //两个按钮
        if (leftTitle && rightTitle) {
            
            [self addLine];
            
            CGRect leftRect = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2, BtnH);
            [self addleftBtnWith:leftTitle titleColor:leftBtnTitleColor titleFont:leftBtnTitleFont rect:leftRect];
            
            
            [self addVerLine];
            
            
             CGRect rightRect = CGRectMake(CGRectGetMaxX(self.verLineView.frame), CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2+1, BtnH);
            [self addrightBtnWith:rightTitle titleColor:rightBtnTitleColor titleFont:rightBtnTitleFont rect:rightRect];
        }

        //只有左边按钮
        if (leftTitle && !rightTitle) {
            
            [self addLine];
            CGRect leftRect = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, BtnH);
            [self addleftBtnWith:leftTitle titleColor:leftBtnTitleColor titleFont:leftBtnTitleFont rect:leftRect];

        
        }
        
        //只有右边按钮
        if(rightTitle && !leftTitle){
            
            [self addLine];
            CGRect rightRect = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, BtnH);
            [self addrightBtnWith:rightTitle titleColor:rightBtnTitleColor titleFont:rightBtnTitleFont rect:rightRect];
            [self.alertView addSubview:self.rightBtn];
        }
        
        //计算高度
        CGFloat alertHeight ;
        //只要存在一个按钮
        if (leftTitle || rightTitle) {
            
             alertHeight = leftTitle ? CGRectGetMaxY(self.leftBtn.frame) : CGRectGetMaxY(self.rightBtn.frame);
            
        }else{
            
            if (message) {
                
                alertHeight = CGRectGetMaxY(self.msgLbl.frame) + WYSpace;
            }else{
                alertHeight = CGRectGetMaxY(self.titleLbl.frame) + WYSpace;
            }
         
            //延迟移除所有视图
            weak(self);
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0* NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [weakSelf removeFromSuperview];
            });

        }
        
        
        self.alertView.frame = CGRectMake(0, 0, AlertW, alertHeight);
        self.alertView.layer.position = self.center;
        [self addSubview:self.alertView];
    }
    
    return self;
}


#pragma mark - 弹出的动画设置
- (void)showAlertView:(void (^)(NSInteger index))completion
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    
    
    //动画设置
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    self.resultIndex = ^(NSInteger index){
        completion(index);
    };
    
}



#pragma mark - 点击事件的回调
- (void)buttonEvent:(UIButton *)sender
{
    weak(self);
    if (weakSelf.resultIndex) {
        weakSelf.resultIndex(sender.tag);
        }
    
    [self removeFromSuperview];
}



/**
 添加横线（当且仅当两个按钮都存在时候）
 */
-(void)addLine{
    //横线
    self.lineView = [[UIView alloc] init];
    if (self.msgLbl) {
        
        self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.msgLbl.frame) + WYSpace, AlertW, 1);
        
    }else {
        //判断titleLbl存不存在
        if (self.titleLbl) {
            self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLbl.frame) + WYSpace, AlertW, 1);
        }else{
            self.lineView.frame = CGRectZero;
        }
        
    }
    self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
    [self.alertView addSubview:self.lineView];
    

}

/**
 添加竖线（当且仅当两个按钮都存在时候，先添加Btn1）
 */
-(void)addVerLine{
    
    self.verLineView = [[UIView alloc] init];
    self.verLineView.frame = CGRectMake(CGRectGetMaxX(self.leftBtn.frame), CGRectGetMaxY(self.lineView.frame), 1, BtnH);
    self.verLineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
    [self.alertView addSubview:self.verLineView];
}


/**
 添加左侧按钮
 @param title 按钮文字
 */
-(void)addleftBtnWith:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(CGFloat)titleFont rect:(CGRect)rect{
    
    [self.alertView addSubview:self.leftBtn];
    self.leftBtn.frame = rect;
    [self.leftBtn setTitle:title forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:titleColor forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:titleFont];
}

/**
 添加右侧按钮
 @param title 按钮文字
 */
-(void)addrightBtnWith:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(CGFloat)titleFont rect:(CGRect)rect{
    
    [self.alertView addSubview:self.rightBtn];
    self.rightBtn.frame = rect;
    [self.rightBtn setTitle:title forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:titleColor forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:titleFont];
}

/**
 根据传入的字体frame自动设置

 @param rect 标题的rect
 @param contentStr 标题内容
 @param titleFont 标题字体
 @param titleIsBold 标题是否加粗（YES：加粗显示; NO:正常显示）
 @param titleColor 标题颜色
 @return 标题
 */
-(UILabel *)GetAdaptiveLable:(CGRect)rect
                     AndText:(NSString *)contentStr
                   titleFont:(CGFloat)titleFont
                   titleBold:(BOOL)titleIsBold
                   titleColor:(UIColor*)titleColor
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    contentLbl.textColor = titleColor;
    if (titleIsBold) {
        //加粗字体
        contentLbl.font = [UIFont boldSystemFontOfSize:titleFont];
    }else{
        //系统字体
        contentLbl.font = [UIFont systemFontOfSize:titleFont];
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    //自动换行
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    //行间距为3
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    [contentLbl setAttributedText:mAttrStr];
    [contentLbl sizeToFit];
    
    
    return contentLbl;
}



#pragma mark - 懒加载控件

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn= [UIButton buttonWithType:UIButtonTypeSystem];
        _rightBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, BtnH);
        [_rightBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        _rightBtn.tag = 2;
        [_rightBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_rightBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _rightBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        _rightBtn.layer.mask = maskLayer;
    }
    return _rightBtn;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn= [UIButton buttonWithType:UIButtonTypeSystem];
        _leftBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, BtnH);
        [_leftBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
        [_leftBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        _leftBtn.tag = 1;
        [_leftBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_leftBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _leftBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        _leftBtn.layer.mask = maskLayer;

    }
    return _leftBtn;
}

-(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
