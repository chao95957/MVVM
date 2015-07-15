//
//  GoodsListTableViewCell.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/7.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsCellViewModel.h"

@interface GoodsListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fristLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *tokenBtn;
@property (weak, nonatomic) IBOutlet UILabel *tokenLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLayout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayout;

+ (GoodsListTableViewCell *)cellFromXib;
+ (CGFloat)cellHeight;
- (void)showWithViewModel:(GoodsCellViewModel *)viewModel;

@end
