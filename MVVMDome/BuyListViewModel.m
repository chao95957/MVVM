//
//  BuyListViewModel.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/16.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "BuyListViewModel.h"
#import "BuyListModel.h"

@implementation BuyListViewModel


- (id)init
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc]init];
        _buyListRequestOperator = [[BuyListRequestOperator alloc]init];
        
    }
    return self;
    
}


- (void)loadMore
{
    self.isNoMore = @(NO);
    @weakify(self);
    [[[_buyListRequestOperator getBuyListWithPageNum:self.pageNum]deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSMutableArray *dataArray) {
        @strongify(self);
        NSLog(@"dataArray:%@",dataArray);
        //如果数组有数据
        if (dataArray && dataArray.count>0) {
            //页数累加
            self.pageNum++;
            
            for (BuyListModel *model in dataArray) {
                [self.dataArray addObject:model];
            }
            self.appendItemCount = @(dataArray.count);
            if (dataArray.count < self.pageSize) {
                self.isNoMore = @(YES);
            }
        }else
        {
            self.isNoMore = @(YES);
        }

    }error:^(NSError *error) {
        self.isRequestError = @(YES);
    }];
    
    
}

@end
