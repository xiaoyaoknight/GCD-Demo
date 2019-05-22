//
//  NSLockDemo.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/22.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "NSLockDemo.h"

@interface NSLockDemo()

@property (strong, nonatomic) NSLock *ticketLock;

@end

@implementation NSLockDemo

//卖票
- (void)sellingTickets{
    [self.ticketLock lock];
    [super sellingTickets];
    [self.ticketLock unlock];
}
@end
