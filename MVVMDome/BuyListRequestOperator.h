//
//  BuyListRequestOperator.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/16.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "BaseRequstOperator.h"

@interface BuyListRequestOperator : BaseRequstOperator
- (RACSignal *)getBuyListWithPageNum : (NSInteger)pageNum;

@end
