//
//  GoodsListRequestOperator.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/7.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "GoodsListRequestOperator.h"
#import "GoodsListModel.h"

@implementation GoodsListRequestOperator


- (RACSignal *)getGoodsListWithUrl : (NSString *)Url
{
    @weakify(self);
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       @strongify(self);
        self.afRequestManager = [AFHTTPRequestOperationManager manager];
        self.afRequestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self.afRequestManager.requestSerializer setTimeoutInterval:30];
        [self.afRequestManager GET:Url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:0 error:nil];
            //转化成model
            for (int i = 0 ; i < rootDict.count; i++) {
                NSDictionary *dict = [rootDict objectForKey:[NSString stringWithFormat:@"%d",i]];
//                GoodsListModel *goodsModel = [GoodsListModel modelWithDictionary:dict error:nil]; 
                GoodsListModel *goodsModel = [[GoodsListModel alloc]init];
                goodsModel.companyName = dict[@"company_name"];
                goodsModel.linkman = dict[@"linkman"];
                goodsModel.manufacturer = dict[@"manufacturer"];
                goodsModel.material = dict[@"material"];
                goodsModel.mobile = dict[@"mobile"];
                goodsModel.modify = dict[@"modify"];
                goodsModel.name = dict[@"name"];
                goodsModel.onsale_number = dict[@"onsale_number"];
                goodsModel.price = dict[@"price"];
                goodsModel.warehouse = dict[@"warehouse"];
                goodsModel.city = dict[@"city"];
                [resultArray addObject:goodsModel];
            }
            
            //将数据捆版到signal
            [subscriber sendNext:resultArray];
            [subscriber sendCompleted];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //将
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^
                {
                    NSLog(@"clear up");
                }];
    }] doError:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

- (RACSignal *)getEventListWithPageNum:(NSInteger)pageNum
{
    @weakify(self);
    NSMutableString *strURL = [[NSMutableString alloc] initWithString:@""];
    [strURL appendString:[NSString stringWithFormat:@"%@",PL_GOODS_URL]];
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
    [dicParam setObject:@(pageNum) forKey:@"page"];
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        self.afRequestManager = [AFHTTPRequestOperationManager manager];
        self.afRequestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self.afRequestManager.requestSerializer setTimeoutInterval:30];
        [self.afRequestManager GET:strURL parameters:dicParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:0 error:nil];
            //转化成model
            for (int i = 0 ; i < rootDict.count; i++) {
                NSDictionary *dict = [rootDict objectForKey:[NSString stringWithFormat:@"%d",i]];
                //                GoodsListModel *goodsModel = [GoodsListModel modelWithDictionary:dict error:nil];
                GoodsListModel *goodsModel = [[GoodsListModel alloc]init];
                goodsModel.companyName = dict[@"company_name"];
                goodsModel.linkman = dict[@"linkman"];
                goodsModel.manufacturer = dict[@"manufacturer"];
                goodsModel.material = dict[@"material"];
                goodsModel.mobile = dict[@"mobile"];
                goodsModel.modify = dict[@"modify"];
                goodsModel.name = dict[@"name"];
                goodsModel.onsale_number = dict[@"onsale_number"];
                goodsModel.price = dict[@"price"];
                goodsModel.warehouse = dict[@"warehouse"];
                goodsModel.city = dict[@"city"];
                [resultArray addObject:goodsModel];
            }
            
            //将数据捆版到signal
            [subscriber sendNext:resultArray];
            [subscriber sendCompleted];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //将
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^
                {
                    NSLog(@"clear up");
                }];
    }] doError:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}



@end
