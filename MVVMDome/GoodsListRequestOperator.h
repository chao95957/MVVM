//
//  GoodsListRequestOperator.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/7.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "BaseRequstOperator.h"
#import "searchModel.h"

/**
 *  @author Tankch, 15-07-07 19:07:37
 *
 *  这个类主要用于 列表
 */

@interface GoodsListRequestOperator : BaseRequstOperator


- (RACSignal *)getGoodsListWithUrl : (NSString *)Url;

- (RACSignal *)getEventListWithPageNum:(NSInteger)pageSize;


@end
