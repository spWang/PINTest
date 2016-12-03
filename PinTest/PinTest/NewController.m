//
//  NewController.m
//  PinTest
//
//  Created by wangshuaipeng on 16/12/3.
//  Copyright © 2016年 Mac－pro. All rights reserved.
//

#import "NewController.h"
#import "Config.h"
#import "PINCache.h"

#define LOGThreadEveryXXXtimes(xxx); if (i % xxx == 0) { \
    debugThread(); \
}

#define enterGroup(); dispatch_group_enter(_group);

#define leaveGroup(); dispatch_group_leave(_group);

#define logGroupCostTime(); dispatch_group_notify(_group, dispatch_get_main_queue(), ^{ \
    timeAvrageLog(); \
});


@interface NewController ()
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) dispatch_group_t group;
@end

@implementation NewController

#pragma mark - lefe cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.clearBtn.frame = CGRectMake(50, 100, 200, 50);
    _queue = dispatch_queue_create("bbb", DISPATCH_QUEUE_CONCURRENT);
    _group = dispatch_group_create();
    
//    [self testTimeCostInMultiThreadForSet];
//    [self testTimeCostInMultiThreadForGet];
}


#pragma mark - test Set
- (void)testTimeCostInMultiThreadForSet {
    PINCache *cache = [PINCache sharedCache];
    timeStart();
    //repeat 1500: cost 16s, no problem
    //repeat 3000: cost 33s no response in my iphone 6 before 33 second, is my test not correct ?
    for (int i = 0; i<3000; i++) {
        enterGroup();
        dispatch_async(_queue, ^{
            LOGThreadEveryXXXtimes(300);
            NSString *value = [NSString stringWithFormat:@"value~%d",i];
            NSString *key = [NSString stringWithFormat:@"key~%d",i];
            [cache setObject:value forKey:key];
            //            [cache setObject:value forKey:key block:nil];
            leaveGroup();
        });
    }
    logGroupCostTime();
}


#pragma mark - test get
- (void)testTimeCostInMultiThreadForGet {
    PINCache *cache = [PINCache sharedCache];
    timeStart();
    for (int i = 0; i<1000; i++) {
        enterGroup();
        dispatch_async(_queue, ^{
//            LOGThreadEveryXXXtimes(1000);
            NSString *key = [NSString stringWithFormat:@"key~%d",i];
            [cache objectForKey:key];
            leaveGroup();
        });
    }
    logGroupCostTime();
}



#pragma mark - getters and setters
- (UIButton *)clearBtn {
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearBtn setTitle:@"clear all in disk" forState:UIControlStateNormal];
        [_clearBtn setTitle:@"runing" forState:UIControlStateDisabled];
        [_clearBtn setTitle:@"complete" forState:UIControlStateSelected];
        [_clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _clearBtn.backgroundColor = [UIColor redColor];
        [_clearBtn addTarget:self action:@selector(clearClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_clearBtn];
    }
    return _clearBtn;
}
- (void)clearClick:(UIButton *)clearBtn {
    clearBtn.enabled = NO;
    [[PINCache sharedCache] removeAllObjects:^(PINCache * _Nonnull cache) {
        clearBtn.enabled = YES;
        clearBtn.selected = YES;
        NSLog(@"complete");
    }];
}








@end
