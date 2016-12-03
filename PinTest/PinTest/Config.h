//
//  Config.h
//  user
//
//  Created by wangshuaipeng on 16/9/7.
//  Copyright © 2016年 Mac－pro. All rights reserved.
//

#ifndef Config_h
#define Config_h

#import "TimeTest.h"

#define objc_exchangeMethodAToB(methodA,methodB) method_exchangeImplementations(class_getInstanceMethod([self class], methodA),class_getInstanceMethod([self class], methodB));
#define objc_setObjRETAIN(key,value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)

#define objc_getObj(key) objc_getAssociatedObject(self, key)

//是否展示FPS
#define showFPSStatus YES

///执行block
#define blockExecute(block, ...) if (block) { block(__VA_ARGS__); };

///随机数据
#define randomDataStr [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

///通知中心
#define notificationCenter [NSNotificationCenter defaultCenter]

///偏好设置
//#define userDefaultsStandard [NSUserDefaults standardUserDefaults]

///强弱引用
#define WWWeakSelf __weak typeof(self) weakSelf = self;
#define WWStrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;

///自定义色
#define color_custom(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

///屏幕宽高
#define ScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight   [[UIScreen mainScreen] bounds].size.height

///随机色
#define color_random hcbRandomColor(arc4random_uniform(255.0),arc4random_uniform(255.0),arc4random_uniform(255.0))

///系统版本
#define iOS_Version [[UIDevice currentDevice] systemVersion].floatValue
#define systemVersionGreaterThanOrEqulaTo(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//导航和Tab高度
#define navHeight 64
#define tabBarHeight 49

///dispatch main
#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
    block();\
} else {\
    dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
    if ([NSThread isMainThread]) {\
    block();\
} else {\
    dispatch_async(dispatch_get_main_queue(), block);\
}


///打印
#if DEBUG
    #define DFLog(FORMAT, ...) fprintf(stderr,"%s,%d行💙%s💙\n",[[NSString stringWithUTF8String:__FILE__] lastPathComponent].UTF8String, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
    #define NSLog(...) NSLog(__VA_ARGS__)
#else
    #define DFLog(FORMAT, ...) nil
    #define NSLog(...)
#endif

///指定的打印
#ifdef DEBUG
    #define debugMethod();     DFLog(@"%s", __func__);
    #define debugThread();     DFLog(@"%@",[NSThread currentThread]);
    #define debugLibraryLog(); DFLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]);
#else
    #define debugMethod();  nil
    #define debugThread();     nil
    #define debugLibraryLog(); nil
#endif


#endif /* Config_h */
