//
//  NSConditionDemo.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/22.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "NSConditionDemo.h"

@interface NSConditionDemo ()

@property (nonatomic,strong) NSCondition *condition;
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation NSConditionDemo

- (instancetype)init {
    if (self = [super init]) {
        
        self.data = [NSMutableArray array];
    }
    return self;
}

- (NSCondition *)condition {
    if (_condition == nil) {
        _condition = [[NSCondition alloc] init];
    }
    return _condition;
}

- (void)otherTest {
    [[[NSThread alloc] initWithTarget:self selector:@selector(__remove) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__add) object:nil] start];
}

// 线程1
// 删除数组中的元素
- (void)__remove {
    [self.condition lock];
    NSLog(@"__remove - begin");
    if (self.data.count == 0) {
        // 等待
        [self.condition wait];
    }
    [self.data removeLastObject];
    NSLog(@"删除了元素");
    [self.condition unlock];
}

// 线程2
// 往数组中添加元素
- (void)__add {
    [self.condition lock];
    sleep(1);
    [self.data addObject:@"Test"];
    NSLog(@"添加了元素");
    // 信号
    [self.condition signal];
    [self.condition unlock];
}

@end
