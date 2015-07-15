//
//  GoodsDetailViewController.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/9.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "BaseViewController.h"

@interface GoodsDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *fristLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end
