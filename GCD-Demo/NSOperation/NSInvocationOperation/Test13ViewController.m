//
//  Test13ViewController.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/20.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test13ViewController.h"

@interface Test13ViewController ()

@end

@implementation Test13ViewController
- (void)viewDidLoad {
    self.title = @"NSOperation - NSInvocationOperation";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
//    [self invocationOperation];           // 单个 NSInvocationOperation
//    [self invocationOperationAddQueue];   // NSInvocationOperation （添加到队列）
    [self invocationOperationMore];         // 多个 NSInvocationOperation
}

#pragma mark -------------------  单个 NSInvocationOperation -------------------------
- (void)invocationOperation {
    /*
     第一个参数:目标对象
     第二个参数:选择器,要调用的方法
     第三个参数:方法要传递的参数
     */
    NSOperation *op = [[NSInvocationOperation alloc]initWithTarget:self
                                                          selector:@selector(downloadImage:) object:@"Invocation"];
    //2.start方法，直接在当前线程执行
    [op start];

}

#pragma mark ------------------- NSInvocationOperation （添加到队列）-------------------------

/**
 添加到队列
 */
- (void)invocationOperationAddQueue {
    //1.创建
    NSOperation *op = [[NSInvocationOperation alloc]initWithTarget:self
                                                          selector:@selector(downloadImage:) object:@"Invocation"];
    //2.放到队列里面去
    NSOperationQueue *q = [[NSOperationQueue alloc]init];
    //只要把操作放到队列，会自动异步执行调度方法
    [q addOperation:op];
}

#pragma mark -------------------  多个 NSInvocationOperation -------------------------
- (void)invocationOperationMore {
    //队列，GCD里面的并发队列使用最多，所以NSOperation技术直接把GCD里面的并发队列封装起来
    //NSOperationQueue本质就是GCD里面的并发队列
    //操作就是GCD里面异步执行的任务
    NSOperationQueue *q = [[NSOperationQueue alloc]init];
    //把多个操作放到队列里面
    for (int i = 0; i < 20; i++) {
        NSOperation *op = [[NSInvocationOperation alloc]initWithTarget:self
                                                              selector:@selector(downloadImage:) object:[NSString stringWithFormat:@"Invocation%d",i]];
        [q addOperation:op];
    }
}

#pragma mark - 调用的耗时操作,后面调用的耗时操作都是这个
- (void)downloadImage:(id)obj{
    NSLog(@"%@-----%@",[NSThread currentThread],obj);
}

#pragma mark -------------------  NSBlockOperation -------------------------
- (void)blockOperation {
    //1.封装操作
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 要执行的操作，在主线程中执行
        NSLog(@"1------%@",[NSThread currentThread]);
    }];
    //2.追加操作，追加的操作在子线程中执行，可以追加多条操作
    [op addExecutionBlock:^{
        NSLog(@"---download2--%@",[NSThread currentThread]);
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

