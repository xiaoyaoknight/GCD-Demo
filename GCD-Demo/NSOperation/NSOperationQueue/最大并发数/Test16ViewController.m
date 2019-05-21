//
//  Test16ViewController.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/20.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test16ViewController.h"

@interface Test16ViewController ()

@property (nonatomic,strong) NSOperationQueue *opQueue;

@end

@implementation Test16ViewController

- (void)viewDidLoad {
    self.title = @"NSOperationQueue - 最大并发数";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [self demo];
}

#pragma mark -------------------  NSOperationQueue 高级操作:最大并发数-------------------------

- (void)demo {
    /*
     默认是并发队列,如果最大并发数>1,并发
     如果最大并发数==1,串行队列
     系统的默认是最大并发数-1 ,表示不限制
     设置成0则不会执行任何操作
     */
    self.opQueue.maxConcurrentOperationCount = 2;
    //把多个操作放到队列里面
    for (int i = 0; i < 10; i++) {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            [NSThread sleepForTimeInterval:3.0];
            NSLog(@"%@------%d",[NSThread currentThread],i);
            
        }];
        //把Block操作放到队列
        [self.opQueue addOperation:op];
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
