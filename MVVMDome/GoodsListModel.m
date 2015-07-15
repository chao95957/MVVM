//
//  GoodsListModel.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "GoodsListModel.h"

@implementation GoodsListModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"companyName" : @"company_name",
             @"linkman" : @"linkman",
             @"manufacturer" : @"manufacturer",
             @"material" : @"material",
             @"mobile" : @"mobile",
             @"modify" : @"modify",
             @"name" : @"name",
             @"onsale_number" : @"onsale_number",
             @"price" : @"price",
             @"warehouse" : @"warehouse",
             @"city" : @"city",
             @"pid" : @"pid"
             };
}


@end
