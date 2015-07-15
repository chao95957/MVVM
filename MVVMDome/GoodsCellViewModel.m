//
//  GoodsCellViewModel.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "GoodsCellViewModel.h"

@interface GoodsCellViewModel()

@property (nonatomic,strong) GoodsListModel *eventModel;


@end

@implementation GoodsCellViewModel


- (NSString *)fristLabelText
{
    APP_ASSERT(_eventModel);
    return [NSString stringWithFormat:@"%@ %@ %@",_eventModel.name,_eventModel.material,_eventModel.manufacturer];
}

- (NSString *)secondLabelText
{
    APP_ASSERT(_eventModel);
    
    return [NSString stringWithFormat:@"%@ 吨 所在地：%@ %@",_eventModel.onsale_number,_eventModel.city,_eventModel.warehouse];
}
- (NSString *)priceLabelText
{
    APP_ASSERT(_eventModel);
    return [NSString stringWithFormat:@"￥%@",_eventModel.price];
}
- (NSString *)createLabelText
{
    APP_ASSERT(_eventModel);
    return _eventModel.modify;
}
- (NSString *)tokenLabelText
{
    APP_ASSERT(_eventModel);
    return @"委托采购";
}


- (void)setDataModel:(GoodsListModel *)model
{
    APP_ASSERT(model);
    _eventModel = model;
}


@end
