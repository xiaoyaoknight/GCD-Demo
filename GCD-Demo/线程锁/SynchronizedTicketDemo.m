//
//  SynchronizedTicketDemo.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/21.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "SynchronizedTicketDemo.h"

@implementation SynchronizedTicketDemo

- (void)sellingTickets {
    @synchronized ([self class]) {
        [super sellingTickets];
    }
}
@end
