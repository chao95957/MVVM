//
//  BaseServerDataListViewModel.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseServerDataListViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;        //源数组
@property (nonatomic, assign) NSInteger pageSize;       //页 容积
@property (nonatomic, assign) NSInteger pageNum;        //页 个数

@property (nonatomic, strong) NSNumber *isNoMore;       //是没有更多数据
@property (nonatomic, strong) NSError *requestError;    //请求错误
@property (nonatomic, strong) NSNumber *appendItemCount;//拼接个数

//item的个数
- (NSInteger)itemCount;

//刷新列表
- (void)refreshList;

//请求加载更多
- (void)loadMore;



@end
