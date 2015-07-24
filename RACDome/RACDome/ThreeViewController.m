//
//  ThreeViewController.m
//  RACDome
//
//  Created by zsl-mac on 15/7/22.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "ThreeViewController.h"


@interface ThreeViewController ()


@end

@implementation ThreeViewController



- (id)initWithViewModel : (ThreeViewModel *)viewModel
{
    self = [self initWithNibName:@"ThreeViewController" bundle:nil];
    if (self) {
        _viewModel = viewModel;
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
//    self.startButton.rac_command = self.viewModel.operationCommand;
    self.startButton.rac_command = [self.viewModel startTiemCommand];
    
    [self bindingViewControllerAndViewModel];
}

- (void)bindingViewControllerAndViewModel
{
    RACSignal *signal = RACObserve(self.viewModel, sendString);
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //1 未按 0按下
    [_viewModel.operationCommand.enabled subscribeNext:^(id x) {
        NSLog(@"enabled:%@",x);
    }];
    
    //errors:Error Domain=123 Code=1 "The operation couldn’t be completed. (123 error 1.)" UserInfo=0x7fd1e3c14790 {1=1}
    [_viewModel.operationCommand.errors subscribeNext:^(id x) {
        NSLog(@"errors:%@",x);
    }];
    
    // 0 未按 1按下
    [_viewModel.operationCommand.executing subscribeNext:^(id x) {
        NSLog(@"executing:%@",x);
        
    }];
    //executionSignals:<RACDynamicSignal: 0x7fd1e3db4350> name:
    [_viewModel.operationCommand.executionSignals subscribeNext:^(id x) {
        NSLog(@"executionSignals:%@",x);
    }];
    
    RACSubject *error = [RACSubject new];
    [_viewModel.operationCommand.errors subscribe:error];
    [error subscribeNext:^(id x) {
        NSLog(@"errorNext:%@",x);
    }error:^(NSError *error) {
//        NSLog(@"error:%@",error);
    }completed:^{
        NSLog(@"completed");
    }];
    
    RAC(self.textLabel,text) = RACObserve(self.viewModel,title);
    
    self.cancleButton.rac_command = [_viewModel cancleButtonCommand];
    
    [RACObserve(self.viewModel, isRequestFinished)subscribeNext:^(NSNumber* isRequestFinish) {
        if ([isRequestFinish boolValue]) {
            NSLog(@"请求完成");
        }else
        {
            NSLog(@"请求未完成");
        }
    }];
    
    [RACObserve(self.viewModel, RequestError)subscribeNext:^(NSError* x) {
        NSLog(@"error%@:",x);
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
