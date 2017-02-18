//
//  ViewController.m
//  GCD_semaphore
//
//  Created by 何江山 on 17/2/18.
//  Copyright © 2017年 何江山. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     //使用semaphore设置多线程并发
     dispatch_group_t group = dispatch_group_create();
     //创建一个semaphore信号量，信号量为10
     dispatch_semaphore_t semephore = dispatch_semaphore_create(10);
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     
     for (int i = 0; i < 100; i++) {
     //等待信号，当信号大于0时，正常执行，信号总量会-1，当信号总量小于0时，会一直等待。
     dispatch_semaphore_wait(semephore, DISPATCH_TIME_FOREVER);
     dispatch_group_async(group, queue, ^{
     NSLog(@"%i",i);
     sleep(2);
     //发送信号，信号总量+1
     dispatch_semaphore_signal(semephore);
     });
     }
     //    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
     */
    
    //需求：三个线程，让前两个线程先执行完，在执行第三个线程
    //第一种方式:semaphore
    /*
     dispatch_group_t group = dispatch_group_create();
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
     for (int i = 0; i < 3; i++) {
     dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
     dispatch_group_async(group, queue, ^{
     NSLog(@"i:%d",i);
     sleep(1);
     dispatch_semaphore_signal(semaphore);
     });
     
     }
     */
    //第二种方式,使用dispatch_group_notify监听是否两个线程执行完了
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        //        sleep(3);
        NSLog(@"block1");
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    
    dispatch_group_async(group, queue, ^{
        sleep(3);
        NSLog(@"block2");
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"---全部结束。。。");
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
