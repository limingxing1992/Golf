//
//  GolfConstant.h
//  GolfIOS
//
//  Created by 张永亮 on 2016/10/24.
//  Copyright © 2016年 zzz. All rights reserved.
//

#ifndef GolfConstant_h
#define GolfConstant_h

//API
#define RealAPI @"http://115.236.69.110:8460/golfMain/"//正式服务器
#define HostAPI @"http://115.236.69.110:8505/golfMain/"//吴德友
#define TestAPI_0 @"http://115.236.69.110:8458/golfMain/"//杨星
#define TestAPI_1 @"http://192.168.18.181:8080/golfMain/"//万栋

/*3
 宏定义单例化BusinessManager
 */
#define ShareBusinessManager [BusinessManager shareBusinessManager]
/*
 弱引用
 */
#define GOLFWeakObj(type) __weak typeof(type) weak##type = type;
/*
 内部版本号
 */
#define GOLF_VERSION  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/*
 发布版本号
 */
#define GOLF_VERSIONString  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/**
 日志打印
 */
//DEBUG 模式下打印日志,当前行
#ifdef DEBUG
# define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define NSLog(...)
#endif
/*
 获取系统版本号
 */
#define Device_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
/*
 获取屏幕宽度与高度
 */
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//相对iphone6 屏幕宽度比
#define KWidth_Scale    [UIScreen mainScreen].bounds.size.width/375.0f
//相对iPhone6 屏幕高度比
#define KHeight_Scale [UIScreen mainScreen].bounds.size.height/667.0f

/*
 获取通知中心
 */
#define GOLFNotificationCenter [NSNotificationCenter defaultCenter]
/* 
 获取缓存
 */
#define GOLFUserDefault [NSUserDefaults standardUserDefaults]
/*
 读取图片 
 */
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
#define IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
/*
 当前view宽高
 */
#define WIDTH_CELL self.frame.size.width
#define HEIGHT_CELL self.frame.size.height
#define STL_ORIGIN_X        self.frame.origin.x                             //坐标X
#define STL_ORIGIN_Y        self.frame.origin.y                             //坐标Y
#define PAGESIZE @10        //每页获取数据数量宏
#define NaviBar_HEIGHT 64   //获取导航栏高度(包括状态栏高度20)
#define TabBar_HEIGHT 49    //获取标签栏高度
/** 
 占位图
 */
#define Placeholder_small   IMAGE(@"placeholder60")
#define Placeholder_middle  IMAGE(@"placeholder130")
#define Placeholder_big IMAGE(@"placeholder750")
#define EmptyImage IMAGE(@"empty")
/** 经纬度*/
#define LongTi     [GOLFUserDefault objectForKey:@"longti"];
#define LatTi      [GOLFUserDefault objectForKey:@"latti"];
#define AreaID     [GOLFUserDefault objectForKey:@"areaId"];
/** 
 个人中心宏
 */
//是否登录（BOOL）
#define IsLogin  [UserModel sharedUserModel].isLogin
//登录导航控制器
#define LoginNavi [STL_CommonIdea loginNavi]
//根据个人会员排序等级获取当前等级对应图标
#define GetLevelImg(sort)     [STL_CommonIdea levelImageWithSort:(sort)]
//拼接服务器返回路径的全路径
#define FULLIMGURL(url) [YB_Tools fullPicUrl:(url)]

/**
 颜色
 */
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define ClearColor [UIColor clearColor]  //清除背景色
#define BACKGROUNDCOLOR RGBColor(240, 240, 240)//背景色 f0f0f0
#define WHITECOLOR [UIColor whiteColor]//-- 白色
#define BLACKCOLOR [UIColor blackColor]//-黑色
#define BLACKTEXTCOLOR RGBColor(51, 51, 51)//-黑色///33333
#define SHENTEXTCOLOR RGBColor(102, 102, 102)//深色/666666
#define LIGHTTEXTCOLOR RGBColor(153, 153, 153)//灰色///999999
#define GRAYCOLOR RGBColor(230, 230, 230)//---浅色//e6e6e6、/切割线色
#define GLOBALCOLOR RGBColor(27,158,106)//绿色///
#define OrangeCOLOR RGBColor(252,84,0)//橘色、价格数据颜色

/** 
 字体
 */
#define FONT(F)  [UIFont systemFontOfSize:F]
/**
 block循环引用
 */
#define weak(self)   __weak typeof (self) weakSelf = self;


#define WXAppID @"wx7a25750ee0abd6de"
#define WXSercret @"27d0c3fa98b4d7b2b1b4ce93ccd3d88d"

#endif /* GolfConstant_h */
