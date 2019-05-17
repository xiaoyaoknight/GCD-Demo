//
//  Test4ViewController.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/17.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test4ViewController.h"

@interface Test4ViewController ()

@end

@implementation Test4ViewController

- (void)viewDidLoad {
    self.title = @"常见问题";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
//    [self demo1]; // 异步
    
//    [self demo2]; // 同步
    
//    [self demo3]; // 同步 + 异步
    
//    [self demo4]; // 同步+主队列 死锁
    
//    [self demo5]; // 异步+主队列
    
//    [self demo6]; // sync 在串行队列添加任务的时候，会产生死锁，卡住当前队列
    
//    [self demo7]; // 放在另外的queue
    
//    [self demo8]; // 放在并发队列中
    
//    [self demo9]; // performselector runloop相关
    
    [self demo10]; // performselector runloop相关
}


/**
 异步
 */
- (void)demo1 {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"执行任务1 -- %@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"执行任务2 -- %@", [NSThread currentThread]);
        }
    });
}

/**
 同步
 */
- (void)demo2 {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"执行任务1 -- %@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"执行任务2 -- %@", [NSThread currentThread]);
        }
    });
    
}

- (void)demo3 {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"执行任务1 -- %@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"执行任务2 -- %@", [NSThread currentThread]);
        }
    });
    
}

#pragma mark ------------------同步主队列--------------------
/**
 同步主队列  死锁
 */
- (void)demo4 {
    
    NSLog(@"执行任务1 -- %@", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"执行任务2 -- %@", [NSThread currentThread]);
    });
    
    NSLog(@"执行任务3 -- %@", [NSThread currentThread]);
}

#pragma mark ------------------异步主队列--------------------
/**
 异步主队列
 */
- (void)demo5 {
    
    NSLog(@"执行任务1 -- %@", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"执行任务2 -- %@", [NSThread currentThread]);
    });
    
    NSLog(@"执行任务3 -- %@", [NSThread currentThread]);
    
    /*
     GCD-Demo[81600:1817690] 执行任务1 -- <NSThread: 0x600003d39200>{number = 1, name = main}
     GCD-Demo[81600:1817690] 执行任务3 -- <NSThread: 0x600003d39200>{number = 1, name = main}
     GCD-Demo[81600:1817690] 执行任务2 -- <NSThread: 0x600003d39200>{number = 1, name = main}
     */
}

#pragma mark --------------------死锁-----------------------------

- (void)demo6 {
    
    
    // 问题：以上代码在主线程执行的，会不会产生死锁？ 会
    //    sync 在串行队列添加任务的时候，会产生死锁，卡住当前队列
    
    NSLog(@"执行任务1 -- %@", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);// 串行队列
    dispatch_async(queue, ^{
        NSLog(@"执行任务2 -- %@", [NSThread currentThread]);
        
        dispatch_sync(queue, ^{
            NSLog(@"执行任务3 -- %@", [NSThread currentThread]);
        });
        
        dispatch_async(queue, ^{
            NSLog(@"执行任务4 -- %@", [NSThread currentThread]);
        });
    });
    
    NSLog(@"执行任务5 -- %@", [NSThread currentThread]);
}

/**
 放在另外的队列
 */
- (void)demo7 {
    
    
    // 问题：以上代码在主线程执行的，会不会产生死锁？ 会
    //    sync 在串行队列添加任务的时候，会产生死锁，卡住当前队列
    
    NSLog(@"执行任务1 -- %@", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);// 串行队列
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_SERIAL);// 串行队列
    dispatch_async(queue, ^{
        NSLog(@"执行任务2 -- %@", [NSThread currentThread]);
        
        dispatch_sync(queue2, ^{
            NSLog(@"执行任务3 -- %@", [NSThread currentThread]);
        });
        
        dispatch_async(queue, ^{
            NSLog(@"执行任务4 -- %@", [NSThread currentThread]);
        });
    });
    
    NSLog(@"执行任务5 -- %@", [NSThread currentThread]);
}

/**
 并发队列
 */
- (void)demo8 {
    
    
    // 问题：以上代码在主线程执行的，会不会产生死锁？ 会
    //    sync 在串行队列添加任务的时候，会产生死锁，卡住当前队列
    
    NSLog(@"执行任务1 -- %@", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);// 并发队列
    dispatch_async(queue, ^{
        NSLog(@"执行任务2 -- %@", [NSThread currentThread]);
        
        dispatch_sync(queue, ^{
            NSLog(@"执行任务3 -- %@", [NSThread currentThread]);
        });
        
        dispatch_async(queue, ^{
            NSLog(@"执行任务4 -- %@", [NSThread currentThread]);
        });
    });
    
    NSLog(@"执行任务5 -- %@", [NSThread currentThread]);
}

#pragma mark --------------------以下代码 performSelector 输出顺序-----------------------------
- (void)demo9 {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"执行任务1 -- %@", [NSThread currentThread]);
        [self performSelector:@selector(aaa) withObject:nil afterDelay:0]; // 不会执行，runloop相关，用到NSTimer，子线程默认没开启runloop
        NSLog(@"执行任务3 -- %@", [NSThread currentThread]);
    });
}

/**
 开启runloop
 */
- (void)demo10 {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"执行任务1 -- %@", [NSThread currentThread]);
        [self performSelector:@selector(aaa) withObject:nil afterDelay:0]; // 不会执行，runloop相关，用到NSTimer，子线程默认没开启runloop
        NSLog(@"执行任务3 -- %@", [NSThread currentThread]);
        
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    });
}

- (void)aaa {
    NSLog(@"执行任务2 -- %@", [NSThread currentThread]);
}


#pragma mark --------------------以下代码 输出顺序-----------------------------
- (void)test {
    
    // 以下代码 输出顺序
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"A");
    });
    NSLog(@"B");
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_sync(queue, ^{
        NSLog(@"C");
    });
    dispatch_async(queue, ^{
        NSLog(@"D");
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"E");
    });
    [self performSelector:@selector(method) withObject:nil afterDelay:0.0];
    NSLog(@"F");
    
}

- (void)method {
    NSLog(@"G");
}


- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
