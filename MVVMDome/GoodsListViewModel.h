//
//  GoodsListViewModel.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "BaseServerDataListViewModel.h"
#import "GoodsListRequestOperator.h"
#import "GoodsListModel.h"
#import "GoodsCellViewModel.h"

@interface GoodsListViewModel : BaseServerDataListViewModel

@property (nonatomic,strong) GoodsListRequestOperator *goodsRequest;
@property (nonatomic, strong) NSMutableArray *cellViewModelArray;
@property (nonatomic, strong) searchModel *searchModel;


- (GoodsCellViewModel *)cellViewModelAtIndex:(NSInteger)index;


@end
