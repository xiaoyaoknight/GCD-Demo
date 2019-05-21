//
//  Test17ViewController.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/20.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test17ViewController.h"

@interface Test17ViewController ()
@property (nonatomic,strong) NSOperationQueue *opQueue;

@end

@implementation Test17ViewController

- (void)viewDidLoad {
    self.title = @"NSOperationQueue - 线程的挂起";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 200, 100);
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    
    [self demo];
}

#pragma mark -------------------  NSOperationQueue 高级操作:线程的挂起-------------------------

- (void)demo {
   
    //把多个操作放到队列里面
    for (int i = 0; i < 1000; i++) {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            [NSThread sleepForTimeInterval:3.0];
            NSLog(@"%@------%d",[NSThread currentThread],i);
            
        }];
        //把Block操作放到队列
        [self.opQueue addOperation:op];
    }
}

//暂停继续(对队列的暂停和继续)，挂起的是队列，不会影响已经在执行的操作
- (void)click {
    //判断操作的数量，当前队列里面是不是有操作？
//    if (self.opQueue.operationCount == 0) {
//        NSLog(@"当前队列没有操作");
//        return;
//    }
    
    self.opQueue.suspended = !self.opQueue.isSuspended;
    if (self.opQueue.suspended) {
        NSLog(@"暂停");
    } else{
        NSLog(@"继续");
    }
}


//重写getter方法实现懒加载
- (NSOperationQueue*)opQueue {
    if (_opQueue == nil) {
        _opQueue = [[NSOperationQueue alloc]init];
    }
    return _opQueue;
}


- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
