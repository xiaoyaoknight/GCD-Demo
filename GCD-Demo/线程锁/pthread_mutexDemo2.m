//
//  pthread_mutexDemo.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/21.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "pthread_mutexDemo2.h"
#import <pthread.h>

@interface pthread_mutexDemo2()
@property (assign, nonatomic) pthread_mutex_t ticketMutex;
@property (assign, nonatomic) pthread_mutex_t ticketMutex2;// 2把锁，解决死锁问题
@end

@implementation pthread_mutexDemo2

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化属性
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);  // 造成死锁
//        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);// 递归锁，解决死锁问题
        // 初始化锁
        pthread_mutex_init(&(_ticketMutex), &attr);
//        pthread_mutex_init(&(_ticketMutex2), &attr); // 2把锁，解决死锁问题
        // 销毁属性
        pthread_mutexattr_destroy(&attr);
        
        
    }
    return self;
}

/**
 代码就会造成线程死锁，因为方法sellingTickets的结束需要sellingTickets2解锁，
 方法sellingTickets2的结束需要sellingTickets解锁，相互引用造成死锁
 
 方案一：
 pthread_mutex_t里面有一个属性可以解决这个问题PTHREAD_MUTEX_RECURSIVE
 PTHREAD_MUTEX_RECURSIVE 递归锁：允许同一个线程对同一把锁进行重复加锁。要考重点同一个线程和同一把锁
 
 方案二：
 sellingTickets2中重新在创建一把新的锁，两个方法的锁对象不同，就不会造成线程死锁了。
 */
- (void)sellingTickets{
    pthread_mutex_lock(&_ticketMutex);
    [super sellingTickets];
    [self sellingTickets2];
    pthread_mutex_unlock(&_ticketMutex);
}

- (void)sellingTickets2{
    pthread_mutex_lock(&_ticketMutex);
    NSLog(@"%s",__func__);
    pthread_mutex_unlock(&_ticketMutex);
    
//    pthread_mutex_lock(&_ticketMutex2);
//    NSLog(@"%s",__func__);
//    pthread_mutex_unlock(&_ticketMutex2);
}

@end

