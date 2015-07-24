//
//  ViewController.m
//  RACDome
//
//  Created by zsl-mac on 15/7/2.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa.h>
#import "fristViewController.h"
#import "SecondViewController.h"
#import "ThreeViewModel.h"
#import "ThreeViewController.h"


@interface ViewController ()

@property (nonatomic,copy) NSString *username;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //username 发生变化就答应;
//    [RACObserve(self, username) subscribeNext:^(NSString *newName) {
//        NSLog(@"%@",newName);
//    }];
//    self.username = @"1";
//    self.username = @"3";
    
    [[RACObserve(self, username) filter:^BOOL(NSString *newName) {
        return [newName hasPrefix:@"j"];    //给字符串加条件
    }]subscribeNext:^(NSString *newName) {
        NSLog(@"00%@",newName);             //返回相应的方法
    }];
    
//    self.username = @"jsdfwer";
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 100)];
    textLabel.text = _username;
    [self.view addSubview:textLabel];
    
    //两个方法一样
//    @weakify(self);
//    [[self.secendButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//        @strongify(self);
//        SecondViewController *rvc = [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
//        [self.navigationController pushViewController:rvc animated:YES];
//    }];
//
    self.secendButton.rac_command = [self getSecandButtonCommand];
    
    RACSignal *buttonSignal = self.secendButton.rac_command.errors;
    [buttonSignal subscribeError:^(NSError *error) {
        NSLog(@"执行");
    }];
    
    self.RAC3Button.rac_command = [self ViewcontrollerAndViewModelCommand];
    
}


- (IBAction)next:(id)sender {
    fristViewController *rvc = [[fristViewController alloc]initWithNibName:@"fristViewController" bundle:nil];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:rvc];
    [self.navigationController pushViewController:rvc animated:YES];
    
    
}
- (RACCommand *)getSecandButtonCommand
{
    @weakify(self);
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        SecondViewController *rvc = [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
        [self.navigationController pushViewController:rvc animated:YES];
        return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"1"];
            [subscriber sendError:nil];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }]doError:^(NSError *error) {
            
        }];
    }];
    
    return command;
}

- (RACCommand *)ViewcontrollerAndViewModelCommand
{
    @weakify(self)
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
       @strongify(self)
        //在这里初始化viewmodel
        ThreeViewModel *viewmodel = [[ThreeViewModel alloc]init];
        
        ThreeViewController *rvc = [[ThreeViewController alloc]initWithViewModel:viewmodel];
        
        [self.navigationController pushViewController:rvc animated:YES];
        
        return [RACSignal empty];
    }];
    return command;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
