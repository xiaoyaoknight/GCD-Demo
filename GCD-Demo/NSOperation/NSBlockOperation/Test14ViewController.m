//
//  Test13ViewController.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/20.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test14ViewController.h"

@interface Test14ViewController ()

@end

@implementation Test14ViewController
- (void)viewDidLoad {
    self.title = @"NSOperation - NSBlockOperation";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

//    [self blockOperation1];
    [self blockOperation2];
//    [self blockOperation3];
}

#pragma mark -------------------  NSBlockOperation -------------------------

- (void)blockOperation1 {
    //跟GCD中的并发队列一样
    NSOperationQueue *q = [[NSOperationQueue alloc]init];
    //跟GCD中的主队列一样
    // NSOperationQueue *q = [NSOperationQueue mainQueue];
    //把多个操作放到队列里面
    for (int i = 0; i < 5; i++) {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"%@------%d",[NSThread currentThread],i);
            
        }];
        //把Block操作放到队列
        [q addOperation:op];
    }
    NSLog(@"完成");
}

- (void)blockOperation2 {
    
    NSOperationQueue *q = [[NSOperationQueue alloc]init];
    for (int i = 0; i < 5; i++) {
        [q addOperationWithBlock:^{
            NSLog(@"%@------%d",[NSThread currentThread],i);
        }];
    }
}


- (void)blockOperation3 {
    //1.封装操作
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 要执行的操作，在主线程中执行
        NSLog(@"1------%@",[NSThread currentThread]);
    }];
    //2.追加操作，追加的操作在子线程中执行，可以追加多条操作
    [op addExecutionBlock:^{
        NSLog(@"---download2--%@",[NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"---download3--%@",[NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"---download4--%@",[NSThread currentThread]);
    }];
    [op start];
}



- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

