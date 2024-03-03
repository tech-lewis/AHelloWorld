// Author: Tang Qiao
// Date:   2012-3-2
//
// The macro is inspired from:
//     http://www.yifeiyang.net/iphone-development-skills-of-the-debugging-chapter-2-save-the-log/

#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#endif
// 浏览器
#define DIVIDER_HEIGHT 4.0
#define BUTTON_SIZE_W 72
#define BUTTON_SIZE_H 56
#define DIVIDER_COLOR [UIColor colorWithRed:255.0/255.0 green:149.0/255.0 blue:0.0 alpha:1.0]

#ifdef DEBUG

#else
#define NSLog(format, args...)
#endif

// 获得颜色
#define kGetColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

// 全局统一背景
#define kGlobalBg kGetColor(230, 230, 230)
//国际化
#define LocalizedString(key) \
[[InternationalControl bundle] localizedStringForKey:(key) value:nil table:@"Localizable"]

#define STR(key)            NSLocalizedString(key, nil)

//文件路径
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//iphone尺寸
#define PHOTOWIDTH  ([[UIScreen mainScreen] bounds].size.width > [[UIScreen mainScreen] bounds].size.height ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
//#define PHOTOHEIGHT ([[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define PHOTOHEIGHT ([[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height ? [[UIScreen mainScreen] bounds].size.width : 320)

//设置颜色更方便
#define color_with_rgba(r,g,b,a) [[UIColor alloc] initWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define color_with_rgb(r,g,b) [[UIColor alloc] initWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define systemBlueColor color_with_rgb(0, 105, 255)

//ios系统
#define is_ios5 ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0)
#define is_ios6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
#define is_ios7 ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
#define is_ios8 ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0)
#define is_ios9 ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0)
#define is_ios10 ([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0)
#define is_ios11 ([[[UIDevice currentDevice] systemVersion] floatValue] < 12.0)
#define is_ios12 ([[[UIDevice currentDevice] systemVersion] floatValue] < 13.0)
#define is_ios13 ([[[UIDevice currentDevice] systemVersion] floatValue] < 14.0)
#define is_ios14 ([[[UIDevice currentDevice] systemVersion] floatValue] < 15.0)
// #define is_ios15below ([[[UIDevice currentDevice] systemVersion] floatValue] < 15.0)
//16进制颜色转换
#define COLOR_RGB_16BIT(rgb) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgb & 0xFF00) >> 8)) / 255.0 \
blue:((float)((rgb & 0xFF))) / 255.0 \
alpha:1.0]

//简单弹窗显示
#define SHOW_ALERT(title,msg,cancelTitle) [[[UIAlertView alloc] initWithTitle:(title) \
message:(msg) \
delegate:nil \
cancelButtonTitle:(cancelTitle) \
otherButtonTitles:nil] show]



#define APPDEBUG NO

// 暂停方向控制的连续性
#define NOTI_StopControllerTimer @"NOTI_StopControllerTimer"
// 到达某一层 object：NSNumber
#define NOTI_RunToFloor @"NOTI_RunToFloor"
#define KDefaultUrlString @"https://so.toutiao.com/s/search_feed/?need_open_window=1&show_middle_page=1&W2atIF=1"


/** 颜色转换  例：#000000 UIColorFromRGB(0x000000) */
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define KBrowserCurrentURLKey @"KBrowserCurrentURL"
// 刘海屏判断
// #define iPhoneXorNewModel ({ \ BOOL iPhoneX = NO; \ if (@available(iOS 11.0, *)) { \ if ([UIApplication sharedApplication].windows[0].safeAreaInsets.bottom > 0) { \ iPhoneX = YES; \ } \ } \ iPhoneX; \ return iPhoneX;})
//获取屏幕 宽度、高度
#define CurrentScreen_Width ([UIScreen mainScreen].bounds.size.width)
#define CurrentScreen_Height ([UIScreen mainScreen].bounds.size.height)

