//
//  Test11ViewController.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/20.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test11ViewController.h"
#include <pthread.h>

@interface Test11ViewController ()

@end

@implementation Test11ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self onThread];
}

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
NSMutableArray *tickets;

- (void)onThread {
    tickets = [NSMutableArray array];
    //生成100张票
    for (int i = 0; i < 20; i++) {
        [tickets addObject:[NSNumber numberWithInt:i]];
    }
    
    //线程1 北京卖票窗口
    // 1\. 创建线程1: 定义一个pthread_t类型变量
    pthread_t thread1;
    // 2\. 开启线程1: 执行任务
    pthread_create(&thread1, NULL, run, NULL);
    // 3\. 设置子线程1的状态设置为detached，该线程运行结束后会自动释放所有资源
    pthread_detach(thread1);
    
    //线程2 上海卖票窗口
    // 1\. 创建线程2: 定义一个pthread_t类型变量
    pthread_t thread2;
    // 2\. 开启线程2: 执行任务
    pthread_create(&thread2, NULL, run, NULL);
    // 3\. 设置子线程2的状态设置为detached，该线程运行结束后会自动释放所有资源
    pthread_detach(thread2);
    
}

void * run(void *param) {
    while (true) {
        //锁门，执行任务
        pthread_mutex_lock(&mutex);
        if (tickets.count > 0) {
            NSLog(@"剩余票数%ld, 卖票窗口%@", tickets.count, [NSThread currentThread]);
            [tickets removeLastObject];
            [NSThread sleepForTimeInterval:0.2];
        }
        else {
            NSLog(@"票已经卖完了");
            
            //开门，让其他任务可以执行
            pthread_mutex_unlock(&mutex);
            
            break;
        }
        
        //开门，让其他任务可以执行
        pthread_mutex_unlock(&mutex);
    }
    
    return NULL;
}

@end
