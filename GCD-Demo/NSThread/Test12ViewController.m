//
//  Test12ViewController.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/20.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test12ViewController.h"

@interface Test12ViewController ()

@end

@implementation Test12ViewController

- (void)viewDidLoad {
    self.title = @"NSthread";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
//    [self onThread1];
//    [self onThread2];
//    [self onThread3];
    
    // 线程状态
    [self onThread4];
}

#pragma mark -------------------  NSThread创建线程 三种方式 -------------------------

/**
 initWithTarget
 */
- (void)onThread1 {
    // 创建并启动
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    // 设置线程名
    [thread setName:@"thread1"];
    // 设置优先级，优先级从0到1，1最高
    [thread setThreadPriority:0.9];
    // 启动
    [thread start];
}

/**
 `detachNewThreadSelector`显式创建并启动线程
 */
- (void)onThread2 {
    // 使用类方法创建线程并自动启动线程
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
}

/**
 `performSelectorInBackground`隐式创建并启动线程
 */
- (void)onThread3 {
    // 使用NSObject的方法隐式创建并自动启动
    [self performSelectorInBackground:@selector(run) withObject:nil];
}

- (void)run {
    NSLog(@"当前线程%@", [NSThread currentThread]);
}

#pragma mark -------------------  NSThread线程状态 -------------------------

- (void)onThread4 {
    // 使用NSObject的方法隐式创建并自动启动
    [self performSelectorInBackground:@selector(run2) withObject:nil];
}

- (void)run2 {
    NSLog(@"当前线程%@", [NSThread currentThread]);
    
    for (int i = 0 ; i < 20; i++) {
        if (i == 10) {
            //取消线程
            [[NSThread currentThread] cancel];
            NSLog(@"取消线程%@", [NSThread currentThread]);
        }
        
        if ([[NSThread currentThread] isCancelled]) {
            NSLog(@"结束线程%@", [NSThread currentThread]);
            //结束线程
            [NSThread exit];
            NSLog(@"这行代码不会打印的");
        }
        
    }
}




- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
