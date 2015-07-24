//
//  BuyListModel.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/16.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "BuyListModel.h"

@implementation BuyListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *dict = @{
                           @"city":@"city",
                           @"follow" : @"follow",
                           @"is_qq" : @"is_qq",
                           @"is_supply" : @"is_supply",
                           @"manufacturer" : @"manufacturer",
                           @"material" : @"material",
                           @"name" : @"name",
                           @"onsale_number" : @"onsale_number",
                           @"price" : @"price",
                           @"purchase_id" : @"purchase_id",
                           @"purchase_sn" : @"purchase_sn",
                           @"status" : @"status",
                           @"status_name" : @"status_name",
                           @"tel" : @"tel",
                           @"update_time" : @"update_time"
                           
                           };
    
    return dict;
}



@end
