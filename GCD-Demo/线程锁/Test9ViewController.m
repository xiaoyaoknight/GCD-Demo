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
    [self demo4];
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

#pragma mark ------------------- OSSpinLockDemo -------------------------
- (void)demo2 {
    OSSpinLockDemo *tick = [[OSSpinLockDemo alloc] init];
    [tick ticketTest];
}

#pragma mark ------------------- os_unfair_lockDemo -------------------------
- (void)demo3 {
    os_unfair_lockDemo *tick = [[os_unfair_lockDemo alloc] init];
    [tick ticketTest];
}

#pragma mark ------------------- pthread_mutexDemo -------------------------
- (void)demo4 {
    pthread_mutexDemo *tick = [[pthread_mutexDemo alloc] init];
    [tick ticketTest];
}



- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
