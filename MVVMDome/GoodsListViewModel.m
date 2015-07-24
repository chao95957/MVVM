//
//  GoodsListViewModel.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "GoodsListViewModel.h"
#import "GoodsCellViewModel.h"


@implementation GoodsListViewModel

- (id)init
{
    self = [super init];
    if (self) {
        //cellViewmodel 数组
        _cellViewModelArray = [[NSMutableArray alloc]init];
        //网络层初始化
        _goodsRequest = [[GoodsListRequestOperator alloc]init];
    }
    return self;
}

- (GoodsCellViewModel *)cellViewModelAtIndex:(NSInteger)index
{
    //判断数组是不是为空的
    APP_ASSERT(_cellViewModelArray);
    GoodsCellViewModel *model;
    //获取 cell 的 viewModel
    if (index >=0 && index < _cellViewModelArray.count) {
        model = _cellViewModelArray[index];
    }
    return model;
}

- (void)loadMore
{
    self.isNoMore = @(NO);
    
    //请求的数据
    @weakify(self);
    //在这里 跟网络层打交道 Viewmodel是viewcontroller 和 网络层的一条桥梁
    [[[_goodsRequest getEventListWithPageNum:self.pageNum] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSMutableArray* goodsListArray) {
        @strongify(self);
        /**
         *  @author Tankch, 15-07-07 19:07:36
         *
         *  goodsListArray 是网络层 那边绑定好的信号体
         */
        if (goodsListArray && goodsListArray.count > 0) {
            //如果信号体 有数据 则页数加1
            self.pageNum ++;
            
            for (GoodsListModel *model in goodsListArray) {
                [self.dataArray addObject:model];
                //初始化cell model
                GoodsCellViewModel *cellModel = [[GoodsCellViewModel alloc]init];
                //给cellmodel 设置dataModel
                [cellModel setDataModel:model];
                
                [self.cellViewModelArray addObject:cellModel];
                
            }
            //获取页面的个数
            self.appendItemCount = @(goodsListArray.count);
            //判断是否为页尾
            if (goodsListArray.count < self.pageSize) {
                self.isNoMore = @(YES);
            }
        }else
        {
            //请求错误
            self.isNoMore = @(YES);
            
        }
        
    }
     error:^(NSError *error) {
         self.isRequestError = @(YES);
     }];
    
    
    
    
}



@end
