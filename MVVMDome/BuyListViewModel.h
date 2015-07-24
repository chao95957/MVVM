//
//  BuyListViewModel.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/16.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "BaseServerDataListViewModel.h"
#import "BuyListRequestOperator.h"
@interface BuyListViewModel : BaseServerDataListViewModel


@property (nonatomic,strong) BuyListRequestOperator *buyListRequestOperator;

@end
