//
//  TicketDemo.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/21.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "TicketDemo.h"

@interface TicketDemo ()
@property (nonatomic, assign) NSInteger ticketsCount;

@end


@implementation TicketDemo

/**
 卖票演示
 */
- (void)ticketTest {
    self.ticketsCount = 20;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (NSInteger i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            for (int i = 0; i < 10; i++) {
                [self sellingTickets];
            }
        });
    }
    
}

//卖票
- (void)sellingTickets {
    NSInteger oldMoney = self.ticketsCount;
    sleep(.2);
    if (oldMoney > 0) {
        oldMoney -= 1;
        self.ticketsCount = oldMoney;
        NSLog(@"当前剩余票数-> %ld", (long)oldMoney);
    } else {
        NSLog(@"票买完了");
    }
    
}

@end
