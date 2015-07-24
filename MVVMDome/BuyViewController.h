//
//  BuyViewController.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "BaseListViewController.h"
#import "BuyListViewModel.h"

@interface BuyViewController : BaseListViewController


@property (nonatomic,strong) BuyListViewModel *buyListViewModel;

@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end
