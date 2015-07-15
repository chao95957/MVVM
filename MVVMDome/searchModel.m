//
//  searchModel.m
//  SearchPlastic
//
//  Created by zsl-mac on 14/12/18.
//  Copyright (c) 2014年 zsl-mac. All rights reserved.
//

#import "searchModel.h"

@implementation searchModel

- (id)init
{
    self = [super init];
    if (self) {
        _city = @"0";
        _time = @"0";
        _keyword = @"1";
        _sort = @"0";
                
    }
    return self;
}
//http://app.zhaosuliao.test/?app=product&city=广州&time=15&sort=1&keyword=ABS&page=3

- (NSString *)getUrlWithCity:(NSString *)city time : (NSString *)time keyword : (NSString *)keyword sort: (NSString *)sort page:(int)page
{
    NSMutableString *url = [[NSMutableString alloc]initWithString:PL_GOODS_URL];
    if (city != nil && ![city isEqualToString:@"全部地区"]) {
        [url appendString:[NSString stringWithFormat:@"&city=%@",city]];
    }
    if (time != nil) {
        [url appendString:[NSString stringWithFormat:@"&time=%@",time]];
    }
    if (![keyword isEqualToString:@""]) {
        [url appendString:[NSString stringWithFormat:@"&keyword=%@",keyword]];
    }
    if (sort != nil) {
        [url appendString:[NSString stringWithFormat:@"&sort=%@",sort]];
    }
    [url appendString:[NSString stringWithFormat:@"&page=%d",page]];

    NSString *string = [NSString stringWithFormat:@"%@",url];
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
    return string;
}

- (NSString *)appandurl : (NSString *)key value : (NSString *)value
{
    NSString *appUrl = [NSString stringWithFormat:@"&%@=%@",key,value];
    
    return appUrl;
    
}



@end
