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
@property (nonatomic,strong) NSString *name;

@property (nonatomic,copy) NSString *state;
@property (nonatomic,copy) NSString *currentState;
@property (nonatomic,copy) NSString *sendState;

@property (nonatomic,copy) NSString *labelText;   //labeltext 监控
@property (weak, nonatomic) IBOutlet UILabel *label;

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
    
    /**
     *  @author Tankch, 15-07-24 11:07:36
     *
     *  Map的用法 用来映射出想要的数据 返回还是signal
     *
     *  @param 闯进来的数据源
     *
     *  @return 返回去的数据源
     */
    RACSignal *maped = [letters map:^id(NSString *value) {
        return [value stringByAppendingString:value];
    }];
    
    [maped subscribeNext:^(id x) {
        NSLog(@"map:%@",x);
    }];
    
    /**
     *  @author Tankch, 15-07-24 11:07:45
     *
     *  Filter 数据过滤
     */
    RACSignal *numbers = [@"1 2 3 4 5 6 7 8 9 " componentsSeparatedByString:@" "].rac_sequence.signal;
    [[numbers filter:^BOOL(NSString *value) {
        return (value.intValue % 2) == 0;
    }]subscribeNext:^(NSString *value) {
        NSLog(@"filter:%@",value);
    }];
    
    /**
     *  @author Tankch, 15-07-24 11:07:14
     *
     *  RAC序列 数组直接rac_sequece 就可以封装成数组signal
     */
    RACSequence *seqNumbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
    //信号过滤
    [seqNumbers filter:^BOOL(NSString * value) {
        return (value.intValue % 2) == 0;
    }];
    
    [seqNumbers.signal subscribeNext:^(NSString* value) {
        NSLog(@"seq:%@",value);
    }];
    
    /**
     *  @author Tankch, 15-07-24 11:07:34
     *
     *  Concat 信号拼接 将两个信号拼接形成一个信号 数据源也拼接
     */
    RACSignal *concatenated = [letters concat:numbers];
    [concatenated subscribeNext:^(NSString *x) {
        NSLog(@"concat%@",x);
    }];
    
    /**
     *  @author Tankch, 15-07-24 11:07:25
     *
     *  Flatten 信号合并 将两个信号合并成一个信号
     */
    RACSequence *seqLetters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence;
    //创建一个合并序列
    RACSequence *sequenceofSequence = @[seqLetters,seqNumbers].rac_sequence;
    //合并
    RACSignal *seqSignal = [sequenceofSequence flatten].signal;
    
    [seqSignal subscribeNext:^(NSString *x) {
        NSLog(@"flatten%@",x);
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
    /**
     *  @author Tankch, 15-07-24 11:07:10
     *
     *  FlattenMap 先FlattenMap 之后再map
     *
     *  @param num 传进来合并的信号
     *
     *  @return map 之后想要的数据
     */
    RACSequence *extended = [seqNumbers flattenMap:^(NSString *num) {
        return @[ num, num ].rac_sequence;
    }];
    
    [extended.signal subscribeNext:^(NSString* x) {
        NSLog(@"flatten%@",x);
    }];
    
    /**
     *  @author Tankch, 15-07-24 11:07:14
     *
     *  Then 信号发完后 completed 之后再接受一个信号
     *
     *  @param x 传进来的信号
     *
     *  @return 返回去信号
     */
    //then 信号发送完 completed 之后 再接收一个信号 
    RACSignal *replaceSeq = [[letters doNext:^(NSString *x) {
//        NSLog(@"%@",x);//没执行
        
    }]
    then:^RACSignal *{
        //返回的 signal
        return [@"1 2 3 4 5 6 7 " componentsSeparatedByString:@" "].rac_sequence.signal;
    }];
    
    [replaceSeq subscribeNext:^(id x) {
        NSLog(@"then:%@",x);
    }];
    
    /**
     *  @author Tankch, 15-07-24 11:07:18
     *
     *  merge 合并几个信号 触发一次订阅者操作
     */
    RACSignal *merged = [RACSignal merge:@[subLetters,subNumbers]];
    
    
    [merged subscribeNext:^(NSString *x) {
        NSLog(@"merge:%@",x);
    }];
    
    /**
     *  @author Tankch, 15-07-24 11:07:10
     *
     *  switchToLatest 的作用是自动切换signal of signals到最后一个，比如之前的command.executionSignals就可以使用switchToLatest
     */
    RACSubject *subSignalofSignal = [RACSubject subject];
    RACSignal *swithed = [subSignalofSignal switchToLatest];
    
    [swithed subscribeNext:^(id x) {
        NSLog(@"swithed%@",x);
    }];
    
    [subSignalofSignal subscribeNext:^(id x) {
        NSLog(@"subsinalValue:%@",x);
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
//        NSLog(@"subscribe one : %@",x);
    }];
    
    [aSignal subscribeNext:^(id x) {
//        NSLog(@"subscribe two : %@",x);
    }];
    
    __block int missilesToLaunch = 0;
    
    RACSignal *processedSignal = [[RACSignal return:@"missiles"]map:^id(id value) {
        missilesToLaunch ++;
        return [NSString stringWithFormat:@"will launch : %d %@",missilesToLaunch,value];
    }];
    
    [processedSignal subscribeNext:^(id x) {
//        NSLog(@"frist:%@",x);
    }];
    
    [processedSignal subscribeNext:^(id x) {
//        NSLog(@"second : %@",x);
    }];
    
    
    
    RACMulticastConnection *connection = [processedSignal multicast:[RACReplaySubject subject]];
    [connection connect];
    
    [connection.signal subscribeNext:^(id x) {
//        NSLog(@"subscriber one:%@",x);
    }];
    [connection.signal subscribeNext:^(id x) {
//        NSLog(@"subscriber two:%@",x);
    }];
    
    
    RACSignal *doNextSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"原本"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    //这里是不执行的
    [doNextSignal doNext:^(id x) {
        NSLog(@"未接收:%@",x);
    }];
    
    //这里接收之前的信号 重新发射信号
    RACSignal* changSignal = [doNextSignal doNext:^(id x) {
        NSLog(@"doNext:%@",x);
        
    }];
    
    [changSignal subscribeNext:^(id x) {
        NSLog(@"接收SubNext : %@",x);
    }];
    [doNextSignal subscribeNext:^(id x) {
//        NSLog(@"未接收subNext:%@",x);
    }];
    
    
    /**
     *  @author Tankch, 15-07-21 09:07:40
     *
     *  disTinCuntilchange 如果发现之前的信号和现在的信号内容一样,则忽略掉
     *
     *  @param self
     *  @param name
     *
     *  @return name的变化
     */
    RACSignal *distincUntilChange = [RACObserve(self, name)distinctUntilChanged];
    
    [distincUntilChange subscribeNext:^(NSString *name) {
        NSLog(@"%@",name);
    }];
    
    self.name = @"Tank";
    self.name = @"陈逗比";
    self.name = @"陈逗比";     //这次由于型号标记为distinCuntilChange 所以没打印
    self.name = @"Tank";
    
    /**
     *  @author Tankch, 15-07-21 10:07:19
     *
     *  startWith 相当于 给signal组数 第一个赋予默认值
     */
    self.currentState = @"周觅";
    RACSignal *startWithSignal = [RACObserve(self, sendState)startWith:self.currentState];
    self.sendState = @"觅儿";
    [startWithSignal subscribeNext:^(NSString *state) {
        //打印了两个 先打周觅 再打觅儿
        NSLog(@"state%@",state);
    }];
    
    NSLog(@"sendstate:%@",_sendState);
    NSLog(@"currentState%@",_currentState);
    
    RAC(self.label,text) = RACObserve(self,labelText);
    self.labelText = @"黄";
    self.labelText = @"子";
    self.labelText = @"嘉";
    
    
    
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
