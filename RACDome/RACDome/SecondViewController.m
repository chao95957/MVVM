//
//  SecondViewController.m
//  RACDome
//
//  Created by zsl-mac on 15/7/13.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "SecondViewController.h"
#import <ReactiveCocoa.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //-subscribeNext: -subscribeError: -subscribeCompleted:
    
    //可以根据数组 发送信号
    RACSignal *letters = @[@"A",@"B",@"C"].rac_sequence.signal;
    
    //返回
//    [letters subscribeNext:^(NSString *x) {
//        NSLog(@"%@",x);
//    }];
    
    //注入效果 -doNext: -doError: -doCompleted:
    __block unsigned index = 0;
    RACSignal *loggingSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        index ++;
        [subscriber sendCompleted];
        return nil;
    }];
    
    loggingSignal = [loggingSignal doCompleted:^{
//        NSLog(@"doCompleted : %u",index);
    }];
    
    [loggingSignal subscribeCompleted:^{
//        NSLog(@"subscribeCompleted : %u",index);
    }];
    
    
    //map映射，可以看做对玻璃球的变换、重新组装
    RACSignal *maped = [letters map:^id(NSString *value) {
        return [value stringByAppendingString:value];
    }];
    
    [maped subscribeNext:^(id x) {
//        NSLog(@"%@",x);
    }];
    
    RACSignal *numbers = [@"1 2 3 4 5 6 7 8 9 " componentsSeparatedByString:@" "].rac_sequence.signal;
    //信号过滤
    [[numbers filter:^BOOL(NSString *value) {
        return (value.intValue % 2) == 0;
    }]subscribeNext:^(NSString *value) {
//        NSLog(@"%@",value);
    }];
    
    //序列
    RACSequence *seqNumbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
    //信号过滤
    [seqNumbers filter:^BOOL(NSString * value) {
        return (value.intValue % 2) == 0;
    }];
    
    [seqNumbers.signal subscribeNext:^(NSString* value) {
//        NSLog(@"seq:%@",value);
    }];
    
    //信号拼接
    RACSignal *concatenated = [letters concat:numbers];
    [concatenated subscribeNext:^(NSString *x) {
//        NSLog(@"%@",x);
    }];
    
    
    RACSequence *seqLetters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence;
    //创建一个合并序列
    RACSequence *sequenceofSequence = @[seqLetters,seqNumbers].rac_sequence;
    //合并
    RACSignal *seqSignal = [sequenceofSequence flatten].signal;
    
    [seqSignal subscribeNext:^(NSString *x) {
//        NSLog(@"%@",x);
    }];
    
    //创建信号 要发送的数据
    RACSubject *subLetters = [RACSubject subject];
    RACSubject *subNumbers = [RACSubject subject];
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:subLetters];
        [subscriber sendNext:subNumbers];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    
    RACSignal *flatten = [signal flatten];
    
    [flatten subscribeNext:^(NSString *value) {
//        NSLog(@"%@",value);
    }];
    
    //下面是发送的次序
    [subNumbers sendNext:@"1"];
    [subLetters sendNext:@"A"];
    [subNumbers sendNext:@"2"];
    [subLetters sendNext:@"B"];
    
    // Contains: 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9
    //flattenMap 先 flatten 再 map
    RACSequence *extended = [seqNumbers flattenMap:^(NSString *num) {
        return @[ num, num ].rac_sequence;
    }];
    
    [extended.signal subscribeNext:^(NSString* x) {
//        NSLog(@"%@",x);
    }];
    
    //then 信号发送完 completed 之后 再接收一个信号 
    RACSignal *replaceSeq = [[letters doNext:^(NSString *x) {
//        NSLog(@"%@",x);//没执行
        
    }]
    then:^RACSignal *{
        //返回的 signal
        return [@"1 2 3 4 5 6 7 " componentsSeparatedByString:@" "].rac_sequence.signal;
    }];
    
    [replaceSeq subscribeNext:^(id x) {
//        NSLog(@"%@",x);
    }];
    
    //subject 是继承 signal //也是合并几个信号 触发一次订阅者操作
    RACSignal *merged = [RACSignal merge:@[subLetters,subNumbers]];
    
    
    [merged subscribeNext:^(NSString *x) {
//        NSLog(@"%@",x);
    }];
    
    
    RACSubject *subSignalofSignal = [RACSubject subject];
    
    RACSignal *swithed = [subSignalofSignal switchToLatest];
    
    [swithed subscribeNext:^(id x) {
//        NSLog(@"%@",x);
    }];
    
    //只接受subLetters 发出的值
    [subSignalofSignal sendNext:subLetters];
    //subLetters 发出一个值
    [subLetters sendNext:@"A"];
    //subLetters 发出一个值
    [subLetters sendNext:@"B"];
    
    //只接受subNumbers 发出的值
    [subSignalofSignal sendNext:subNumbers];
    //subNumbers 发出一个值
    [subNumbers sendNext:@"1"];
    //subLetters 发出一个值 但不受接收
    [subLetters sendNext:@"2"];
    
    
    
    __block int aNumber = 0;
    RACSignal *aSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        aNumber ++ ;
        [subscriber sendNext:@(aNumber)];
        [subscriber sendCompleted];
        return nil;
    }];
    
    //调用一次累加一次
    [aSignal subscribeNext:^(id x) {
        NSLog(@"subscribe one : %@",x);
    }];
    
    [aSignal subscribeNext:^(id x) {
        NSLog(@"subscribe two : %@",x);
    }];
    
    __block int missilesToLaunch = 0;
    
    RACSignal *processedSignal = [[RACSignal return:@"missiles"]map:^id(id value) {
        missilesToLaunch ++;
        return [NSString stringWithFormat:@"will launch : %d %@",missilesToLaunch,value];
    }];
    
    [processedSignal subscribeNext:^(id x) {
        NSLog(@"frist:%@",x);
    }];
    
    [processedSignal subscribeNext:^(id x) {
        NSLog(@"second : %@",x);
    }];
    
    
    RACMulticastConnection *connection = [processedSignal multicast:[RACReplaySubject subject]];
    [connection connect];
    
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"subscriber one:%@",x);
    }];
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"subscriber two:%@",x);
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
