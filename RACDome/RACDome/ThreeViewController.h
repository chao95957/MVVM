//
//  ThreeViewController.h
//  RACDome
//
//  Created by zsl-mac on 15/7/22.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "ViewController.h"
#import "ThreeViewModel.h"

@interface ThreeViewController : ViewController

@property (nonatomic,strong) ThreeViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;

@property (weak, nonatomic) IBOutlet UILabel *descrition;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

- (id)initWithViewModel : (ThreeViewModel *)viewModel;

@end
