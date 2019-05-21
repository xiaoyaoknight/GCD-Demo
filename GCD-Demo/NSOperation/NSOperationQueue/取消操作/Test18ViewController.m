//
//  Test18ViewController.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/20.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test18ViewController.h"

@interface Test18ViewController ()
@property (nonatomic,strong) NSOperationQueue *opQueue;

@end

@implementation Test18ViewController

- (void)viewDidLoad {
    self.title = @"NSOperationQueue - 取消队列里的所有操作";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 200, 100);
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    
    [self demo];
}

#pragma mark -------------------  NSOperationQueue 高级操作:取消队列里的所有操作-------------------------

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
    //只能取消所有队列的里面的操作，正在执行的无法取消
    //取消操作并不会影响队列的挂起状态
    [self.opQueue cancelAllOperations];
    NSLog(@"取消队列里所有的操作");
    //取消队列的挂起状态
    //（只要是取消了队列的操作，我们就把队列处于不挂起状态,以便于后续的开始）
    self.opQueue.suspended = NO;
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
