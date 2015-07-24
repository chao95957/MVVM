//
//  fristViewController.m
//  RACDome
//
//  Created by zsl-mac on 15/7/2.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "fristViewController.h"
#import <ReactiveCocoa.h>

@interface fristViewController ()

@end

@implementation fristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
//    [[self.userTextField.rac_textSignal filter:^BOOL(NSString *text) {
//        return text.length > 3;
//    }]
//    subscribeNext:^(NSString *test) {
//        NSLog(@"%@",test);
//    }];
    
    
    //map 的作用就是 转换器, 转换出你想要的数据
//    [[[self.userTextField.rac_textSignal filter:^BOOL(NSString *text) {
//        return text.length > 3;
//    }]
//    map:^id(NSString *value) {
//        return @(value.length);
//    }]
//    subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    
    //创建信号源     如果是字符串长度大于0 则返回yes
    RACSignal *usernameSignal = [self.userTextField.rac_textSignal map:^id(NSString *text) {
        return @([self isValidUsername:text]);
    }];
    RACSignal *passwordSignal = [self.passWordTextFiled.rac_textSignal map:^id(NSString* text) {
        return @([self isValidPassWord:text]);
    }];
    
    //绑定UI和信息
    [[usernameSignal map:^id(NSNumber *usernameVaild) {
        return [usernameVaild boolValue]?[UIColor clearColor] : [UIColor yellowColor];
    }]
    subscribeNext:^(UIColor *color) {
        self.userTextField.backgroundColor = color;
    }];
    
    //写法和上面相同
//    RAC(self.userTextField,backgroundColor) = [usernameSignal map:^id(NSNumber* usernameVaild) {
//        return [usernameVaild boolValue]?[UIColor clearColor]:[UIColor redColor];
//    }];
    
    RAC(self.passWordTextFiled,backgroundColor) = [passwordSignal map:^id(NSNumber* passwordVaild) {
        return [passwordVaild boolValue]?[UIColor clearColor] : [UIColor redColor];
    }];
    
    
    //聚合
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[usernameSignal,passwordSignal] reduce:^id(NSNumber* usernameValid,NSNumber* passwordValid){
        return @([usernameValid boolValue]&&[passwordValid boolValue]);
    }];
    
    //信号聚合后 做处理事件
    [signUpActiveSignal subscribeNext:^(NSNumber* x) {
        self.activeButton.selected = [x boolValue];
    }];
    
    
    
    
    
    //更新UI
    self.userTextField.backgroundColor = usernameSignal ? [UIColor clearColor]:[UIColor redColor];
    self.passWordTextFiled.backgroundColor = passwordSignal ? [UIColor clearColor] : [UIColor redColor];
    
    
    //按钮的RAC
    
    [[self.activeButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"click Button");
    }];
    
}


- (BOOL)isValidUsername : (NSString *)text
{
    if (text.length>0) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidPassWord : (NSString *)text
{
    if (text.length > 0) {
        return YES;
    }
    return NO;
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
