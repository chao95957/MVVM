//
//  GoodsDetailViewController.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/9.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsDetailViewModel.h"

@interface GoodsDetailViewController ()
{
    
}
@property (nonatomic,strong) GoodsDetailViewModel *viewmodel;
@property (nonatomic,copy) NSString *eventID;


@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //初始化model
    _viewmodel = [[GoodsDetailViewModel alloc]initWitheventID:self.eventID];
    //初始化UI
    [self initUI];
    //绑定 UI 和 Viewmodel
    [self bindWithViewModel];
    
    
    
    
}

- (void)initUI
{
    
}

- (void)bindWithViewModel
{
    
    //将View 绑定 ViewModel  RAC(接收者) = RACObserve(发送者);
    //这里特此说明下 RACObserve(self.viewmodel , fristString) 和 RACObserve(self,viewmodel.fristString)
    //有点不同,
    RAC(self.fristLabel , text) = RACObserve(self.viewmodel, fristString);
    RAC(self.secondLabel , text) = RACObserve(self.viewmodel, secondString);
    RAC(self.threeLabel , text) = RACObserve(self.viewmodel, threeString);
    RAC(self.fourLabel , text) = RACObserve(self.viewmodel, fourString);
    
    //这个是将 textfield text 与 viewmodel 的textfieldString 进行绑定 传值
    RAC(self.viewmodel,textfieldString) = RACObserve(self.textfield, text);
    
    //这个方法 textfield 发生变化就执行一次 在这里赋值
    [self.textfield.rac_textSignal subscribeNext:^(NSString *string) {
        self.viewmodel.textfieldString = string;
    }];
    
    //下面将是按钮RAC
    self.submitButton.rac_command = [_viewmodel getSubmitButtonCommand];
    
    //
//    [[self.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//              //按钮执行的函数
//    }];
    
    
    
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
