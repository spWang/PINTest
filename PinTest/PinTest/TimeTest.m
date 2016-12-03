//
//  TimeTest.m
//  HCBCache
//
//  Created by wangshuaipeng on 16/12/3.
//  Copyright © 2016年 Mac－pro. All rights reserved.
//

#import "TimeTest.h"

@interface TimeTest ()
@property (nonatomic, assign) NSTimeInterval sumTime;//时间总和
@property (nonatomic, assign) NSUInteger times;//次数
@end

@implementation TimeTest
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static TimeTest *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)logAverageTime:(NSTimeInterval)duration {
    self.sumTime += duration;
    self.times++;
    NSLog(@"run %zd times,average time is:%f",self.times,self.sumTime/(double)self.times);
}

- (void)reset {
    self.sumTime = 0;
    self.times = 0;
}

@end
