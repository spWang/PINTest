//
//  TimeTest.h
//  HCBCache
//
//  Created by wangshuaipeng on 16/12/3.
//  Copyright © 2016年 Mac－pro. All rights reserved.
//

#import <Foundation/Foundation.h>
//开始计时
#define timeStart(); CGFloat start = CACurrentMediaTime();
//重新开始计时
#define timeReStart(); start = CACurrentMediaTime();
//开始到结束的时间间隔
#define timeEndLogDuration(); NSLog(@"duration:%f",CACurrentMediaTime() - start);
//打印平均时间
#define timeAvrageLog(); [[TimeTest shareInstance] logAverageTime:CACurrentMediaTime() - start];
//平均时间的重置
#define timeReset(); [[TimeTest shareInstance] reset];

@interface TimeTest : NSObject

+ (instancetype)shareInstance;

- (void)logAverageTime:(NSTimeInterval)duration;

- (void)reset;

@end
