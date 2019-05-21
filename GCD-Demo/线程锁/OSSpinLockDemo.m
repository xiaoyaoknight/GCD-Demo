//
//  OSSpinLockDemo.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/21.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "OSSpinLockDemo.h"
#import <libkern/OSAtomic.h>

@interface OSSpinLockDemo()
@property (assign, nonatomic) OSSpinLock ticketLock;
@end

@implementation OSSpinLockDemo

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.ticketLock = OS_SPINLOCK_INIT;
    }
    return self;
}


//卖票
- (void)sellingTickets {
    OSSpinLockLock(&_ticketLock);
    
    [super sellingTickets];
    
    OSSpinLockUnlock(&_ticketLock);
}

@end

