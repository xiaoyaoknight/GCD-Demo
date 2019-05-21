//
//  Test19ViewController.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/20.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test19ViewController.h"

@interface Test19ViewController ()
@property (nonatomic,strong) NSOperationQueue *opQueue;

@end

@implementation Test19ViewController

- (void)viewDidLoad {
    self.title = @"NSOperationQueue - 依赖关系";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
 
    [self demo];
}

- (void)demo {
    /*
     * 例子
     *
     * 1.下载一个小说压缩包
     *  2.解压缩，删除压缩包
     * 3.更新UI
     */
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1.下载一个小说压缩包,%@",[NSThread currentThread]);
        
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2.解压缩，删除压缩包,%@",[NSThread currentThread]);
        
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3.更新UI,%@",[NSThread currentThread]);
        
    }];
    
    //指定任务之间的依赖关系 --依赖关系可以跨队列(可以再子线程下载，在主线程更新UI)
    
    [op2 addDependency:op1];
//    [op3 addDependency:op2];
    //  [op1 addDependency:op3];  一定不能出现循环依赖
    
    //waitUntilFinished  类似GCD中的调度组的通知
    //NO不等待，直接执行输出come here
    //YES等待任务执行完再执行输出come here
    [self.opQueue addOperations:@[op1,op2] waitUntilFinished:YES];
    
    
    //在主线程更新UI
    [[NSOperationQueue mainQueue] addOperation:op3];
    [op3 addDependency:op2];
    NSLog(@"come here");
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
