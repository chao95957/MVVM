//
//  BuyListRequestOperator.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/16.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "BuyListRequestOperator.h"
#import "BuyListModel.h"
@implementation BuyListRequestOperator

- (RACSignal *)getBuyListWithPageNum : (NSInteger)pageNum
{
    @weakify(self);
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSDictionary *parameter = @{
                                    @"app" : @"purchase",
                                    @"page" : @(pageNum)
                                    };
        
        [LZCNetworkCenter GETRequestDataWithUrl:LINE parameters:parameter success:^(AFHTTPRequestOperation *operation) {
            
            NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:0 error:nil];
            NSDictionary *purchaseList = [rootDict objectForKey:@"purchase_list"];
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < purchaseList.count; i++) {
                NSDictionary *dict = [purchaseList objectForKey:[NSString stringWithFormat:@"%d",i]];
                BuyListModel *model = [MTLJSONAdapter modelOfClass:[BuyListModel class] fromJSONDictionary:dict error:nil];
                [resultArray addObject:model];
                
            }
            
            [subscriber sendNext:resultArray];
            [subscriber sendCompleted];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }]doError:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    return signal;
}


@end
