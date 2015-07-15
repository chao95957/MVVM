//
//  BaseServerDataListViewModel.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "BaseServerDataListViewModel.h"

//定义两个常量
static const NSInteger sPageSize = 20;
static const NSInteger sPageNum = 1;


@implementation BaseServerDataListViewModel



- (id)init
{
    self = [super init];
    if (self) {
        _pageNum = sPageNum;
        _pageSize = sPageSize;
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    return self;
}

- (NSInteger)itemCount
{
    return (_dataArray ? _dataArray.count:0);
}

- (void)refreshList
{
    [_dataArray removeAllObjects];
    _pageNum = sPageNum;
    
    [self loadMore];
}

- (void)loadMore
{
    //子类必须要重载这个函数
    
    APP_ASSERT_STOP;
}


@end
