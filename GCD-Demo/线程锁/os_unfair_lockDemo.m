//
//  os_unfair_lockDemo.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/21.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "os_unfair_lockDemo.h"
#import <os/lock.h>

@interface os_unfair_lockDemo()

@property (assign, nonatomic) os_unfair_lock ticketLock;

@end

@implementation os_unfair_lockDemo
- (instancetype)init {
    self = [super init];
    if (self) {
        self.ticketLock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}


//卖票
- (void)sellingTickets {
    os_unfair_lock_lock(&_ticketLock);
    
    [super sellingTickets];
    
    os_unfair_lock_unlock(&_ticketLock);
}
@end

