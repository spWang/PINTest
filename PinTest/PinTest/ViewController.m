//
//  ViewController.m
//  PinTest
//
//  Created by wangshuaipeng on 16/12/3.
//  Copyright © 2016年 Mac－pro. All rights reserved.
//

#import "ViewController.h"
#import "NewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)click:(id)sender {
    UIViewController *vc = [NewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
