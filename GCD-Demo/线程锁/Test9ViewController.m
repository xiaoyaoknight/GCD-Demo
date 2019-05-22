//
//  Test9ViewController.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/20.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test9ViewController.h"
#import "TestTicket.h"
#import "TicketDemo.h"
#import "SynchronizedTicketDemo.h"
#import "OSSpinLockDemo.h"
#import "os_unfair_lockDemo.h"
#import "pthread_mutexDemo.h"
#import "pthread_mutexDemo2.h"
#import "pthread_mutexDemo3.h"
#import "NSLockDemo.h"
#import "NSRecursiveLockDemo.h"
#import "NSConditionDemo.h"
#import "NSConditionLockDemo.h"
#import "dispatch_semaphoreDemo.h"
#import "pthread_rwlockDemo.h"

@interface Test9ViewController ()
@property (nonatomic, assign) NSInteger ticketSurplusCount;

@end

@implementation Test9ViewController
- (void)viewDidLoad {
    self.title = @"线程锁 - 13种锁";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
//    [self demo];
//    [self demo1];
//    [self demo2];
//    [self demo3];
//    [self demo4];
//    [self demo5];
//    [self demo6];
//    [self demo7];
//    [self demo8];
//    [self demo9];
//    [self demo10];
//    [self demo11];
//    [self demo12];

}

#pragma mark ------------------- 线程安全问题 -------------------------
- (void)demo {
    TicketDemo *tick = [[TicketDemo alloc] init];
    [tick ticketTest];
}

#pragma mark ------------------- Synchronized -------------------------
- (void)demo1 {
    SynchronizedTicketDemo *tick = [[SynchronizedTicketDemo alloc] init];
    [tick ticketTest];
}

#pragma mark ------------------- OSSpinLock -------------------------
- (void)demo2 {
    OSSpinLockDemo *tick = [[OSSpinLockDemo alloc] init];
    [tick ticketTest];
}

#pragma mark ------------------- os_unfair_lock -------------------------
- (void)demo3 {
    os_unfair_lockDemo *tick = [[os_unfair_lockDemo alloc] init];
    [tick ticketTest];
}

#pragma mark ------------------- pthread_mutex -------------------------
- (void)demo4 {
    pthread_mutexDemo *tick = [[pthread_mutexDemo alloc] init];
    [tick ticketTest];
}

#pragma mark ------------------- pthread_mutex - 死锁问题 -------------------------
- (void)demo5 {
    pthread_mutexDemo2 *tick = [[pthread_mutexDemo2 alloc] init];
    [tick ticketTest];
}

#pragma mark ------------------- pthread_mutex - 条件 -------------------------
- (void)demo6 {
    pthread_mutexDemo3 *tick = [[pthread_mutexDemo3 alloc] init];
    [tick otherTest];
}

#pragma mark ------------------- NSLock  -------------------------
- (void)demo7 {
    NSLockDemo *tick = [[NSLockDemo alloc] init];
    [tick ticketTest];
}

#pragma mark ------------------- NSRecursiveLock  -------------------------
- (void)demo8 {
    NSRecursiveLockDemo *tick = [[NSRecursiveLockDemo alloc] init];
    [tick ticketTest];
}

#pragma mark ------------------- NSCondition  -------------------------
- (void)demo9 {
    NSConditionDemo *tick = [[NSConditionDemo alloc] init];
    [tick otherTest];
}

#pragma mark ------------------- NSConditionLock  -------------------------
- (void)demo10 {
    NSConditionLockDemo *tick = [[NSConditionLockDemo alloc] init];
    [tick otherTest];
}

#pragma mark ------------------- dispatch_semaphore  -------------------------
- (void)demo11 {
    dispatch_semaphoreDemo *tick = [[dispatch_semaphoreDemo alloc] init];
    [tick otherTest];
}

#pragma mark ------------------- pthread_rwlock  -------------------------
- (void)demo12 {
    pthread_rwlockDemo *tick = [[pthread_rwlockDemo alloc] init];
    [tick otherTest];
}



- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
