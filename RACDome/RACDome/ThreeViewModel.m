//
//  ThreeViewModel.m
//  RACDome
//
//  Created by zsl-mac on 15/7/22.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "ThreeViewModel.h"


@interface ThreeViewModel ()






@end


@implementation ThreeViewModel



/**
 *  @author Tankch, 15-07-22 14:07:17
 *
 *  通过普通的string 来进行 Viewmodel 和viewcontroller 之间的互动
 */

- (id)init
{
    self = [super init];
    if (self) {
//        [self settingCommand];
    }
    
    return self;
}

- (void)timeChangeSendString
{
    __block int Index = 0;
    @weakify(self)
    //定时器 可以并发
    RACSignal *time = [[RACSignal interval:3 onScheduler:[RACScheduler mainThreadScheduler]]startWith:@"0"];
    time = [time take:10];// 这里是控制发射次数
    
    time = [time map:^id(id value) {
        @strongify(self)
        Index++;
        return [NSString stringWithFormat:@"%d",Index];
    }];
    [time subscribeNext:^(NSString * x) {
        @strongify(self)
        self.sendString = x;
    }];
    
    
}

- (RACCommand *)startTiemCommand
{
    NSLog(@"按钮给点击了");
    @weakify(self)
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        [self getViewShowData];
        return [RACSignal empty];
    }];
    
    return command;
}

/**
 *  @author Tankch, 15-07-22 16:07:39
 *
 *  通过command 来进行交互
 */

- (void)settingCommand
{
    
//    self.operationCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
//       
//        return [RACSignal error:[NSError errorWithDomain:@"123" code:1 userInfo:@{@"1":@"1"}]];
//    }];
    
    self.operationCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
       
       return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               NSLog(@"1");
           });
//           [subscriber sendNext:@"1"];
           //发送错误信息
           [self getViewShowData];
           [subscriber sendError:[NSError errorWithDomain:@"123" code:1 userInfo:@{@"1":@"1"}]];
           [subscriber sendCompleted];  //来判断 executing是否执行完
           return nil;
       }];
        
    }];
}


- (void)getViewShowData
{
    
    self.title = @"陈逗比是SB";
    
    self.RequestError = [NSError errorWithDomain:@"123" code:1 userInfo:@{@"1":@"1"}];
    
    self.isRequestFinished = @(YES);
    
}


- (void)cancleViewHideData
{
    self.title = @"陈亚真是个SB";
    
    self.RequestError = nil;
    
    self.isRequestFinished = @(NO);
    
}

- (RACCommand *)cancleButtonCommand
{
    //这个信号一般都是 是与否
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return nil;
    }];
    
    RACCommand *command = [[RACCommand alloc]initWithEnabled:nil signalBlock:^RACSignal *(id input) {
        [self cancleViewHideData];
        return [RACSignal empty];
    }];
    
    
    return command;
}

@end
