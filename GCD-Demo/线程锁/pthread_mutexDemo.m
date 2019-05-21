//
//  pthread_mutexDemo.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/21.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "pthread_mutexDemo.h"
#import <pthread.h>

@interface pthread_mutexDemo()
@property (assign, nonatomic) pthread_mutex_t ticketMutex;
@end

@implementation pthread_mutexDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化属性
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
        // 初始化锁
        pthread_mutex_init(&(_ticketMutex), &attr);
        // 销毁属性
        pthread_mutexattr_destroy(&attr);
        
        
    }
    return self;
}

//卖票
- (void)sellingTickets{
    pthread_mutex_lock(&_ticketMutex);
    
    [super sellingTickets];
    
    pthread_mutex_unlock(&_ticketMutex);
}
@end

