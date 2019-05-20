//
//  Test9ViewController.m
//  GCD-Demo
//
//  Created by 王泽龙 on 2019/5/20.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test9ViewController.h"
#import "TestTicket.h"

@interface Test9ViewController ()
@property (nonatomic, assign) NSInteger ticketSurplusCount;

@end

@implementation Test9ViewController
- (void)viewDidLoad {
    self.title = @"GCD线程安全问题";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    TestTicket *ticket = [[TestTicket alloc] init];
//    [ticket initTicketStatusNotSave];
    [ticket initTicketStatusSave];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
