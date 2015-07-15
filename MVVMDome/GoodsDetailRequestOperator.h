//
//  GoodsDetailRequestOperator.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/7.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "BaseRequstOperator.h"
#import "GoodsListModel.h"
#import "GoodDetailModel.h"


@interface GoodsDetailRequestOperator : BaseRequstOperator
@property (nonatomic,strong)  GoodsListModel *model;

- (RACSignal *)getDetailByID : (NSString *)eventID;



@end