#define CurrentAppThemeColor RGB(0,78,162)

//contentheight
#define ContentHeight    CurrentScreen_Height-64-50
//获取appDelegate

#define CurrentAppDelegate   (AppDelegate *)[[UIApplication sharedApplication] delegate];

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define RGBOnly(color) RGB(color,color,color)
#define RandomColor  RGB(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))
#define BackgroupColorR(v)   (v).backgroundColor=[UIColor redColor];
#define BackgroupColorY(v)   (v).backgroundColor=[UIColor colorWithRed:1.000 green:0.900 blue:0.240 alpha:1.000];

#define StringNoNull(str) StringIsEmpty(str)?@"":str

#define StringEmptyAlert(str,msg)\
if (StringIsEmpty(str)) {\
[MBProgressHUD showMessage:msg toView:self.view];\
return;\
}

#define ConditionAlert(condition,msg)\
if (condition) {\
[MBProgressHUD showMessage:msg toView:nil];\
return;\
}

#define IfConditionAlert(condition,msg)\
if(condition){\
    [MBProgressHUD showMessage:msg toView:self.view];\
}

#define ElseIfConditionAlert(condition,msg)\
else if(condition){\
[MBProgressHUD showMessage:msg toView:self.view];\
}

#define ShowProgressHUD(msg) [MBProgressHUD showMessage:msg toView:self.view];

//判断有没有网络
#define  SDIsNetWork() \
if(![SDSingletonTool shared].isNetWork&&[SDSingletonTool shared].isMonitored)\
{\
    [MBProgressHUD showMessage:@"没有网络" toView:nil];\
    return;\
}\

#define  ShowNetWorkLoadingWichtoView() \
if (shouldShowHud) {\
[MBProgressHUD showNetWorkLoadingWichtoVC:viewController WithActionBlock:reloadBlock];\
}




//---------颜色
#define navigationBarColor  RGB(0, 78, 162)
#define txtPlaceholderColor  RGB(150,153, 153)
#define tableViewBgColor  RGB(244, 244, 245)


//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
//Application 实例化
#define Application        [UIApplication sharedApplication]
//NotificationCenter 实例化
#define NotificationCenter [NSNotificationCenter defaultCenter]


//获取沙盒Document路径
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define TempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]



// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

// View 坐标(x,y)和宽高(width,height)
#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)



//弱引用
#define WeakSelf(type)   __weak typeof(type) weak##type = type;
#define WeakSelfs __weak __typeof(&*self)


//强引用
#define StrongSelf(type) __strong typeof(type) type = weak##type;



//字符串是否为空
#define StringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define ArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define DictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define ObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

// SDLog
#ifdef DEBUG
#define SDLog(FORMAT, ...) fprintf(stderr,"时间:%s 行号:%d 文件名:%s\t方法名:%s\n%s\n", __TIME__,__LINE__,[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__func__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(FORMAT, ...) nil
#endif


//打印View的frame
#define SDLogViewFrame(v) SDLog(@"%@",NSStringFromCGRect((v).frame))


//-------------------userDefault Key-------------------
//  userInfo
#define  UserInfo_Path     [CachePath stringByAppendingPathComponent:@"UserInfo.archiver"]





//--------------------当前系统----------------------
//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7  (IOS_VERSION>=7.0)
#define IOS8  (IOS_VERSION>=8.0)
#define IOS9  (IOS_VERSION>=9.0)

//-------------------------提示语-------------------------
#define  netWorkError  @"哎呀,服务器升天了,稍后再试吧"
#define  NoNetWork  @"当前没有网络,请检查网络状态"
#define  UserIDGQ   @"登录超时，请重新登录"
#define  UserNotLogin   @"您还没有登录哦！"


// @interface
#define singleton_interface(className)\
+ (className *)shared##className;

// @implementation
#define singleton_implementation(className)\
static className *_instance;\
+ (id)allocWithZone:(NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
} \
+ (className *)shared##className\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance; \
}

