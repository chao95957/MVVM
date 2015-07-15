//
//  GoodDetailModel.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/9.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "GoodDetailModel.h"

@implementation GoodDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"companyName" : @"companyName",
             @"linkman" : @"linkman",
             @"manufacturer" : @"manufacturer",
             @"material" : @"material"
             };
    
}



@end
