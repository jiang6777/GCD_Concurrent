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
    /*
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
     */
    
    
    /*
     线程死锁：线程死锁主要是两个线程互相等待
     造成死锁的几种方式
     */
    /* 第一种 1在等待2执行完再往下执行   2等待1执行完了再执行，造成死锁
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"回到主线程:%@",[NSThread currentThread]);
         NSLog(2);
    });
    NSLog(@"1");
     */
    /* 第二种 while语句是死循环，所以造成死锁
    while (1) {
        NSLog(@"2");
    }
    NSLog(@"1");
     */
    /* 第三种
     2是添加在串行队列中，所以2队列中只能有一个任务在同时执行，3会等待4执行完了再往下执行，4会等待3执行完了再往下执行
     NSLog(@"1");
     dispatch_queue_t queue = dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
     dispatch_async(queue, ^{
     NSLog(@"2");
     dispatch_sync(queue, ^{
     NSLog(@"3");
     });
     NSLog(@"4");
     });
     NSLog(@"5");
     */
    /*
     
     */
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"1");
        });
    });
    while (1) {
        
    }
    NSLog(@"1");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
