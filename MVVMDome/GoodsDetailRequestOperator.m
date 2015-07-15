//
//  GoodsDetailRequestOperator.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/7.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "GoodsDetailRequestOperator.h"




@implementation GoodsDetailRequestOperator


- (RACSignal *)getDetailByID:(NSString *)eventID
{
    //先判断eventID 是否有值
    APP_ASSERT(eventID);
    
    @weakify(self);
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        //模拟数据
        GoodDetailModel *detailModel = [[GoodDetailModel alloc]init];
        detailModel.companyName = @"陈逗比";
        detailModel.manufacturer = @" 你是";
        detailModel.material = @"逗比吗";
        detailModel.linkman = @"?";
        
        [subscriber sendNext:detailModel];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
        
    }]doError:^(NSError *error) {
       
        
    }];
    
}


@end
